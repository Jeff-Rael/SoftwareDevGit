class Dot{
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;

  Dot(){
   brain = new Brain(967);
   pos = new PVector(startX, startY);
   vel = new PVector(0, 0);
   acc = new PVector(0, 0);
  }

  void show(){
   fill(0);
   ellipse(pos.x, pos.y, 4, 4);
  }

  void move(){
  if(brain.directions.length > brain.step){
  acc = brain.directions[brain.step];
  brain.step++;
  //System.out.println(brain.directions.length);
  //System.out.println(brain.step);
  }
  if(acc.x == 0 && acc.y == 0){
    vel = new PVector(0, 0);
    pos.add(vel);

  }
  else{
  vel.add(acc);
  vel.limit(40);
  pos.add(vel);
  //System.out.println(pos);
  }

  }
}  
