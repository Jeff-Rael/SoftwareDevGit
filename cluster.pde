class Cluster{
  Node[] nodes;
  float fitnessSum;
  int gen = 1;
  
  int bestNode = 0;
  int minStep = 400;
  int Visited[][];
  
  Cluster(int size, int mat[][]){
    nodes = new Node[size];
    int mat1[][] = new int[mat.length][mat[0].length];
    for(int i = 0; i < size; i++){
      nodes[i] = new Node();
    }
    for (int i = 0; i < mat1.length; i++){ // Creates a blank visited array that will be all zeros and same size as obsticle matrix
      for (int j = 0; j < mat1[i].length; j++){
        mat1[i][j] = 0;
      }
    }
    Visited = mat1;
  }
  
  void show(){
    for(int i = 1; i < nodes.length; i++){
      nodes[i].show();
    }
    nodes[0].show();
  }
  
  void update(){
    for(int i = 0; i < nodes.length; i++){
      if(nodes[i].rules.step > minStep){ // kills dots that take more than the min step. might cause problems later
        nodes[i].dead = true;
      }else{
        nodes[i].update();
      }
    }
  }
  
  void calculateFitness(){
    for(int i = 0; i < nodes.length; i++){
      nodes[i].calculateFitness();
    }
  }
  
  boolean allNodesDead(){
    for(int i = 0; i < nodes.length; i++){
      if(!nodes[i].dead && !nodes[i].reachedGoal){
        return false;
      }
    }
    return true;
  }
  
  void naturalSelection(){
    setBestNode();
    Node[] newNodes = new Node[nodes.length];
    calculateFitnessSum();
    // Brings best node from previous attempt
    newNodes[0] = nodes[bestNode].findChild();
    newNodes[0].isBest = true;
    
    for(int i = 1; i < newNodes.length; i++){
      // Select parent based on fitness
      Node parent = selectParent();
      // get Child form them
      newNodes[i] = parent.findChild();
    }
    nodes = newNodes.clone();
    gen++;
  }
  
  void calculateFitnessSum(){
    fitnessSum = 0;
    for(int i = 0; i < nodes.length; i++){
      fitnessSum += nodes[i].fitness;
    }
  }
  

  
  Node selectParent(){
    float rand = random(fitnessSum);
    
    float runningSum = 0;
    for(int i = 0; i < nodes.length; i++){
      runningSum += nodes[i].fitness;
      if(runningSum > rand) {
        return nodes[i];
      }
    }
    // Should never get to this point
    return null;
  }
  
  void mutate(){
    for(int i = 1; i < nodes.length; i++){ // starts at 1 so doesn't butate best attempt
      nodes[i].rules.mutate();
    }
  }
  
  void setBestNode(){
    float max = 0;
    int maxIndex = 0;
    for(int i = 0; i < nodes.length; i++){
      if(nodes[i].fitness > max) {
        max = nodes[i].fitness;
        maxIndex = i;
      }
    }
    bestNode = maxIndex;
    if(nodes[bestNode].reachedGoal){
      minStep = nodes[bestNode].rules.step;
      println("step: ", minStep);
    }
  }
}
