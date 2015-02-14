/*class Ripple{
  float xPos, yPos;
  float size, speed;
  final float FRICTION = 0.985;
  Ripple(float xPos, float yPos){
    this.xPos = xPos;
    this.yPos = yPos;
    size = 30;
    speed = 5;
  }
  
  void draw(final Shield shield){
    noFill();
    stroke(100, 100, 100, 100 * (speed-1)/3);
    strokeWeight(4);
    arc(xPos, yPos, size, size);
    
    size += speed;
    speed *= FRICTION;
    
  }
  
  float getMinAngle(final Shield shield){
    boolean inShield = shield.contain(xPos + size/2, yPos);
    for(int i = 0; i < 360; i++){
      
      
  }
  
  float getMaxAngle(final Shield shield){
  }
}
*/
