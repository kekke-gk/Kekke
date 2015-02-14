class Bomb{
  float xPos, yPos;
  int c0;
  int size;
  
  Bomb(float xPos, float yPos){
    this.xPos = xPos;
    this.yPos = yPos;
    c0 = frameCount;
    size = 50;
  }
  
  boolean update(){
    noStroke();
    if(frameCount < c0 + 30){
      fill(255, 0, 0);
      size++;
    }else if(frameCount < c0 + 50){
      fill(255, 0, 0);
      size--;
    }else{
      return false;
    }
    ellipse(xPos, yPos, size, size);
    return true;
  }
  
  boolean contain(float x, float y){
    return dist(xPos, yPos, x, y) < size/2;
  }
}
