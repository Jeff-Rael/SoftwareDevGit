Cluster test;
Obstacles obstacle;
Player player;
//PVector goal = new PVector(400, 10);
PVector goal;
//boolean BooleanMatrix[][];

import javax.swing.JOptionPane;
int step = 7; // pixel size of each step taken for the player
boolean pos = true; // add
boolean sub = false;

long start = System.currentTimeMillis();
long finish;

// Matrix for creating the Obsticles.
// 0 is Wall
// 1 is start
// 2 is goal
// 3 is open
               
int mat[][] = {{0,0,3,3,3,3,2},
               {0,3,3,0,3,3,0},
               {3,3,0,3,3,0,0},
               {3,0,3,3,0,0,0},
               {1,3,3,0,0,0,0}};

//boolean bm[][] = new boolean[mat.length][mat[0].length];
void setup(){
 size(800,800); 
 obstacle =  new Obstacles(800, mat);
 test = new Cluster(500, mat);
 goal = obstacle.Goal();
 player = new Player(100, 750, mat, goal);
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

void draw(){
  //print("Hello");
  //obstacle.initialize();
  background(255);
  fill(255,0,0);
  ellipse(goal.x, goal.y, 10, 10);
  
  //fill(128,0,128);
  if(player.createPlayer()){
    finish = System.currentTimeMillis();
    long timeElapsed = finish - start;
    JOptionPane.showMessageDialog(frame, "Elapsed time is: " + timeElapsed/1000 + " Seconds");
  }
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
      if (key == 'd'){  // move right
        player.playerNewX(step, pos);
      } else if  (key == 'a'){  // move left
        player.playerNewX(step, sub);
      } else if (key == 'w'){ // move up
        player.playerNewY(step, sub);
      } else if (key == 's'){  // move down
        player.playerNewY(step, pos);
      }
    }
