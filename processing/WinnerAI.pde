Dot winner;
Maze maze;
Player player;

int rectX, rectYE, rectYM, rectYH, rectW, rectH;      // Position of square button
int rectSize = 90;     // Diameter of rect
color rectColor, baseColor;
color rectHighlight, circleHighlight;
color easyColor = color(55,212,47);
color mediumColor = color(235,221,23);
color hardColor= color(255,0,4);
color currentColor;
boolean rectOver = false;

  float goalX = 0;
  float goalY = 0;
  float sizeGX = 0;
  float sizeGY = 0;
  float startX = 0;
  float startY = 0;
  boolean easy = false;
  boolean medium = false;
  boolean hard = false;
  boolean chosenDiff = false;
  int difficulty;
  
  int step = 7; // pixel size of each step taken for the player
  boolean pos = true; // add
  boolean sub = false;
  
  float playerPosY;
  float playerPosX;
  
  int matr[][];
  long start;
  long finish;
  long timeElapsed;
  boolean unfinished = true; // when its false the score is calculated

int easyMaze[][] =             {{3,0,0,0,0,3,3,3,3,3,3,2,3,0,3,3,3,3,3,0},
                                {3,0,3,3,3,3,0,0,0,0,0,0,3,3,3,0,0,0,3,0},
                                {3,3,3,0,0,0,0,0,3,0,0,0,0,0,0,0,3,3,3,0},
                                {3,0,0,0,3,0,3,3,3,0,3,3,3,3,0,0,3,0,0,0},
                                {3,3,3,0,3,0,3,0,0,0,3,0,0,3,3,3,3,3,3,0},
                                {3,0,0,0,3,0,3,3,3,3,3,0,0,0,0,3,0,0,3,0},
                                {3,0,3,0,3,3,3,0,0,0,3,3,3,3,0,3,3,0,3,0},
                                {3,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0},
                                {3,0,3,3,3,3,3,0,3,3,0,3,0,3,3,3,3,0,3,0},
                                {0,0,0,0,3,0,0,0,3,0,0,3,0,3,0,0,3,0,3,0},
                                {0,3,3,0,3,3,0,0,3,0,3,3,3,3,3,0,3,3,3,0},
                                {0,3,0,0,0,3,0,0,3,0,3,0,0,0,3,0,0,0,0,0},
                                {0,3,3,3,3,3,0,3,3,0,3,0,0,3,3,3,3,3,3,0},
                                {0,3,0,0,0,3,0,3,0,0,3,0,0,0,0,0,0,0,3,3},
                                {0,0,0,0,0,3,3,3,3,3,3,0,3,3,3,3,0,0,0,3},
                                {0,3,3,3,0,0,0,0,0,0,0,0,0,3,0,3,3,0,0,3},
                                {0,0,0,3,0,3,3,3,3,0,3,3,0,3,0,0,0,0,3,3},
                                {0,3,0,3,0,0,0,0,3,0,0,3,0,3,3,3,3,0,3,0},
                                {3,3,3,3,3,0,3,3,3,0,0,3,3,3,0,3,0,0,3,0},
                                {1,0,0,0,3,3,3,0,3,3,3,3,0,0,0,3,3,3,3,0}};

int mediumMaze[][] = {{3,3,3,3,3,0,3,3,3,3,3,3,0,0,0,2,3,3,3,3,3,0,0,3,3,3,3,3,3,3,3},
                {0,3,0,0,3,3,3,0,3,0,0,3,3,3,3,3,3,0,0,0,3,3,3,3,0,0,0,0,0,0,3},
                {3,3,0,0,0,0,0,0,3,0,0,3,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,3},
                {3,0,0,0,3,3,3,3,3,0,3,3,3,0,3,3,3,0,3,3,3,3,3,3,3,3,3,3,3,3,3},
                {3,3,0,0,3,0,0,0,3,0,3,0,3,3,3,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0},
                {0,3,0,0,3,0,3,0,0,0,3,0,0,0,0,0,3,0,0,3,3,3,3,3,3,0,3,3,3,0,0},
                {0,3,0,0,3,0,3,3,3,3,3,3,3,3,0,0,3,0,0,0,0,3,0,0,0,0,0,0,3,0,0},
                {3,3,0,0,0,0,0,3,0,0,0,0,0,3,3,3,3,3,3,0,0,3,0,3,3,3,3,0,3,0,0},
                {3,3,3,3,3,3,0,3,0,0,0,3,0,3,0,3,0,0,3,3,0,3,0,3,0,3,0,0,3,0,0},
                {0,3,0,0,0,3,0,0,0,3,0,3,0,3,0,3,3,0,0,0,0,3,0,3,0,3,3,3,3,0,0},

                {0,3,0,3,3,3,3,3,0,3,3,3,3,3,0,0,3,3,3,3,3,3,0,3,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,3,0,0,0,3,0,3,0,3,0,0,3},
                {3,3,3,0,3,3,3,3,3,0,3,3,3,3,0,0,0,0,0,3,0,3,3,3,3,3,0,3,3,3,3},
                {3,0,3,0,0,0,0,0,3,0,3,0,3,0,0,3,3,3,0,3,0,3,0,0,0,0,0,0,0,0,3},
                {3,0,3,3,0,0,3,0,3,0,3,0,3,0,0,3,0,3,0,3,0,3,3,3,3,3,3,3,0,0,3},
                {0,0,0,3,3,3,3,0,3,3,3,0,3,0,0,3,0,3,0,3,0,0,0,0,0,0,0,3,0,0,3},
                {3,3,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,3,0,0,0,0,3,3,0,3,0,0,3},
                {0,3,0,3,0,0,0,0,3,3,3,3,3,3,3,3,0,3,3,3,0,0,3,0,0,3,3,3,3,3,3},
                {0,3,0,3,0,3,3,3,3,0,3,0,0,3,0,3,0,0,0,3,0,0,3,0,0,3,0,0,0,0,0},
                {0,3,0,3,3,3,0,0,3,0,3,3,0,0,0,3,3,3,3,3,0,0,3,3,3,3,0,3,3,0,0},

                {0,3,0,0,0,0,0,0,3,0,0,3,3,0,3,3,0,0,0,0,0,0,3,0,0,0,0,3,0,0,0},
                {0,3,3,3,3,3,0,0,3,0,0,0,0,0,3,0,0,0,0,3,3,3,3,0,3,3,3,3,3,3,0},
                {0,0,0,0,0,3,0,0,3,3,3,3,3,0,3,3,3,3,3,3,0,0,3,0,3,0,0,0,0,3,0},
                {3,3,3,0,3,3,3,0,3,0,0,0,3,0,0,0,0,0,0,0,0,0,3,0,3,0,3,0,3,3,0},
                {3,0,3,0,0,0,3,0,3,0,0,3,3,0,3,3,0,0,3,3,3,0,3,3,3,0,3,0,0,0,0},
                {3,0,3,0,3,0,3,0,0,0,0,3,0,0,0,3,3,0,3,0,3,0,0,0,0,0,3,3,3,3,3},
                {3,0,0,0,3,3,3,3,3,3,3,3,0,3,0,0,3,3,3,0,3,3,3,3,3,0,0,0,3,0,3},
                {3,3,3,0,3,0,0,0,0,3,0,0,0,3,3,0,0,0,0,0,0,0,0,0,3,3,3,3,3,0,3},
                {0,0,3,0,3,0,3,3,3,3,3,3,0,0,3,0,3,0,3,3,3,3,3,0,3,0,0,0,0,0,0},
                {0,0,3,3,3,0,0,0,0,0,0,3,3,3,3,1,3,3,3,0,3,0,0,0,3,3,3,3,0,0,0}};

int hardMaze[][] =  {{0,3,3,3,3,0,0,3,3,3,3,0,0,0,3,3,3,3,3,3,3,2,3,3,3,3,3,3,0,3,0,3,3,0,0,3,3,0,0,0,0,0},
                {0,3,0,0,3,3,3,3,0,0,0,0,3,3,3,0,0,0,0,0,3,3,0,0,0,0,0,3,0,3,0,3,0,0,0,0,3,3,3,3,0,0},
                {0,3,3,0,0,0,0,0,0,3,3,3,3,0,0,0,3,3,3,0,0,0,0,3,0,3,0,3,0,3,0,3,0,3,3,3,3,0,0,3,3,0},
                {0,3,0,0,0,3,0,3,3,3,0,0,0,0,3,0,3,0,3,3,3,3,3,3,3,3,0,3,3,3,0,3,3,3,0,0,3,3,0,0,3,0},
                {3,3,3,0,3,3,0,3,0,0,0,0,0,0,3,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,3,0},
                {3,0,3,0,3,0,0,3,3,0,3,3,3,3,3,0,3,3,3,3,3,3,0,0,3,0,0,3,3,3,3,3,0,3,3,3,3,3,3,0,3,0},
                {3,0,3,0,3,3,0,0,3,0,3,0,0,0,3,0,0,0,0,0,0,3,0,3,3,3,3,3,0,3,0,3,3,3,0,3,0,0,3,0,3,0},
                {3,0,0,0,0,3,3,3,3,3,3,0,3,0,3,3,3,3,3,0,3,3,3,3,0,0,0,3,0,0,0,3,0,0,0,0,0,0,0,0,0,0},
                {3,3,3,3,0,0,0,0,0,0,0,0,3,0,0,0,0,0,3,0,0,0,0,0,0,3,0,3,3,3,0,3,0,0,0,3,3,3,3,3,3,0},
                {0,3,0,3,0,3,3,3,0,3,3,0,3,3,3,3,0,3,3,3,3,3,3,3,3,3,0,0,0,0,0,3,0,0,3,3,0,3,0,0,0,0},

                {0,3,0,3,0,3,0,3,0,3,0,0,0,3,0,3,0,3,0,3,0,0,0,0,0,3,0,3,0,0,0,3,0,3,3,0,0,3,0,0,0,0},
                {0,3,0,3,3,3,0,3,3,3,0,3,0,3,0,3,0,3,0,3,0,0,3,3,3,3,3,3,3,3,3,3,0,0,0,0,0,3,0,0,0,0},
                {0,3,0,0,0,0,0,3,0,0,0,3,0,3,0,3,0,0,0,3,0,0,3,0,0,0,0,3,0,0,0,0,0,3,3,3,3,3,3,0,3,0},
                {0,3,3,3,3,3,0,3,3,3,3,3,0,0,0,3,3,3,3,3,0,3,3,3,0,3,3,3,3,3,3,0,0,3,0,0,0,0,3,0,3,0},
                {0,0,0,0,0,3,0,0,0,3,0,0,0,3,0,0,3,0,3,0,0,0,0,0,0,0,0,0,0,0,3,0,0,3,0,3,3,3,3,0,3,0},
                {3,3,3,3,0,0,0,0,0,3,0,0,3,3,0,3,3,0,3,0,3,0,0,0,3,3,3,3,0,0,3,3,3,3,0,0,0,0,3,3,3,0},
                {3,0,0,0,0,0,0,3,3,3,0,0,3,0,0,3,0,0,0,0,3,0,3,3,3,0,0,0,0,0,0,0,0,0,0,3,3,0,3,0,0,0},
                {3,3,3,3,3,3,3,3,0,0,0,0,3,3,3,3,0,3,3,3,3,0,3,0,3,3,3,3,3,3,3,3,0,3,0,3,0,0,3,0,3,0},
                {0,0,0,3,0,0,0,3,0,0,3,0,0,0,0,0,0,3,0,3,0,0,0,0,0,0,0,3,0,0,0,0,0,3,0,3,3,3,3,3,3,0},
                {0,0,3,3,0,3,0,3,3,3,3,3,3,0,0,0,3,3,0,3,3,3,3,3,3,3,3,3,0,0,3,3,3,3,0,3,0,0,0,0,3,0},

                {3,0,0,3,0,3,0,0,3,0,0,0,3,0,0,0,3,0,0,0,0,0,0,3,0,0,0,0,0,0,3,0,0,0,0,3,0,0,0,0,0,0},
                {3,0,0,0,0,3,3,3,3,0,3,0,3,0,0,0,3,0,3,3,3,3,3,3,0,0,3,3,3,3,3,3,3,0,3,3,0,0,3,3,3,0},
                {3,3,3,3,0,0,0,0,0,0,3,0,3,3,3,0,0,0,3,0,0,0,3,0,0,3,3,0,0,3,0,0,0,0,3,0,0,0,3,0,0,0},
                {0,0,0,3,0,0,3,3,3,3,3,0,0,0,3,3,3,3,3,0,0,0,0,0,0,3,0,0,3,3,0,3,3,3,3,0,3,3,3,3,3,0},
                {0,3,0,3,3,3,3,0,0,0,3,3,3,0,0,3,0,0,3,3,3,0,0,3,0,0,0,3,3,0,0,3,0,0,0,0,0,0,0,0,0,0},
                {0,3,0,0,0,0,0,0,3,0,0,0,3,3,3,3,0,0,0,0,3,0,0,3,0,3,3,3,0,0,3,3,0,0,3,3,3,3,0,3,0,0},
                {3,3,3,3,0,3,3,3,3,3,0,0,0,0,0,0,0,3,0,0,3,0,0,3,0,3,0,3,0,3,3,0,0,0,0,3,0,0,0,3,0,0},
                {3,0,0,3,0,0,0,0,0,3,0,0,3,3,3,0,3,3,0,3,3,0,0,3,0,3,0,3,3,3,0,0,3,3,3,3,3,0,0,3,3,0},
                {3,0,0,3,0,3,3,3,0,3,3,3,3,0,0,0,3,0,0,3,0,0,0,3,3,3,0,0,3,0,0,0,3,0,0,0,3,0,0,3,0,0},
                {0,0,0,3,3,3,0,3,0,3,0,0,3,0,3,3,3,3,3,3,3,3,0,0,0,0,0,3,3,0,3,3,3,3,3,0,3,3,3,3,0,0},

                {0,3,0,3,0,0,0,0,0,3,0,0,3,3,3,0,0,0,0,0,0,3,0,3,0,0,3,3,0,0,3,0,0,3,0,0,0,3,0,0,0,0},
                {3,3,0,3,3,3,3,3,3,3,0,0,0,0,3,0,0,0,0,0,0,3,0,3,3,0,0,3,0,3,3,3,0,3,0,0,0,3,0,3,3,0},
                {3,0,0,0,3,0,0,0,0,0,0,3,3,0,3,3,3,3,3,0,0,3,0,0,3,0,3,3,0,3,0,3,0,3,3,3,3,3,0,3,0,0},
                {3,3,3,0,3,0,0,3,0,3,0,3,0,0,0,0,0,0,3,0,0,0,0,0,3,0,3,0,0,3,0,3,0,0,0,0,0,3,0,3,0,0},
                {0,0,3,0,3,0,3,3,0,3,0,3,3,3,0,3,3,0,3,3,3,3,3,0,3,0,3,3,3,3,0,3,0,3,0,3,0,0,0,3,0,0},
                {0,0,3,0,3,0,3,0,0,3,0,3,0,3,0,0,3,0,3,0,0,0,0,0,3,0,0,0,0,0,0,3,0,3,0,3,3,3,3,3,0,0},
                {0,3,3,0,3,0,3,3,3,3,0,3,0,3,3,3,3,0,3,3,3,0,0,3,3,3,0,3,3,0,0,3,0,3,0,0,0,0,3,0,0,0},
                {0,3,0,0,0,0,0,0,0,3,0,0,0,0,3,0,0,0,0,0,3,0,0,3,0,3,0,3,0,0,3,3,0,3,3,3,3,0,3,0,0,0},
                {0,3,3,3,3,0,0,0,0,3,3,3,3,3,3,0,3,3,3,3,3,3,0,3,0,3,3,3,3,3,3,0,0,0,3,0,3,0,3,3,3,0},
                {0,0,0,0,3,3,3,3,3,3,0,0,0,0,3,3,3,0,0,0,0,3,1,3,0,0,0,0,0,0,3,3,3,3,3,0,3,3,3,0,0,0}};

void setup(){
  size(1300,600);
  maze = new Maze();
  rectColor = color(0);
  rectHighlight = color(51);
  circleHighlight = color(204);
  baseColor = color(102);
  currentColor = baseColor;
  rectX = width/3;
  rectYE = height/10 * 4;
  rectYM = height/10 * 6;
  rectYH = height/10 * 8;
  rectW = width/3;
  rectH = height/6;

}

void draw(){
 background(255);

 if(chosenDiff == false){
   getDiff();
 }
 else{
   maze.show();
   fill(0);
   rect(600,0,100,600);
   if(goalX != 0 || goalY != 0){
        fill(255, 0, 0);
        stroke(255, 0, 0);
        ellipse(goalX, goalY, 10, 10);
        fill(255, 0, 0);
        stroke(255, 0, 0);
        ellipse(goalX+700, goalY, 10, 10);
        if(player.createPlayer()){
          if(unfinished){
            finish = millis();
            timeElapsed = finish - start;
            unfinished = false;
          }
          fill(0);
          stroke(0, 0, 0);
          rect(700, 0, 600, 600);
          fill(255,255,255);
          textSize(50);
          text(" You won!", 950, 250);
          fill(255,255,255);
          textSize(45);
          text(" Your Time is: " + timeElapsed/1000 + 's', 775, 450);
          if(!unfinished){
            postScore(timeElapsed, difficulty);
          }
        }
      }
   winner.move();
   winner.show();
 }
}

void difficultySelect(){
  //chosenDifficulty = true;
  //medium = true;
  if(easy == true){
    for (int i = 0; i < easyMaze.length; i++){
      float positionInY = 600/easyMaze.length;
      for (int j = 0; j < easyMaze[i].length; j++){
        float positionInX = 600/easyMaze.length;
        if(easyMaze[i][j] == 0){ // 0 will be obstacle
          fill(0,0,255);
          maze.obs.add(new Obstacle(positionInX*j, positionInY*i, positionInX, positionInY));
        }
        if(easyMaze[i][j] == 2){
          goalX=positionInX*j + positionInX/2;
          goalY=positionInY*i + positionInY/2;
          sizeGX=positionInX/4;
          sizeGY=positionInY/4;
        }
        if(easyMaze[i][j] == 1){
          startX = positionInX*j + positionInX/2;
          startY = positionInY*i + positionInY/2;
        }
      }
    }
    PVector Goal = new PVector(goalX,goalY);
    playerPosX = startX;
    playerPosY = startY;
    difficulty = 1; // easy mode
    player = new Player(startX,startY,easyMaze,Goal,difficulty);
    matr = easyMaze;
  }
  else if(medium == true){
    for (int i = 0; i < mediumMaze.length; i++){
      float positionInY = 600/mediumMaze.length;
      for (int j = 0; j < mediumMaze[i].length; j++){
        float positionInX = 600/mediumMaze.length;
        if(mediumMaze[i][j] == 0){ // 0 will be obstacle
          fill(0,0,255);
          maze.obs.add(new Obstacle(positionInX*j, positionInY*i, positionInX, positionInY));
        }
        if(mediumMaze[i][j] == 2){
          goalX=positionInX*j + positionInX/2;
          goalY=positionInY*i + positionInY/2;
          sizeGX=positionInX/4;
          sizeGY=positionInY/4;
        }
        if(mediumMaze[i][j] == 1){
          startX = positionInX*j + positionInX/2;
          startY = positionInY*i + positionInY/2;
        }
      }
      PVector Goal = new PVector(goalX,goalY);
      playerPosX = startX;
      playerPosY = startY;
      difficulty = 2; // medium mode
      player = new Player(startX,startY,mediumMaze,Goal,2);
      matr = mediumMaze;
      
    }
  }
  else if(hard == true){
    for (int i = 0; i < hardMaze.length; i++){
      int positionInY = 600/hardMaze.length;
      for (int j = 0; j < hardMaze[i].length; j++){
        int positionInX = 600/hardMaze.length;
        if(hardMaze[i][j] == 0){ // 0 will be obstacle
          fill(0,0,255);
          maze.obs.add(new Obstacle(positionInX*j, positionInY*i, positionInX, positionInY));
        }
        if(hardMaze[i][j] == 2){
          goalX=positionInX*j + positionInX/2;
          goalY=positionInY*i + positionInY/2;
          sizeGX=positionInX/4;
          sizeGY=positionInY/4;
        }
        if(hardMaze[i][j] == 1){
          startX = positionInX*j + positionInX/2;
          startY = positionInY*i + positionInY/2;
        }
      }
    }
    PVector Goal = new PVector(goalX,goalY);
    playerPosX = startX;
    playerPosY = startY;
    difficulty = 3; // hard mode
    player = new Player(startX,startY,hardMaze,Goal, difficulty);
    matr = hardMaze;
  }

    winner = new Dot();
    start = millis();
}

void update(int x, int y) {
  if ( overRect(rectX, rectYE, rectW, rectH) ) {
    if(mousePressed){
    easy = true;
    chosenDiff = true;
    difficultySelect();
    }
  }
  else if ( overRect(rectX, rectYM, rectW, rectH) ) {
    if(mousePressed){
    medium = true;
    chosenDiff = true;
    difficultySelect();
    }
  }
    else if ( overRect(rectX, rectYH, rectW, rectH) ) {
    if(mousePressed){
    hard = true;
    chosenDiff = true;
    difficultySelect();
    }
  }
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
        return true;
      }
  else {
    return false;
  }
}

void getDiff(){
  update(mouseX, mouseY);
  background(currentColor);

      fill(easyColor);
      rect(rectX, rectYE, rectW, rectH);
      fill(mediumColor);
      rect(rectX, rectYM, rectW, rectH);
      fill(hardColor);
      rect(rectX, rectYH, rectW, rectH);

      textSize(50);
      fill(0, 0, 0);
      text("Easy", rectX + rectX/3, rectYE + rectYE/4);
      text("Medium", rectX + rectX/4, rectYM + rectYE/4);
      text("Hard", rectX + rectX/3, rectYH + rectYE/4);

      textSize(120);
      text("MAZE RUNNER", width/6, height/4);
}

//void keyPressed()
//  {
//      if (key == 'd'){  // move right
//        player.playerNewX(step, pos);
//      } else if  (key == 'a'){  // move left
//        player.playerNewX(step, sub);
//      } else if (key == 'w'){ // move up
//        player.playerNewY(step, sub);
//      } else if (key == 's'){  // move down
//        player.playerNewY(step, pos);
//      }
//    }

void keyPressed()
  {
      if (key == 'd'){  // move right
        float newX = playerPosX + step;
        if (isGood(newX, playerPosY)){
          playerPosX = newX;
          player.playerNewX(newX);
        } 
      }
      if  (key == 'a'){  // move left
        float newX = playerPosX - step;
        if (isGood(newX, playerPosY)){
          playerPosX = newX;
          player.playerNewX(newX);
        } 
      }
      if (key == 'w'){ // move up
        float newY = playerPosY - step;
        if (isGood(playerPosX, newY)){
          playerPosY = newY;
          player.playerNewY(newY);
        }  

      }
      if (key == 's'){  // move down
        float newY = playerPosY + step;
        if (isGood(playerPosX, newY)){
          playerPosY = newY;
          player.playerNewY(newY);
        } 
      }
    }
    
    boolean isGood(float playerPosX, float playerPosY) {
      int width = 600;
      int height = 600;
      int radius = 4/2;
      float edgeR = playerPosX + radius;
      float edgeL = playerPosX - radius;
      float edgeT = playerPosY - radius;
      float edgeB = playerPosY + radius;
      float bmR = (matr[0].length*edgeR)/width;
      float bmL = (matr[0].length*edgeL)/width;
      float bmT = (matr.length*edgeT)/height;
      float bmB = (matr.length*edgeB)/height;
      
      boolean inRangeR = (edgeR >= 0) && (edgeR < width);
      boolean inRangeL = (edgeL >= 0) && (edgeL < width);
      boolean inRangeT = (edgeT >= 0) && (edgeT < height);
      boolean inRangeB = (edgeB >= 0) && (edgeB < height);
      boolean inRange = inRangeR && inRangeL && inRangeT && inRangeB;
      if (inRange) {
        boolean isOpenTR = (matr[int(bmT)][int(bmR)] != 0);
        boolean isOpenTL = (matr[int(bmT)][int(bmL)] != 0);
        boolean isOpenBR = (matr[int(bmB)][int(bmR)] != 0);
        boolean isOpenBL = (matr[int(bmB)][int(bmL)] != 0);
        boolean isOpen = isOpenTR && isOpenTL && isOpenBR && isOpenBL;
        return isOpen;
      }
      return (false);
    }