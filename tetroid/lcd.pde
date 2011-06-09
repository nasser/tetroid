#define bit96 100          //timing for 9.6Kbaud
#define halfBit96 50      // 1/9600 = .000104

void sw_byte(byte data) {
  byte mask;
  digitalWrite(LCD,LOW);                        //startbit
  delayMicroseconds(bit96);
  for (mask = 0x01; mask>0; mask <<= 1) {
    if ((data & mask) > 0){                          // choose bit
      digitalWrite(LCD,HIGH);                    // send 1
    }
    else{
      digitalWrite(LCD,LOW);                     // send 0
    }
    delayMicroseconds(bit96);
  }
  //stop bit
  digitalWrite(LCD, HIGH);
  delayMicroseconds(bit96);
}

void sw_char(char c) {
  sw_byte(c);
}


void sw_char_rarrow() {
  sw_byte(126);
}

void sw_char_larrow() {
  sw_byte(127);
}

void sw_string(char* data) {
  do {
    sw_byte((byte)*data++);
  } while(*data);
}

void sw_sprintf(char* str, ...) {
  //TODO Finish me
}

void sw_custom_char(short int c) {
  sw_byte(c);
}

void sw_reset() {
  sw_byte(12);
}

void sw_bl_off() {
  sw_byte(18);
}

void sw_bl_on() {
  sw_byte(17);
}

void sw_cursor(short int x, short int y) {
  sw_byte(128 + x + 20*y);
}

void sw_make_custom_char(short int id, byte* data) {
  sw_byte(248 + id);
  for(short int i=0;i<8;i++,*data++)
    sw_byte(*data);
}
