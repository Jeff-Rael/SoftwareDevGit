Cell[] maze;
Particle[] bits;
int mazeWidth;
int mazeHeight;
int cellSize;
int totalCells;
int mazeStart;
int mazeGoal;
float mazeStartX;
float mazeStartY;

void setup() {
  size(600, 600); 
  background(0);
  mazeWidth = 20;
  cellSize = width / mazeWidth;
  mazeHeight = height / cellSize;
  totalCells = mazeWidth * mazeHeight;
  maze = new Cell[totalCells];

  makeMaze();

  bits = new Particle[10000];
  mazeStartX = ((maze[mazeStart].index % mazeWidth) * cellSize) + (cellSize / 2);
  mazeStartY = (floor(maze[mazeStart].index / mazeWidth) * cellSize) + (cellSize / 2);
  for (int i = 0; i < bits.length; i++) {
    float buffer = (cellSize / 2);
    bits[i] = new Particle(random(buffer, width-buffer), random(buffer, height - buffer));
  }
}

void mousePressed() {
  makeMaze();
}

void draw() {
  background(0);
  stroke(255);
  strokeWeight(1);
  for (int i = 0; i < totalCells; i++) {
    int x = i % mazeWidth;
    int y = floor(i / mazeWidth);
    pushMatrix();
    translate(x * cellSize, y * cellSize);
    maze[i].show(cellSize - 1);
    popMatrix();
  }

  for (Particle p : bits) {
    p.show();

    int mazeIndex = int((floor(p.pos.y / cellSize) * mazeWidth) + floor(p.pos.x / cellSize));    
    p.update(maze[mazeIndex].dir);
    if (mazeIndex == mazeGoal) { 
      float buffer = cellSize / 2;
      p.pos.x = random(buffer, width - buffer); 
      p.pos.y = random(buffer, height - buffer);
    }
  }
}

void makeMaze() {
  int mole = int(random(totalCells));
  ArrayList<Cell> openList = new ArrayList<Cell>();

  for (int i = 0; i < totalCells; i++) {
    maze[i] = new Cell(i);
  }

  boolean starting = true;
  int pathCount = 0;

  while (!openList.isEmpty() || starting) {
    starting = false;
    int waysCount = ways(mole);    
    if (waysCount > 1) openList.add(maze[mole]);
    maze[mole].pathScore = pathCount;
    pathCount++;
    if (waysCount > 0) {
      boolean goodDir = false;
      int dir = 0;
      while (!goodDir) {
        dir = int(random(4));
        goodDir = canGo(mole, dir);
      }

      switch(dir) {
      case 0:
        maze[mole].walls -= 1;        
        mole -= mazeWidth;       
        maze[mole].walls -= 4;
        break;
      case 1:
        maze[mole].walls -= 2;
        mole += 1;
        maze[mole].walls -= 8;
        break;
      case 2:
        maze[mole].walls -= 4;
        mole += mazeWidth;
        maze[mole].walls -= 1;
        break;
      case 3:
        maze[mole].walls -= 8;
        mole -= 1;
        maze[mole].walls -= 2;
        break;
      }
    } else {
      int t = openList.size() - 1; 
      int n = openList.get(t).index;
      openList.remove(t);
      mole = n;
      pathCount = maze[mole].pathScore;
    }
  }
  int highest = 0;
  for (int i = 0; i < totalCells; i++) {    
    if (maze[i].pathScore == 0) mazeGoal = i;
    if (maze[i].pathScore > highest) {
      highest = maze[i].pathScore;
      mazeStart = i;
    }
  }
    doDir();
}

void doDir() {
  for (int i = 0; i < totalCells; i++) {
    if (maze[i].pathScore != 0) {
      int targetScore = maze[i].pathScore - 1;    
      if (!maze[i].isWall(maze[i].walls, 1)) {
        if (maze[i-mazeWidth].pathScore == targetScore) {
          maze[i].dir = new PVector(0, -1);
        }
      }
      if (!maze[i].isWall(maze[i].walls, 2)) {
        if (maze[i+1].pathScore == targetScore) {
          maze[i].dir = new PVector(1, 0);
        }
      }
      if (!maze[i].isWall(maze[i].walls, 4)) {
        if (maze[i+mazeWidth].pathScore == targetScore) {
          maze[i].dir = new PVector(0, 1);
        }
      }
      if (!maze[i].isWall(maze[i].walls, 8)) {
        if (maze[i-1].pathScore == targetScore) {
          maze[i].dir = new PVector(-1, 0);
        }
      }
    }
  }
}

int ways(int pos) {
  int ways = 4;

  for (int i = 0; i < 4; i++) {
    if (!canGo(pos, i)) ways--;
  }
  return ways;
}

boolean canGo(int pos, int dir) {
  int x = pos % mazeWidth;
  int y = floor(pos / mazeWidth);
  int targetCell = pos;

  switch(dir) {
  case 0:
    if (y > 0) {
      targetCell = pos - mazeWidth;
    } else {
      return false;
    }
    break;
  case 1:
    if (x < mazeWidth - 1) {
      targetCell = pos + 1;
    } else {
      return false;
    }
    break;
  case 2:
    if (y < mazeHeight - 1) {
      targetCell = pos + mazeWidth;
    } else {
      return false;
    }
    break;
  case 3:
    if (x > 0) {
      targetCell = pos - 1;
    } else {
      return false;
    }
    break;
  }
  return (maze[targetCell].walls == 15);
}
