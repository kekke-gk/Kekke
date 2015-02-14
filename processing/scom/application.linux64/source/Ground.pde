class Ground{
  static final int GROUND_HEIGHT = 100;
  
  void draw(){
    noStroke();
    fill(139, 69, 19);
    rect(0, height-GROUND_HEIGHT, width, GROUND_HEIGHT);
  }
  
  boolean contain(float xPos, float yPos){
    return yPos >= height-GROUND_HEIGHT;
  }
}

