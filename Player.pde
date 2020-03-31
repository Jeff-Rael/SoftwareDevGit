class Player{
  int playerPosX;
  int playerPosY;
  int Matrix[][];
  PVector goal;
  
  Player(int start_x, int start_y,int mat1[][], PVector Goal){
    Matrix = mat1;
    goal = Goal;
    playerPosX = start_x;
    playerPosY = start_y;
  }
 
  boolean createPlayer(){
    fill(128,0,128);
    ellipse (playerPosX, playerPosY, 20, 20);
    if(dist(playerPosX, playerPosY, goal.x, goal.y) < 5){
      return true;
    }
    return false;
  }
  
  //void PlayerVictory(int PosX, int PosY){
  //  if(dist(PosX,PosY,goal.x,goal.y) < 5){
  //    println("You Win");
  //  }
  //}
  
  void playerNewX(int step, boolean pos){
    int newX;
    if(pos){
      newX = playerPosX + step;
    } else {
      newX = playerPosX - step;
    }
    if (isGood(newX, playerPosY)){
      //println("updated X");
      playerPosX = newX;
    }
  }
  
  void playerNewY(int step, boolean pos){
    int newY;
    if(pos){
      newY = playerPosY + step;
    } else {
      newY = playerPosY - step;
    }
    if (isGood(playerPosX, newY)){
      //println("updated Y");
      playerPosY = newY;
    }
  }
  
  boolean isGood(int PosX, int PosY) {
      int width = 800;
      int height = 800;
      int radius = 20/2;
      int edgeR = PosX + radius;
      int edgeL = PosX - radius;
      int edgeT = PosY - radius;
      int edgeB = PosY + radius;
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
        boolean isOpenTR = (Matrix[bmT][bmR] != 0);
        boolean isOpenTL = (Matrix[bmT][bmL] != 0);
        boolean isOpenBR = (Matrix[bmB][bmR] != 0);
        boolean isOpenBL = (Matrix[bmB][bmL] != 0);
        boolean isOpen = isOpenTR && isOpenTL && isOpenBR && isOpenBL;
        return isOpen;
      }
      return (false);
    }
}
