/**
 *  A screen object
 *  
 *  The play field is represented by a bitmask for each row
 */

typedef struct {
  char raster[19]; // an array of bytes
} ttrd_screen;

/**
 *  A tetroid piece
 */
typedef struct {
  ttrd_screen* orients[4];
  short int current_orient;
} ttrd_piece;
