class Cell {
  int index;
  int walls;
  int pathScore;
  PVector dir;

  Cell(int n) {
    index = n;
    walls = 15;
    pathScore = 0;
    dir = new PVector(0,0);
  }

  void show(float size) {
    // assumes cell has been translated to correct position
    if (isWall(walls, 1)) line(0, 0, size, 0);
    if (isWall(walls, 2)) line(size, 0, size, size);
    if (isWall(walls, 4)) line(0, size, size, size);
    if (isWall(walls, 8)) line(0, 0, 0, size);    
    if(index == mazeGoal) {textSize(24);text("X", size/2 - 8, size/2 + 7);}
  }

  boolean isWall(int walls, int dir) {
    return (walls & dir) != 0;
  }
}
