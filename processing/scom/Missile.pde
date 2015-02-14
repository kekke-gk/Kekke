class Missile{
  float xPos0, yPos0;
  float xPos, yPos;
  float x, y;
  
  Missile(){
    xPos0 = random(width);
    yPos0 = 0;
    xPos = xPos0;
    yPos = yPos0;
    int a = int(random(targets.size()));
    x = targets.get(a).xPos - xPos0;
    y = targets.get(a).yPos - yPos0;

    x /= 500;
    y /= 500;
  }
  
  void update(){
    stroke(255, 255, 255);
    xPos += x;
    yPos += y;
    strokeWeight(2);
    line(xPos, yPos, xPos0, yPos0);
  }
}
