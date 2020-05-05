class Player{
  float playerPosX;
  float playerPosY;
  int Matrix[][];
  PVector goal;
  int diameter = 4;
  int difficulty;
  
  Player(float start_x, float start_y,int mat1[][], PVector Goal, int diff){
    Matrix = mat1;
    goal = Goal;
    playerPosX = start_x;
    playerPosY = start_y;
    difficulty = diff;
  }
 
  boolean createPlayer(){
    fill(128,0,128);
    float dispX;
    if(difficulty == 1){
      dispX = playerPosX + 700; // easy distance
    } else if(difficulty == 2){
      dispX = playerPosX + 700; // medium distance
    } else if(difficulty == 3){
      dispX = playerPosX + 700; // hard distance
    } else {
      dispX = playerPosX + 700; // default to easy
    }
    
    ellipse (dispX, playerPosY, diameter, diameter);
    if(dist(playerPosX, playerPosY, goal.x, goal.y) < 5){
      return true;
    }
    return false;
  }
  
  
  //void playerNewX(int step, boolean pos){
  //  int newX;
  //  if(pos){
  //    newX = playerPosX + step;
  //  } else {
  //    newX = playerPosX - step;
  //  }
  //  if (isGood(newX, playerPosY)){
  //    //println("updated X");
  //    playerPosX = newX;
  //  }
  //}
  
  //void playerNewY(int step, boolean pos){
  //  int newY;
  //  if(pos){
  //    newY = playerPosY + step;
  //  } else {
  //    newY = playerPosY - step;
  //  }
  //  if (isGood(playerPosX, newY)){
  //    //println("updated Y");
  //    playerPosY = newY;
  //  }
  //}
    void playerNewX(float X){
      playerPosX = X;
    }
    
    void playerNewY(float Y){
      playerPosY = Y;
    }
//  boolean isGood(int PosX, int PosY) {
//      int width = 600;
//      int height = 600;
//      int radius = diameter/2;
//      int edgeR = PosX + radius;
//      int edgeL = PosX - radius;
//      int edgeT = PosY - radius;
//      int edgeB = PosY + radius;
//      int bmR = (Matrix[0].length*edgeR)/width;
//      int bmL = (Matrix[0].length*edgeL)/width;
//      int bmT = (Matrix.length*edgeT)/height;
//      int bmB = (Matrix.length*edgeB)/height;
//      boolean inRangeR = (edgeR >= 0) && (edgeR < width);
//      boolean inRangeL = (edgeL >= 0) && (edgeL < width);
//      boolean inRangeT = (edgeT >= 0) && (edgeT < height);
//      boolean inRangeB = (edgeB >= 0) && (edgeB < height);
//      boolean inRange = inRangeR && inRangeL && inRangeT && inRangeB;
//      if (inRange) {
//        boolean isOpenTR = (Matrix[bmT][bmR] != 0);
//        boolean isOpenTL = (Matrix[bmT][bmL] != 0);
//        boolean isOpenBR = (Matrix[bmB][bmR] != 0);
//        boolean isOpenBL = (Matrix[bmB][bmL] != 0);
//        boolean isOpen = isOpenTR && isOpenTL && isOpenBR && isOpenBL;
//        return isOpen;
//      }
//      return (false);
//    }
}