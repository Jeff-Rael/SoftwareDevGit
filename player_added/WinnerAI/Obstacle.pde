class Obstacle{
  PVector pos;
  PVector size;

  Obstacle(int posx, int posy, int sizex, int sizey) {
    pos = new PVector(posx, posy);
    size = new PVector(sizex, sizey);
  }

  /* Draws the obstacle to screen using pos and size. */
  void show() {
    fill(0, 0, 0);
    stroke(0, 0, 0);
    rect(pos.x, pos.y, size.x, size.y);
    rect(pos.x + 700, pos.y, size.x, size.y);
  }
}
