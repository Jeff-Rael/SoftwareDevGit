class Obsticles{
  int WindowSize;
  int Matrix[][];
  

  Obsticles(int size){
    WindowSize = size;
    int mat[][] = {{0,0,3,2,0,0,0},
                  {0,0,3,0,0,0,0},
                  {0,3,3,0,0,0,0},
                  {0,0,3,3,3,3,0},
                  {0,0,0,1,0,0,0}};
   Matrix = mat;
  }
  
  PVector Goal(){
    for (int i = 0; i < Matrix.length; i++){ 
      int positionInY = WindowSize/Matrix.length;
      for (int j = 0; j < Matrix[i].length; j++){
        int pos = WindowSize/Matrix[i].length;
        if(Matrix[i][j] == 2){ // 2 will be Goal
          float x = pos*(i.5);
          float y = positionInY*(j.5);
          PVector goal = new PVector(x, y);
          return goal;
        }
    }
  }
  
  //void ShowObsticle(){
  //  fill(0,0,255); // creates the obsticles: add a class to condense this later
  //  rect(100,300,600,10);
  //}
  
  void createObj(){
    for (int i = 0; i < Matrix.length; i++){ 
      int positionInY = WindowSize/Matrix.length;
      for (int j = 0; j < Matrix[i].length; j++){
        int pos = WindowSize/Matrix[i].length;
        if(Matrix[i][j] == 1){ // 1 will be start
          
        } else if(Matrix[i][j] == 2){ // 2 will be goal
        } else if(Matrix[i][j] == 0){ // 0 will be obsticle
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
          if(Matrix[i][j] == 0 && posy > positionInY*i && posy < positionInY*(i+1) && posx > pos*j && posx < pos*(j+1)){ // 0 will be obsticle
            return true;
        } else if(Matrix[i][j] != 0 && posy > positionInY*i && posy < positionInY*(i+1) && posx > pos*j && posx < pos*(j+1)){ // 0 will be obsticle
            return false;
        }
      }
    }
    return false;
  }
}
