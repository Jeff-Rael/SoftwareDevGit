class Dot{
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;
  boolean finished;

  Dot(){
   brain = new Brain(967);
   pos = new PVector(startX, startY);
   vel = new PVector(0, 0);
   acc = new PVector(0, 0);
   finished = false;
  }

  void show(){
   fill(0);
   ellipse(pos.x, pos.y, 4, 4);
   if(finished){
     fill(0);
     rect(0,0,800,800);
     textSize(50);
     text("The AI has finished", 50,350);
   }
  }

  void move(){
  if(brain.length >= brain.step){
  acc = brain.directions[brain.step];
  brain.step++;
  print(brain.directions.length+"\n");
  print(brain.step+"\n");
  } else {
    acc = new PVector(0,0);
    finished = true;
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
