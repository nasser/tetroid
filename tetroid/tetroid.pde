#include <EEPROM.h>

#include "types.h"

#define LCD      2    //LCD control line
#define BTN_RGHT 3
#define BTN_LEFT 4
#define BTN_ROTA 5

ttrd_screen* lcd;
ttrd_piece* piece;
unsigned int score=0;
unsigned int pace=50;
unsigned int p=pace;
short int last_button;

#define INCONCLUSIVE -1
int debouncedRead(int pin) {
  // enough room for every pin!
  static int pins[28];
  static long lastBounceTime = 0;
  static int bounceDelay = 50;

  // read pin state
  int reading = digitalRead(pin);
  
  if(reading != pins[pin])
    lastBounceTime = millis();
  
  pins[pin] = reading;
  
  if((millis() - lastBounceTime) > bounceDelay) {
    return reading;
  } else {
    return INCONCLUSIVE;
  }
}

byte get_highscore() {
  byte score_flag = EEPROM.read(1);
  
  if(score_flag == 0)
    return EEPROM.read(0);
  else
    return 0;
}

void set_highscore(byte new_score) {
  EEPROM.write(0, new_score);
  EEPROM.write(1, 0);
}

void setup(){
  pinMode (LCD,OUTPUT);
  digitalWrite(LCD,HIGH);
  delay(1000);
  sw_byte(22);
  sw_reset();  
  delay(100);
  sw_bl_on();
  ttrd_define_chars();
  
  Serial.begin(9600);
  randomSeed(analogRead(0));
}

unsigned int get_buttons() {
  unsigned int buttons=0;
  
  if(debouncedRead(BTN_RGHT) == HIGH) {
    if(last_button != BTN_RGHT)
      buttons |= 1 << BTN_RGHT;
    last_button = BTN_RGHT;
    
  } else if(debouncedRead(BTN_LEFT) == HIGH) {
    if(last_button != BTN_LEFT)
      buttons |= 1 << BTN_LEFT;
    last_button = BTN_LEFT;
    
  } else if(debouncedRead(BTN_ROTA) == HIGH) {
    if(last_button != BTN_ROTA)
      buttons |= 1 << BTN_ROTA;
    last_button = BTN_ROTA;
  } else {
    last_button = 0;
  }
  
  return buttons;
}

void wait_for_input() {
  while(!get_buttons()) delay(50);
}
void loop(){
  menu();
  delay(100);
  rotate_screen();
  delay(100);
  game();
  delay(100);
  game_over();
  delay(100);
}

void menu() {
  sw_reset();
  delay(100);
  
  char hs[4];
  itoa(get_highscore(), hs, 10);
  
  sw_cursor(4, 0);
  sw_string("TETROID v0.1a");
  sw_cursor(4, 1);
  sw_string("High Score: ");
  sw_string(hs);
  sw_cursor(2, 3);
  sw_string("Any key to start");
  
  wait_for_input();
}

void rotate_screen() {
  sw_cursor(2, 0);
  sw_string("Rotate the screen");
  sw_cursor(2, 1);
  sw_string("Arrows point down");
  
  sw_cursor(19, 0); sw_char_rarrow();
  sw_cursor(19, 1); sw_char_rarrow();
  sw_cursor(19, 2); sw_char_rarrow();
  sw_cursor(19, 3); sw_char_rarrow();
  
  sw_cursor(2, 3);
  sw_string("Any key to start");
  
  wait_for_input();
}

void game() {
  sw_reset();
  delay(100);
  
  score=0;
  pace=40;
  
  lcd = ttrd_screen_new_board();
  piece = ttrd_piece_new_rand();

  
  for(;;) {
    unsigned int buttons = get_buttons();
    
    if(buttons & (1 << BTN_RGHT)) ttrd_piece_move_right(piece);
    if(buttons & (1 << BTN_LEFT)) ttrd_piece_move_left(piece);
    if(buttons & (1 << BTN_ROTA)) ttrd_piece_rotate_right(piece);
  
    p--;
    
    if(p == 0) {
      p = pace;
    
      if(ttrd_piece_will_collide(piece, lcd)) {
        ttrd_piece_transfer_to_screen(piece, lcd);
        delay(pace);
        ttrd_screen_render(lcd, false);
        ttrd_piece_destroy(piece);
        piece = ttrd_piece_new_rand();
        
        // check for lines to clear
        for(short int i=0;i<18;i++) {
          if((lcd->raster[i] & 0xF) == 0xF) {
            ttrd_screen_clear_line(lcd, i);
            score++;
            i--;
          }
        }
        
        if(score%20 == 19) {
          pace *= 0.5;
        }
        
        // check for game over
        if(lcd->raster[1] & 0xF) break;
    
        
        ttrd_piece_move_right(piece);
        ttrd_piece_move_right(piece);
      }
      
      ttrd_screen_render(lcd, false);
      ttrd_piece_render(piece);
      ttrd_score_display(score);
      ttrd_piece_move_down(piece);
    }
    
    delay(5);
  }
  
  ttrd_screen_destroy(lcd);
  ttrd_piece_destroy(piece);
}

void game_over() {
  short int i;
  
  char scr[4];
  itoa(score, scr, 10);
  
  Serial.println("final score:");
  Serial.println(score);
  
  Serial.println("final score str:");
  Serial.println(scr);
  
  for(i=0;i<5;i++) {
    sw_bl_off();
    delay(500);
    sw_bl_on();
    delay(500);
  }
  
  sw_reset();
  delay(100);
  
  sw_bl_on();
  sw_cursor(6, 0);
  sw_string("GAME OVER");
  if(score > get_highscore()) {
    sw_cursor(1, 1);
    sw_string("New High Score: ");
    sw_string(scr);
    Serial.println("New High Score: ");
    Serial.println(scr);
    set_highscore(score);
  } else {
    sw_cursor(7, 1);
    
    sw_string("Score: ");
    sw_string(scr);
    Serial.println("Score: ");
    Serial.println(scr);

  }
  
  sw_cursor(0, 3);
  sw_string("Any key to restart");
  wait_for_input();
}
