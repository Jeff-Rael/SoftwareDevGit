class Node{
 PVector position;
 PVector velocity;
 PVector acceleration;
 Rules rules;
 
 boolean dead = false;
 boolean reachedGoal = false;
 Boolean isBest = false;
 float fitness = 0;
 
      Node(){
        rules = new Rules(400);
        position = new PVector(width/2,height-10);
        velocity = new PVector(0,0);
        acceleration = new PVector(0,0);
      }
      
      void show(){
        if(isBest){
          fill(0, 255,0); // Show previous best node as green
          ellipse(position.x, position.y,4,4);
        } else {
          fill(0);
          ellipse(position.x, position.y,4,4); //look up ellipse function 
        }
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
        if(!dead && !reachedGoal){
          move();
           if(position.x < 2 || position.y < 2 || position.x > width-2 || position.y > height-2){
             dead = true;
          } else if(dist(position.x,position.y,goal.x,goal.y) < 5){
            // if reached goal
            reachedGoal = true;
          } else if(obstacle.checkCollision(position.x,position.y)){ // lazy way to check if in rectange. can be done in the class
            dead = true;
          }
        }
      } 
      
      void calculateFitness(){
        if(reachedGoal){ // function assures any dot that reaches the goal has better fitness than those who don't
          fitness = 1.0/16.0 + 10000.0/(float)(rules.step * rules.step);
        } else {
          float distanceToGoal = dist(position.x, position.y, goal.x, goal.y);
          fitness = 1.0/(distanceToGoal * distanceToGoal);
        }
      }
      
    Node findChild(){
      Node child = new Node();
      child.rules = rules.clone();
      return child;
  }
}
