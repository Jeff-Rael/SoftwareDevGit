class Obstacles{
  int WindowSize;
  int Matrix[][];
  

  Obstacles(int size){
    WindowSize = size;
    // 0 is Wall
    // 1 is start
    // 2 is goal
    // 3 is open
    int mat[][] = {{0,0,0,3,3,3,0}, 
                   {0,0,0,3,0,3,0},
                   {0,0,0,3,0,3,0},
                   {0,0,0,3,0,3,0},
                   {0,0,0,1,0,2,0}};
   Matrix = mat;
  }
  
  PVector Goal(){
    for (int i = 0; i < Matrix.length; i++){ 
      int positionInY = WindowSize/Matrix.length;
      for (int j = 0; j < Matrix[i].length; j++){
        int pos = WindowSize/Matrix[i].length;
        if(Matrix[i][j] == 2){ // 2 will be Goal
          float x = pos*(j+.5);
          float y = positionInY*(i+.5);
          PVector goal = new PVector(x, y);
          return goal;
        }
      }
    }
    PVector goal = new PVector(400,10);
    return goal;
  }
  
  
  void createObj(){
    for (int i = 0; i < Matrix.length; i++){ 
      int positionInY = WindowSize/Matrix.length;
      for (int j = 0; j < Matrix[i].length; j++){
        int pos = WindowSize/Matrix[i].length;
        if(Matrix[i][j] == 0){ // 0 will be obstacle
          fill(0,0,255);
          rect(pos*j,positionInY*i,pos,positionInY);
        }
      }
    }
  }
  
  boolean checkCollision(float posx, float posy){
    for (int i = 0; i < Matrix.length; i++){ 
      int positionInY = WindowSize/Matrix.length;
      for (int j = 0; j < Matrix[i].length; j++){
        int pos = WindowSize/Matrix[i].length;
          if(Matrix[i][j] == 0 && posy > positionInY*i && posy < positionInY*(i+1) && posx > pos*j && posx < pos*(j+1)){ // 0 will be obstacle
            return true;
        } else if(Matrix[i][j] != 0 && posy > positionInY*i && posy < positionInY*(i+1) && posx > pos*j && posx < pos*(j+1)){ // 0 will be obstacle
            return false;
        }
      }
    }
    return false;
  }
}
