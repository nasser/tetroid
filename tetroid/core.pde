byte brick[8] = {14, 31, 31, 31, 31, 23, 19, 14};
byte brick_clear[2][8] = {{12, 6, 13, 25, 11, 22, 19, 8},
                          {4, 2, 9, 16, 9, 18, 2, 8}};
byte tally[5][8] = {{31, 0, 0, 0, 0, 0, 0, 0},
                    {31, 0, 31, 0, 0, 0, 0, 0},
                    {31, 0, 31, 0, 31, 0, 0, 0},
                    {31, 0, 31, 0, 31, 0, 31, 0},
                    {31, 4, 31, 4, 31, 4, 31, 4}};

short int BRICK = 0;
short int BRICK_CLEAR_0 = 1;
short int BRICK_CLEAR_1 = 2;

short int TALLY_1 = 3;
short int TALLY_2 = 4;
short int TALLY_3 = 5;
short int TALLY_4 = 6;
short int TALLY_5 = 7;

ttrd_piece* ttrd_piece_new() {
  ttrd_piece* piece = (ttrd_piece*)malloc(sizeof(ttrd_piece));
  for(short int i=0;i<4;i++) piece->orients[i] = ttrd_screen_new();
  piece->current_orient = 0;
  return piece;
}

void ttrd_piece_destroy(ttrd_piece* piece) {
  for(short int i=0;i<4;i++) ttrd_screen_destroy(piece->orients[i]);
  free(piece);
}

ttrd_piece* ttrd_piece_new_o() {
  ttrd_piece* piece = ttrd_piece_new();
  
  // upright
  ttrd_screen_set_point(piece->orients[0], 0, 0);
  ttrd_screen_set_point(piece->orients[0], 1, 0);
  ttrd_screen_set_point(piece->orients[0], 0, 1);
  ttrd_screen_set_point(piece->orients[0], 1, 1);
  
  // right
  ttrd_screen_set_point(piece->orients[1], 0, 0);
  ttrd_screen_set_point(piece->orients[1], 1, 0);
  ttrd_screen_set_point(piece->orients[1], 0, 1);
  ttrd_screen_set_point(piece->orients[1], 1, 1);
  
  // upside down
  ttrd_screen_set_point(piece->orients[2], 0, 0);
  ttrd_screen_set_point(piece->orients[2], 1, 0);
  ttrd_screen_set_point(piece->orients[2], 0, 1);
  ttrd_screen_set_point(piece->orients[2], 1, 1);
  
  // left
  ttrd_screen_set_point(piece->orients[3], 0, 0);
  ttrd_screen_set_point(piece->orients[3], 1, 0);
  ttrd_screen_set_point(piece->orients[3], 0, 1);
  ttrd_screen_set_point(piece->orients[3], 1, 1);
  
  return piece;
}

ttrd_piece* ttrd_piece_new_i() {
  ttrd_piece* piece = ttrd_piece_new();
  
  // upright
  ttrd_screen_set_point(piece->orients[0], 0, 1);
  ttrd_screen_set_point(piece->orients[0], 1, 1);
  ttrd_screen_set_point(piece->orients[0], 2, 1);
  ttrd_screen_set_point(piece->orients[0], 3, 1);
  
  // right rotated
  ttrd_screen_set_point(piece->orients[1], 1, 0);
  ttrd_screen_set_point(piece->orients[1], 1, 1);
  ttrd_screen_set_point(piece->orients[1], 1, 2);
  ttrd_screen_set_point(piece->orients[1], 1, 3);
  
  // upside down
  ttrd_screen_set_point(piece->orients[2], 0, 1);
  ttrd_screen_set_point(piece->orients[2], 1, 1);
  ttrd_screen_set_point(piece->orients[2], 2, 1);
  ttrd_screen_set_point(piece->orients[2], 3, 1);
  
  // left
  ttrd_screen_set_point(piece->orients[3], 1, 0);
  ttrd_screen_set_point(piece->orients[3], 1, 1);
  ttrd_screen_set_point(piece->orients[3], 1, 2);
  ttrd_screen_set_point(piece->orients[3], 1, 3);


  
  return piece;
}


ttrd_piece* ttrd_piece_new_s() {
  ttrd_piece* piece = ttrd_piece_new();
  
  // upright
  ttrd_screen_set_point(piece->orients[0], 1, 1);
  ttrd_screen_set_point(piece->orients[0], 2, 1);
  ttrd_screen_set_point(piece->orients[0], 1, 2);
  ttrd_screen_set_point(piece->orients[0], 0, 2);
  
  // right rotated
  ttrd_screen_set_point(piece->orients[1], 1, 1);
  ttrd_screen_set_point(piece->orients[1], 1, 0);
  ttrd_screen_set_point(piece->orients[1], 2, 1);
  ttrd_screen_set_point(piece->orients[1], 2, 2);
  
  // upside down
  ttrd_screen_set_point(piece->orients[2], 1, 1);
  ttrd_screen_set_point(piece->orients[2], 2, 1);
  ttrd_screen_set_point(piece->orients[2], 1, 2);
  ttrd_screen_set_point(piece->orients[2], 0, 2);

  // left
  ttrd_screen_set_point(piece->orients[3], 1, 1);
  ttrd_screen_set_point(piece->orients[3], 1, 0);
  ttrd_screen_set_point(piece->orients[3], 2, 1);
  ttrd_screen_set_point(piece->orients[3], 2, 2);
  
  return piece;
}

ttrd_piece* ttrd_piece_new_z() {
  ttrd_piece* piece = ttrd_piece_new();
  
  // upright
  ttrd_screen_set_point(piece->orients[0], 1, 0);
  ttrd_screen_set_point(piece->orients[0], 0, 0);
  ttrd_screen_set_point(piece->orients[0], 1, 1);
  ttrd_screen_set_point(piece->orients[0], 2, 1);
  
  // right rotated
  ttrd_screen_set_point(piece->orients[1], 0, 1);
  ttrd_screen_set_point(piece->orients[1], 0, 2);
  ttrd_screen_set_point(piece->orients[1], 1, 0);
  ttrd_screen_set_point(piece->orients[1], 1, 1);
  
  // upside down
  ttrd_screen_set_point(piece->orients[2], 1, 0);
  ttrd_screen_set_point(piece->orients[2], 0, 0);
  ttrd_screen_set_point(piece->orients[2], 1, 1);
  ttrd_screen_set_point(piece->orients[2], 2, 1);
  
  // right rotated
  ttrd_screen_set_point(piece->orients[3], 0, 1);
  ttrd_screen_set_point(piece->orients[3], 0, 2);
  ttrd_screen_set_point(piece->orients[3], 1, 0);
  ttrd_screen_set_point(piece->orients[3], 1, 1);
  
  return piece;
}

ttrd_piece* ttrd_piece_new_l() {
  ttrd_piece* piece = ttrd_piece_new();
  
  // upright
  ttrd_screen_set_point(piece->orients[0], 0, 0);
  ttrd_screen_set_point(piece->orients[0], 0, 1);
  ttrd_screen_set_point(piece->orients[0], 1, 0);
  ttrd_screen_set_point(piece->orients[0], 2, 0);
  
  // right
  ttrd_screen_set_point(piece->orients[1], 0, 0);
  ttrd_screen_set_point(piece->orients[1], 0, 1);
  ttrd_screen_set_point(piece->orients[1], 0, 2);
  ttrd_screen_set_point(piece->orients[1], 1, 2);

  // upside down
  ttrd_screen_set_point(piece->orients[2], 0, 1);
  ttrd_screen_set_point(piece->orients[2], 1, 1);
  ttrd_screen_set_point(piece->orients[2], 2, 1);
  ttrd_screen_set_point(piece->orients[2], 2, 0);
  
  // left
  ttrd_screen_set_point(piece->orients[3], 0, 0);
  ttrd_screen_set_point(piece->orients[3], 1, 0);
  ttrd_screen_set_point(piece->orients[3], 1, 1);
  ttrd_screen_set_point(piece->orients[3], 1, 2);
  
  return piece;
}

ttrd_piece* ttrd_piece_new_j() {
  ttrd_piece* piece = ttrd_piece_new();
  
  // upright
  ttrd_screen_set_point(piece->orients[0], 0, 0);
  ttrd_screen_set_point(piece->orients[0], 1, 0);
  ttrd_screen_set_point(piece->orients[0], 2, 0);
  ttrd_screen_set_point(piece->orients[0], 2, 1);
  
  // right
  ttrd_screen_set_point(piece->orients[1], 0, 0);
  ttrd_screen_set_point(piece->orients[1], 0, 1);
  ttrd_screen_set_point(piece->orients[1], 0, 2);
  ttrd_screen_set_point(piece->orients[1], 1, 0);

  // upside down
  ttrd_screen_set_point(piece->orients[2], 0, 1);
  ttrd_screen_set_point(piece->orients[2], 1, 1);
  ttrd_screen_set_point(piece->orients[2], 2, 1);
  ttrd_screen_set_point(piece->orients[2], 0, 0);
  
  // left
  ttrd_screen_set_point(piece->orients[3], 0, 2);
  ttrd_screen_set_point(piece->orients[3], 1, 0);
  ttrd_screen_set_point(piece->orients[3], 1, 1);
  ttrd_screen_set_point(piece->orients[3], 1, 2);
  
  return piece;
}

ttrd_piece* ttrd_piece_new_t() {
  ttrd_piece* piece = ttrd_piece_new();
  
  // upright
  ttrd_screen_set_point(piece->orients[0], 0, 0);
  ttrd_screen_set_point(piece->orients[0], 1, 0);
  ttrd_screen_set_point(piece->orients[0], 2, 0);
  ttrd_screen_set_point(piece->orients[0], 1, 1);
  
  // right rotated
  ttrd_screen_set_point(piece->orients[1], 1, 0);
  ttrd_screen_set_point(piece->orients[1], 1, 1);
  ttrd_screen_set_point(piece->orients[1], 1, 2);
  ttrd_screen_set_point(piece->orients[1], 0, 1);

  // upside down
  ttrd_screen_set_point(piece->orients[2], 0, 1);
  ttrd_screen_set_point(piece->orients[2], 1, 1);
  ttrd_screen_set_point(piece->orients[2], 2, 1);
  ttrd_screen_set_point(piece->orients[2], 1, 0);

  // upside down
  ttrd_screen_set_point(piece->orients[3], 0, 0);
  ttrd_screen_set_point(piece->orients[3], 0, 1);
  ttrd_screen_set_point(piece->orients[3], 0, 2);
  ttrd_screen_set_point(piece->orients[3], 1, 1);
  
  return piece;
}

ttrd_piece* ttrd_piece_new_rand() {
  int r = random(100);
  
  if(r < 7) 
    return ttrd_piece_new_i();
  else if(r >= 7 && r < 20)
    return ttrd_piece_new_o();
  else if(r >= 20 && r < 35)
    return ttrd_piece_new_j();
  else if(r >= 35 && r < 50)
    return ttrd_piece_new_l();
  else if(r >= 50 && r < 65)
    return ttrd_piece_new_z();
  else if(r >= 65 && r < 80)
    return ttrd_piece_new_s();
  else if(r >= 80)
    return ttrd_piece_new_t();
}

void ttrd_piece_move_down(ttrd_piece* piece) {
  for(short int i=0;i<4;i++) {
      for(short int j=18;j>0;j--) piece->orients[i]->raster[j] = piece->orients[i]->raster[j-1];
      piece->orients[i]->raster[0] = 0;
  }
}

void ttrd_piece_move_left(ttrd_piece* piece) {
  short int i;
  short int j;
  boolean collide;
  
  for(i=0;i<4;i++) {
    collide = 0;
    // collision detection
    for(j=0;j<19;j++) collide |= piece->orients[i]->raster[j] & 0x1;
    // move if not colliding
    if(!collide) for(j=0;j<19;j++) piece->orients[i]->raster[j] >>= 1;
  }
}

void ttrd_piece_move_right(ttrd_piece* piece) {
  short int i;
  short int j;
  boolean collide;
  
  for(i=0;i<4;i++) {
    collide = 0;
    // collision detection
    for(j=0;j<19;j++) collide |= piece->orients[i]->raster[j] & 0x8;
    // move if not colliding
    if(!collide) for(j=0;j<19;j++) piece->orients[i]->raster[j] <<= 1;
  }
}

void ttrd_piece_rotate_right(ttrd_piece* piece) {
  piece->current_orient++;
  piece->current_orient %= 4;
}

void ttrd_piece_rotate_left(ttrd_piece* piece) {
  piece->current_orient--;
  piece->current_orient %= 4;
}

void ttrd_piece_render(ttrd_piece* piece) {
  ttrd_screen_render(piece->orients[piece->current_orient], true);
}

void ttrd_piece_transfer_to_screen(ttrd_piece* piece, ttrd_screen* screen) {
  for(short int i=0;i<19;i++) screen->raster[i] |= piece->orients[piece->current_orient]->raster[i];
}

boolean ttrd_piece_will_collide(ttrd_piece* piece, ttrd_screen* screen) {
  for(short int i=0;i<18;i++)
    if(screen->raster[i+1] & piece->orients[piece->current_orient]->raster[i]) 
      return true;
      
  return false;
}








/**
 *  Draw a brick to the specified coordinates
 * 
 *  Coordinates are corrected for rotated screen
 */
void ttrd_draw_brick(short int x, short int y) {
  ttrd_cursor(x, y);
  sw_custom_char(BRICK);
}

ttrd_screen* ttrd_screen_new() {
  ttrd_screen* screen = (ttrd_screen*)malloc(sizeof(ttrd_screen));
  for(short int i=0;i<19;i++) screen->raster[i] = 0;
  return screen;
}

void ttrd_screen_destroy(ttrd_screen* screen) {
  free(screen);
}

ttrd_screen* ttrd_screen_new_board() {
  ttrd_screen* board = ttrd_screen_new();
  ttrd_screen_set_row(board, 18, 0xF);
  return board;
}

/**
 * Sets a point on screen 
 */
void ttrd_screen_set_point(ttrd_screen* screen, short int x, short int y) {
  screen->raster[y]|= 1 << x;
}

void ttrd_screen_set_row(ttrd_screen* screen, short int row, byte value) {
  screen->raster[row] = value;
}

void ttrd_screen_clear(ttrd_screen* screen) {
  for(short int i=0;i<19;i++) {
    ttrd_screen_set_row(screen, i, 0);
  }
}

void ttrd_clear(short int x, short int y) {
  ttrd_cursor(x, y);
  sw_char(' ');
}

/** 
 *  Draw a screen object to the lcd
 */
void ttrd_screen_render(ttrd_screen* screen, boolean overlay) {
  byte mask;
  short int i, j;
  
  for(j=0;j<19;j++) {
    if(!overlay) {
      ttrd_clear(0, j);
      ttrd_clear(1, j);
      ttrd_clear(2, j);
      ttrd_clear(3, j);
    }
    
    for(mask=0x08, i=0;mask>0;mask >>= 1,i++) {
      if(mask & screen->raster[j])
        ttrd_draw_brick(i, j);
    }
  }
}

void ttrd_cursor(short int x, short int y) {
  sw_cursor(y,x);
}

/** 
 * Clear a line, animate brick destruction, shift lines down 
 */
void ttrd_screen_clear_line(ttrd_screen* screen, short int line) {
  short int i;
  
  // animate the crumbling line
  delay(pace*5);
  for(i=0;i<4;i++) { ttrd_cursor(i, line); sw_custom_char(BRICK_CLEAR_0); }
  delay(pace*5);
  for(i=0;i<4;i++) { ttrd_cursor(i, line); sw_custom_char(BRICK_CLEAR_1); }
  delay(pace*5);
  for(i=0;i<4;i++) { ttrd_cursor(i, line); sw_char(' '); }
  
  // shift line contents down and clear top line
  for(i=line;i>0;i--) screen->raster[i] = screen->raster[i-1];
  screen->raster[0] = 0;
}



void ttrd_score_display(short int score) {
  short int x=0;
  short int fives = (score%20) / 5;
  short int ones = (score%20) % 5;
  short int i;
  
  for(i=0;i<fives;i++) {
      ttrd_cursor(i, 19);
      sw_custom_char(TALLY_5);
  }
  
  ttrd_cursor(i, 19);
  switch(ones) {
    case 1: sw_custom_char(TALLY_1);
    break;
    case 2: sw_custom_char(TALLY_2);
    break;
    case 3: sw_custom_char(TALLY_3);
    break;
    case 4: sw_custom_char(TALLY_4);
    break;
  }
  
//  while(i<3)
  
}


/** 
 *  Load custom characters into the lcd. run this in setup().
 *  custom characters are as follows
 *  
 *  0 : Brick
 *  1 : Brick Clear Anim Frame 0
 *  2 : Brick Clear Anim Frame 1
 *  3 : Score Tally 1
 *  4 : Score Tally 2
 *  5 : Score Tally 3
 *  6 : Score Tally 4
 *  7 : Score Tally 5
 */ 
void ttrd_define_chars() {
  sw_make_custom_char(BRICK, brick);
  sw_make_custom_char(BRICK_CLEAR_0, brick_clear[0]);
  sw_make_custom_char(BRICK_CLEAR_1, brick_clear[1]);
  sw_make_custom_char(TALLY_1, tally[0]);
  sw_make_custom_char(TALLY_2, tally[1]);
  sw_make_custom_char(TALLY_3, tally[2]);
  sw_make_custom_char(TALLY_4, tally[3]);
  sw_make_custom_char(TALLY_5, tally[4]);
}
