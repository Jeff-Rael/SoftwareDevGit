class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  
  Particle(float x, float y) {
    pos = new PVector(x, y); 
    vel = new PVector(0,0);
    acc = new PVector(0,0);
  }
  
  void show() {
    ellipseMode(CENTER);
    stroke(255);
    point(pos.x, pos.y);
  }
  
  void update(PVector dir) {
     pos.add(vel);
     vel.add(acc);
     acc = dir;
     vel.limit(cellSize / 10);
     if(pos.x > width - 1) { 
       vel.x *= - 1; 
       pos.x = width - 1;
     }
     if(pos.x < 1) { 
       vel.x *= - 1; 
       pos.x = 1;
     }
     if(pos.y > height - 1) { 
       vel.y *= -1; 
       pos.y = height - 1;
     }
     if(pos.y < 1) { 
       vel.y *= -1; 
       pos.y = 1;
     }
  }
  
  
}
