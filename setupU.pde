Cluster test;
Obstacles obstacle;
int playerPosX, playerPosY;
//PVector goal = new PVector(400, 10);
PVector goal;
boolean BooleanMatrix[][];


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

boolean bm[][] = new boolean[mat.length][mat[0].length];
void setup(){
 size(800,800); 
 obstacle =  new Obstacles(800, mat);
 test = new Cluster(500);
 goal = obstacle.Goal();
 playerPosX = 100;
 playerPosY = 750;
 for(int i = 0; i < mat.length; i++){
      for(int j = 0;j < mat.length; j++){
        if(mat[i][j] == 0){
          bm[i][j] = false;
        } else {
          bm[i][j] = true;
        }
      }
  }
}

void draw(){
  //print("Hello");
  //obstacle.initialize();
  background(255);
  fill(255,0,0);
  ellipse(goal.x, goal.y, 10, 10);
  
  fill(128,0,128);
  ellipse (playerPosX, playerPosY, 20, 20);
  //fill(0,0,255); // creates the obstacles: add a class to condense this later
  //rect(100,300,600,10);
                  
   obstacle.createObj();
  
  if(test.allNodesDead()){
    // Genetic Algorithm
    test.calculateFitness();
    test.naturalSelection();
    test.mutate();
  } else {
    test.update();
    test.show();
  }
}

//void keyPressed()
//  {
//    int bmX = 7*(playerPosX/800);
//    int bmY = 5*(playerPosY/800);
//  //  println("DEBUG: playerPosX:" + playerPosX + "playerPosY:" + playerPosY + "bmX: " + bmX + " bmY:" + bmY);
//      if (key == 'd')
//      {
//        int newEdgeX = playerPosX + 100/2 + 7;
//        bmX = (7*newEdgeX)/800;
//        bmY = (5*playerPosY)/800;
//        if((newEdgeX < 800) && (mat[bmY][bmX] != 0)){
//          playerPosX = playerPosX +7;
//        }
//      }
//      if  (key == 'a')
//      {
//         int newEdgeX = playerPosX - 100/2 + 7;
//         bmX = (7*newEdgeX)/800;
//         bmY = (5*playerPosY)/800;
//         if((newEdgeX >= 0) && (mat[bmY][bmX] != 0)){
//           playerPosX = playerPosX - 7;
//        }
//      }
//      if (key == 'w') //move up
//      {
//        int newEdgyY = playerPosY - 100/2 - 7; //radius and where we want to go
//        bmX = (7*playerPosX)/800;
//        bmY = (5*newEdgyY)/800;
//        print("DEBUG: playerPosY = " + playerPosY + ", newEdgyY = " + newEdgyY + ", bmX = " + bmX + ", bmY = " + bmY + "\n");
//        if((newEdgyY >= 0) && (mat[bmY][bmX] != 0)){
//          playerPosY = playerPosY -7;
//        }
//      }
//      if (key == 's')
//      {
//        int newEdgyY = playerPosY + 100/2 + 7; //radius and where we want to go
//        bmX = (7*playerPosX)/800;
//        bmY = (5*newEdgyY)/800;
//        print("DEBUG: playerPosY = " + playerPosY + ", newEdgyY = " + newEdgyY + ", bmX = " + bmX + ", bmY = " + bmY + "\n");
//        if((newEdgyY < 800) && (mat[bmY][bmX] != 0)){
//          playerPosY = playerPosY + 7;
//        }
//      }
//    }

void keyPressed()
  {
      if (key == 'd'){  // move right
        int newX = playerPosX + 7;
        if (isGood(newX, playerPosY)){
          playerPosX = newX;
        }
      }
      if  (key == 'a'){  // move left
        int newX = playerPosX - 7;
        if (isGood(newX, playerPosY)){
          playerPosX = newX;
        }
      }
      if (key == 'w'){ // move up
        int newY = playerPosY - 7;
        if (isGood(playerPosX, newY)){
          playerPosY = newY;
        }

      }
      if (key == 's'){  // move down
        int newY = playerPosY + 7;
        if (isGood(playerPosX, newY)){
          playerPosY = newY;
        }
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
