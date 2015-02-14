class Target{
  int size[] = {50, 30};
  int xPos, yPos;
  
  Target(int xPos, int yPos){
    this.xPos = xPos;
    this.yPos = yPos;
  }
  
  void draw(){
    /*
    stroke(155, 155, 155);
    fill(100, 100, 100);
    rect(xPos-size[0]/2, yPos-size[1]/2, size[0], size[1]);
    */
    image(targetImg, xPos-size[0]/2, yPos-size[1]/2);
  }
  
  boolean contain(float xPos, float yPos){
    return this.xPos-size[0]/2 < xPos && xPos < this.xPos+size[0]/2 && this.yPos-size[1]/2 < yPos && yPos < this.yPos+size[1]/2 ;
  }
}
