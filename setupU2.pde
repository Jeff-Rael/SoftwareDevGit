//Cluster test;
//Obstacles obstacle;
int playerPosX, playerPosY, lives;
//PVector goal = new PVector(400, 10);
//PVector goal;
boolean BooleanMatrix[][];



public enum RunStates {
    title,
    running,
    win,
    lose
}

RunStates runState = RunStates.title;

// Matrix for creating the Obsticles.
// 0 is Wall
// 1 is start
// 2 is goal
// 3 is open
//int mat[][] = {{0,0,0,3,3,3,0},
//               {0,0,0,3,0,3,0},
//               {0,0,0,3,0,3,0},
//               {0,0,0,3,0,3,0},
//               {0,0,0,1,0,2,0}};      

//int mat[][] = {{0,0,3,2,0,0,0},
//               {0,3,3,3,3,3,0},
//               {3,0,3,3,0,3,0},
//               {3,3,3,0,3,3,3},
//               {0,3,3,1,3,0,3}};
               
int mat[][] = {{0,0,3,3,3,3,2},
               {0,3,3,0,3,3,0},
               {3,3,0,3,3,0,0},
               {3,0,3,3,0,0,0},
               {1,3,3,0,0,0,0}};

Obstacles obstacle =  new Obstacles(800, mat);
   Cluster test = new Cluster(500);
   PVector goal = obstacle.Goal();
boolean bm[][] = new boolean[mat.length][mat[0].length];
void setup(){
 size(800,800); 
 //obstacle =  new Obstacles(800, mat);
 //test = new Cluster(500);
 //goal = obstacle.Goal();
 //playerPosX = 100;
 //playerPosY = 750;
 
 //for(int i = 0; i < mat.length; i++){
 //     for(int j = 0;j < mat.length; j++){
 //       if(mat[i][j] == 0){
 //         bm[i][j] = false;
 //       } else {
 //         bm[i][j] = true;
 //       }
 //     }
 // }
}

boolean firstRound = true;
void draw(){
  //print("Hello");
  //obstacle.initialize();
   background(255);
   
   switch (runState) {
       case title:
         titleScreen();
         runState = RunStates.title;
         init();
         break;
       case running:
         drawingThings();
         break;
       case win:
         winScreen();
         break;
       case lose:
         loseScreen();
         break;
       default:
         print("Default");
   }
  print(runState + "\n");  
    
   
   // print(firstRound);
   
    
}


void keyPressed()
  {
      if (key == 'd'){  // move right
        int newX = playerPosX + 7;
        if (isGood(newX, playerPosY)){
          playerPosX = newX;
        } else {
            lives--;
        }  
      }
      if  (key == 'a'){  // move left
        int newX = playerPosX - 7;
        if (isGood(newX, playerPosY)){
          playerPosX = newX;
        } else {
            lives--;
        }  
      }
      if (key == 'w'){ // move up
        int newY = playerPosY - 7;
        if (isGood(playerPosX, newY)){
          playerPosY = newY;
        } else {
            lives--;
        }  

      }
      if (key == 's'){  // move down
        int newY = playerPosY + 7;
        if (isGood(playerPosX, newY)){
          playerPosY = newY;
        } else {
            lives--;
        }  
      }
      if (key == ' '){
        runState = RunStates.running;
      } 
      if (key == 'r'){
        runState = RunStates.title;
      }  
    }

    boolean isGood(int playerPosX, int playerPosY) {
      int width = 800;
      int height = 800;
      int radius = 20/2;
      int edgeR = playerPosX + radius;
      int edgeL = playerPosX - radius;
      int edgeT = playerPosY - radius;
      int edgeB = playerPosY + radius;
      int bmR = (7*edgeR)/width;
      int bmL = (7*edgeL)/width;
      int bmT = (5*edgeT)/height;
      int bmB = (5*edgeB)/height;
      boolean inRangeR = (edgeR >= 0) && (edgeR < width);
      boolean inRangeL = (edgeL >= 0) && (edgeL < width);
      boolean inRangeT = (edgeT >= 0) && (edgeT < height);
      boolean inRangeB = (edgeB >= 0) && (edgeB < height);
      boolean inRange = inRangeR && inRangeL && inRangeT && inRangeB;
      if (inRange) {
        boolean isOpenTR = (mat[bmT][bmR] != 0);
        boolean isOpenTL = (mat[bmT][bmL] != 0);
        boolean isOpenBR = (mat[bmB][bmR] != 0);
        boolean isOpenBL = (mat[bmB][bmL] != 0);
        boolean isOpen = isOpenTR && isOpenTL && isOpenBR && isOpenBL;
        return isOpen;
      }
      return (false);
    }
    
    
void titleScreen(){
  background(0,0,0);
  fill(255,255,255);
  textSize(50);
  text(" Welcome to Maze Runner", 50,350);
  textSize(40);
  text("Press space to play", 200, 450);
  textSize(30);
  text(" Use the 'wasd' keys to move, and navigate the maze", 25,550);
  keyPressed();
}


void winScreen(){
 background(0, 0, 0);
 fill(255, 255, 255);
 textSize(50);
 text(" You won!", 250, 250);
 textSize(45);
 text(" Would you like to play again?", 75, 450);
 text(" Press 'r' if you want to replay.", 55, 550);
 keyPressed();
 print(firstRound);
 //firstRound = true;
}

void loseScreen(){
  background(0, 0, 0);
 fill(255, 255, 255);
 textSize(50);
 text(" You lost!", 250, 250);
 textSize(45);
 text(" Would you like to play again?", 75, 450);
 text(" Press 'r' if you want to replay.", 55, 550);
 keyPressed();
 //firstRound = true;
}

void drawingThings(){
    obstacle.createObj();
    fill(255,0,0);
    ellipse(goal.x, goal.y, 10, 10);
    
    fill(128,0,128);
    ellipse (playerPosX, playerPosY, 20, 20);
    
    text(lives, 0, 500);
    
    if(lives == 0){
        //runState = RunStates.lose;
        init();
    }  
    if(test.allNodesDead()){
      // Genetic Algorithm
      test.calculateFitness();
      test.naturalSelection();
      test.mutate();
    } else {
      test.update();
      test.show();
    }
    
  if(dist(playerPosX, playerPosY, goal.x, goal.y) < 20){
     boolean theyWon = false;
     for(Node node : test.nodes) {  
       if (dist(node.position.x, node.position.y, goal.x, goal.y) < 20) {
          theyWon = true;
       }
     }
     if(theyWon){
       runState = RunStates.lose;
     } else {
       runState = RunStates.win;
     }
  }
}  


void init(){
   playerPosX = 100;
   playerPosY = 750;
   lives = 3;
}

