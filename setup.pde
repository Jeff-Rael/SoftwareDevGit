Cluster test;
Obsticles obsticle;
//PVector goal = new PVector(400, 10);
PVector goal;
void setup(){
 size(800,800); 
 obsticle =  new Obsticles(800);
 test = new Cluster(500);
 goal = obsticles.goal;
}

void draw(){
  
  background(255);
  //obsticle.initialize();
  //background(255);
  fill(255,0,0);
  ellipse(goal.x, goal.y, 10, 10);
  
  //fill(0,0,255); // creates the obsticles: add a class to condense this later
  //rect(100,300,600,10);
                  
   obsticle.createObj();
  
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
