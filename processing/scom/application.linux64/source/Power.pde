class Power{
  float power = 100.0;
  
  void draw(){
    fill(0, 0, 255);
    noStroke();
    textAlign(RIGHT);
    text("POWER : ", width-250, 25);

    if(power < 15){
      fill(255, 0, 0);
    }else if(power < 50){
      fill(255, 255, 0);
    }else{
      fill(0, 0, 255);
    }
    rect(width-240, 10, 220 * (power / 100.0), 20);
  }
  
  void increase(){
    power+=0.1;
    if(power >= 100){
      power = 100;
    }
  }
  
  boolean decrease(){
    if(power < 15){
      return false;
    }else{
      power -= 15;
    }
    return true;
  }
}
