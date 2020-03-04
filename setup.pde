Cluster test;
Obstacles obstacle;
PVector goal = new PVector(400, 10);
//PVector goal;
void setup(){
 size(800,800); 
 obstacle =  new Obstacles(800);
 test = new Cluster(500);
 //goal = obstacle.Goal();
}

void draw(){
  
  background(255);
  //obstacle.initialize();
  //background(255);
  fill(255,0,0);
  ellipse(goal.x, goal.y, 10, 10);
  
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
