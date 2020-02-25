class Node{
 PVector position;
 PVector velocity;
 PVector acceleration;
 Rules rules;
 boolean dead = false;

      Node(){
        rules = new Rules(400);
        position = new PVector(width/2,height/2);
        velocity = new PVector(0,0);
        acceleration = new PVector(0,0);
        
        
      }
      
      void show(){
       fill(0);
       ellipse(position.x, position.y,4,4); //look up ellipse function 
      }
      
      void move(){
        if(rules.direction.length > rules.step){
          acceleration = rules.direction[rules.step];
          rules.step++;
        }
        else{
         dead = true; 
        }
        
        velocity.add(acceleration);
        velocity.limit(5);
        position.add(velocity);
      }
      
      void update(){
        if(!dead){
          move();
           if(position.x < 100 || position.y < 100 || position.x > width-100 || position.y > height-100){
             dead = true;
      }
    }
  } 
}
