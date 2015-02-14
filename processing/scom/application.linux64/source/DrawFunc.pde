void drawCursor(){
  stroke(255, 255, 255);
  line(mouseX, mouseY-20, mouseX, mouseY-10);
  line(mouseX, mouseY+20, mouseX, mouseY+10);
  line(mouseX-20, mouseY, mouseX-10, mouseY);
  line(mouseX+20, mouseY, mouseX+10, mouseY);
}

void drawStart(){
  textAlign(CENTER);
  fill(255, 255, 255);
  textSize(40);
  text("SHIELD COMMAND", 0, height/3, width, 50);
  textSize(22);
  text("CLICK TO START", 0, height*2/3, width, 50);
}

void drawFinish(){
  fill(255, 0, 0);
  textAlign(CENTER);
  textSize(50);
  text("GAME OVER", 0, height/3, width, 60);  
}
