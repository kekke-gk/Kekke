boolean startFlag = false;
boolean finishFlag = false;

PImage targetImg;

ArrayList<Target> targets = new ArrayList<Target>();
ArrayList<Shield> shields = new ArrayList<Shield>();
ArrayList<Missile> missiles = new ArrayList<Missile>();
ArrayList<Bomb> bombs = new ArrayList<Bomb>();
Ground ground = new Ground();
Score score = new Score();
Power power = new Power();

void mouseReleased(){
  startFlag = true;
}  

void mousePressed(){
  if(!finishFlag && startFlag && mouseButton == LEFT && !ground.contain(mouseX, mouseY)){
    if(power.decrease()){
      shields.add(new Shield(mouseX, mouseY));
    }
  }
}

void setup(){
  size(600, 500);
  smooth();
  createTarget();
  targetImg = loadImage("target.png");
}

void draw(){
  background(0, 0, 0);
  ground.draw();
  for(Target target : targets){
    target.draw();
  }

  if(startFlag){
    if(!finishFlag){
      collisionTargets();
      collisionShields();
      collisionGround();
      
      bombChain();
      
      for(Shield shield : shields){
        shield.update();
      }
      for(Missile missile : missiles){
        missile.update();
      }
      
      power.increase();
      
      createMissile();
 
    }else{
      drawFinish();
    }
    score.draw();
    power.draw();
  }else{
    drawStart();               
  }
  drawCursor();
}
