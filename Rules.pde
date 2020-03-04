class Rules{
   PVector[] direction;
   int step = 0;
 
     Rules(int size){
      direction = new PVector[size];
      randomize();
     }
      
      void randomize(){
       for(int i=0; i < direction.length; i++){
        float randomAngle = random(2*PI); 
        direction[i] = PVector.fromAngle(randomAngle);
       }
      }
      
      Rules clone(){
        Rules clone = new Rules(direction.length);
        for(int i = 0; i < direction.length; i++){
          clone.direction[i] = direction[i].copy();
        }
        return clone;
      }
      
      void mutate() {
        float mutationRate = 0.01;
        for(int i = 0; i < direction.length; i++){
          float rand = random(1);
          if(rand < mutationRate ){
            //set this drection as a random driection
            float randomAngle = random(2*PI);
            direction[i] = PVector.fromAngle(randomAngle);
          }
        }
      }
}
