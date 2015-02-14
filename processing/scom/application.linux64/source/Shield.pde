class Shield{
  int size = 80;
  int nSize = 0;
  int xPos, yPos;
  int count = 0;
  
  Shield(int xPos, int yPos){
    this.xPos = xPos;
    this.yPos = yPos;
  }
  
  void update(){
    if(size < nSize){
      nSize--;
    }else if(size > nSize){
      nSize += 5;
    }
    noStroke();
    fill(152, 251, 152, 100);
    ellipse(xPos, yPos, nSize, nSize);

    fill(255, 255, 255);
    ellipse(xPos, yPos, 5, 5);

    count = (count+1)%360;
    translate(xPos, yPos);
    rotate(radians(count));
    line(-7, 0, 7, 0);
    ellipse(-7, 0, 3, 3);
    ellipse(7, 0, 3, 3);
    resetMatrix(); 
  }
  
  boolean contain(float x, float y){
    return dist(xPos, yPos, x, y) < nSize/2;
  }
  
  int small(){   
    size -= 10;
    return nSize;
  }
}
