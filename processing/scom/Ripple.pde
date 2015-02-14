class Ripple{
  float xPos, yPos;
  float size, speed;
  final float FRICTION = 0.985;
  Shield shield;
  Ripple(float xPos, float yPos, Shield shield){
    this.xPos = xPos;
    this.yPos = yPos;
    size = 30;
    speed = 5;
    this.shield = shield;
  }
  
  void draw(){
    noFill();
    stroke(100, 100, 100, 100 * (speed-1)/3);
    strokeWeight(4);
    
    ArrayList<Float> angles = getAngles();
    if(angles.size() == 0){
      ellipse(xPos, yPos, size, size);
    }else{
      arc(xPos, yPos, size, size, angles.get(0), angles.get(1));
    }

    size += speed;
    speed *= FRICTION;
  }
  
  boolean isMaxSize(){
    if(size > 200){
      return true;
    }
    return false;
  }
  
  ArrayList<Float> getAngles(){
    ArrayList<Float> angles = new ArrayList<Float>();
    
    float a = shield.xPos-xPos, b = shield.yPos-yPos;
    float c = 0.5*((shield.size/2-size/2)*(shield.size/2+size/2)-a*(shield.xPos+xPos)-b*(shield.yPos+yPos));
    float x1 = shield.xPos, y1 = shield.yPos;
    float r = shield.size/2;
    float l = a*a+b*b;
    float k = a*x1+b*y1+c;
    float d = l*r*r-k*k;
    
    if(d>0){
      float ds = sqrt(d);
      float apl = a/l;
      float bpl = b/l;
      float xc = x1-apl*k;
      float yc = y1-bpl*k;
      float xd = bpl*ds;
      float yd = apl*ds;
      
      float xPos1 = xc-xd, yPos1 = yc+yd;
      float xPos2 = xc+xd, yPos2 = yc-yd;
      
      float v1x = xPos1 - xPos, v1y = yPos1 - yPos;
      float v2x = xPos2 - xPos, v2y = yPos2 - yPos;
      //acos((v1x*v2x)+(v1y*v2y) / (sqrt(pow(v1x, 2)+pow(v1y, 2))*sqrt(pow(v2x, 2)+pow(v2y, 2))));
      float angle1 = acos(v1x / (sqrt(pow(v1x, 2)+pow(v1y, 2))));
      if(v1y > yPos){
        angle1 = TAU - angle1;
      }
      
      float angle2 = acos(v2x / (sqrt(pow(v2x, 2)+pow(v2y, 2))));
      if(v2y > yPos){
        angle2 = TAU - angle2;
      }
      
      angles.add(min(angle1, angle2));
      angles.add(max(angle1, angle2));
    }
    return angles;
  }
}

