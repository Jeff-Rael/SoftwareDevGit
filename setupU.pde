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
int mat[][] = {{0,0,0,3,3,3,0},
               {0,0,0,3,0,3,0},
               {0,0,0,3,0,3,0},
               {0,0,0,3,0,3,0},
               {0,0,0,1,0,2,0}};          

boolean bm[][] = new boolean[mat.length][mat[0].length];
void setup(){
 size(800,800); 
 obstacle =  new Obstacles(800, mat);
 test = new Cluster(500);
 goal = obstacle.Goal();
 playerPosX = 400;
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
  
  fill(0,255,0);
  ellipse (playerPosX, playerPosY, 100, 100);
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

void keyPressed()
  {
    int bmX = 7*(playerPosX/800);
    int bmY = 5*(playerPosY/800);
  //  println("DEBUG: playerPosX:" + playerPosX + "playerPosY:" + playerPosY + "bmX: " + bmX + " bmY:" + bmY);
      if (key == 'd')
      {
        int newEdgeX = playerPosX + 100/2 + 7;
        bmX = (7*newEdgeX)/800;
        bmY = (5*playerPosY)/800;
        if((newEdgeX < 800) && (mat[bmY][bmX] != 0)){
          playerPosX = playerPosX +7;
        }
      }
      if  (key == 'a')
      {
         int newEdgeX = playerPosX - 100/2 + 7;
         bmX = (7*newEdgeX)/800;
         bmY = (5*playerPosY)/800;
         if((newEdgeX >= 0) && (mat[bmY][bmX] != 0)){
           playerPosX = playerPosX - 7;
        }
      }
      if (key == 'w') //move up
      {
        int newEdgyY = playerPosY - 100/2 - 7; //radius and where we want to go
        bmX = (7*playerPosX)/800;
        bmY = (5*newEdgyY)/800;
        print("DEBUG: playerPosY = " + playerPosY + ", newEdgyY = " + newEdgyY + ", bmX = " + bmX + ", bmY = " + bmY + "\n");
        if((newEdgyY >= 0) && (mat[bmY][bmX] != 0)){
          playerPosY = playerPosY -7;
        }
      }
      if (key == 's')
      {
        int newEdgyY = playerPosY + 100/2 + 7; //radius and where we want to go
        bmX = (7*playerPosX)/800;
        bmY = (5*newEdgyY)/800;
        print("DEBUG: playerPosY = " + playerPosY + ", newEdgyY = " + newEdgyY + ", bmX = " + bmX + ", bmY = " + bmY + "\n");
        if((newEdgyY < 800) && (mat[bmY][bmX] != 0)){
          playerPosY = playerPosY + 7;
        }
      }
    }
