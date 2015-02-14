class Score{
  int score = 0;
  
  void draw(){
    fill(0, 0, 255);
    textSize(20);
    textAlign(LEFT);
    text("SCORE : "+score, 5, 25);
  }
  
  void increase(){
    score += targets.size();
    if(score >= 1000000){
      println("flag");
    }
  }
}
