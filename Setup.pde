Node test;

void setup(){
 size(800,800); 
 test = new Node();
}

void draw(){
  background(255);
  test.update();
  test.show();
}
