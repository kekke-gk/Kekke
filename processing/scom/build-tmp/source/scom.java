import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class scom extends PApplet {

boolean startFlag = false;
boolean finishFlag = false;

PImage targetImg;

ArrayList<Target> targets = new ArrayList<Target>();
ArrayList<Shield> shields = new ArrayList<Shield>();
ArrayList<Missile> missiles = new ArrayList<Missile>();
ArrayList<Bomb> bombs = new ArrayList<Bomb>();
ArrayList<Ripple> ripples = new ArrayList<Ripple>();
Ground ground = new Ground();
Score score = new Score();
Power power = new Power();

public void mouseReleased(){
  startFlag = true;
}  

public void mousePressed(){
  if(!finishFlag && startFlag && mouseButton == LEFT && !ground.contain(mouseX, mouseY)){
    if(power.decrease()){
      shields.add(new Shield(mouseX, mouseY));
    }
  }
}

public void setup(){
  size(600, 500);
  smooth();
  createTarget();
  targetImg = loadImage("target.png");
}

public void draw(){
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
      for(int i = ripples.size()-1; i >= 0; i--){
        ripples.get(i).draw();
        if(ripples.get(i).isMaxSize()){
          ripples.remove(i);
        }
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
  
  public boolean update(){
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
  
  public boolean contain(float x, float y){
    return dist(xPos, yPos, x, y) < size/2;
  }
}
public void collisionTargets(){
  for(int i = targets.size()-1 ; i >= 0; i--){
    for(int j = missiles.size()-1; j >= 0; j--){
      if(targets.get(i).contain(missiles.get(j).xPos, missiles.get(j).yPos)){
        bombs.add(new Bomb(targets.get(i).xPos, targets.get(i).yPos));
        targets.remove(i);
        missiles.remove(j);
        score.increase();
        break;
      }
    }
  }
}

public void collisionShields(){
  for(int i = shields.size()-1 ; i >= 0; i--){
    for(int j = missiles.size()-1; j >= 0; j--){
      if(shields.get(i).contain(missiles.get(j).xPos, missiles.get(j).yPos)){
        if(shields.get(i).small() <= 20){
          bombs.add(new Bomb(shields.get(i).xPos, shields.get(i).yPos));
          shields.remove(i);
        }else{
          ripples.add(new Ripple(missiles.get(j).xPos, missiles.get(j).yPos, shields.get(i)));
        }
        missiles.remove(j);
        score.increase();
        break;
      }
    }
  }
}

public void collisionGround(){
  for(int j = missiles.size()-1; j >= 0; j--){
    if(ground.contain(missiles.get(j).xPos, missiles.get(j).yPos)){
      bombs.add(new Bomb(missiles.get(j).xPos, missiles.get(j).yPos));
      missiles.remove(j);
      score.increase();
    }
  }
}

public void bombChain(){
  for(int i = bombs.size()-1; i >= 0; i--){
    Bomb bomb = bombs.get(i);
    for(int j = targets.size()-1; j >= 0; j--){
      if(bomb.contain(targets.get(j).xPos, targets.get(j).yPos)){
        bombs.add(new Bomb(targets.get(j).xPos, targets.get(j).yPos));
        targets.remove(j);
      }
    }
    for(int j = shields.size()-1; j >= 0; j--){
      if(bomb.contain(shields.get(j).xPos, shields.get(j).yPos)){
        bombs.add(new Bomb(shields.get(j).xPos, shields.get(j).yPos));
        shields.remove(j);
      }
    }
    for(int j = missiles.size()-1; j >= 0; j--){
      if(bomb.contain(missiles.get(j).xPos, missiles.get(j).yPos)){
        bombs.add(new Bomb(missiles.get(j).xPos, missiles.get(j).yPos));
        missiles.remove(j);
        score.increase();
      }
    }

    if(!bomb.update()){
      bombs.remove(i);
      if(targets.size() == 0){
        finishFlag = true;
      }
    }
  }
}



  

public void createTarget(){
  targets.add(new Target(25, height-Ground.GROUND_HEIGHT-25));
  targets.add(new Target(152, height-Ground.GROUND_HEIGHT-25));
  targets.add(new Target(290, height-Ground.GROUND_HEIGHT-25));
  targets.add(new Target(428, height-Ground.GROUND_HEIGHT-25));
  targets.add(new Target(555, height-Ground.GROUND_HEIGHT-25));
}

public void createMissile(){
  if(targets.size() != 0 && frameCount % 50 == 0){
    missiles.add(new Missile());
  }
}
public void drawCursor(){
  stroke(255, 255, 255);
  line(mouseX, mouseY-20, mouseX, mouseY-10);
  line(mouseX, mouseY+20, mouseX, mouseY+10);
  line(mouseX-20, mouseY, mouseX-10, mouseY);
  line(mouseX+20, mouseY, mouseX+10, mouseY);
}

public void drawStart(){
  textAlign(CENTER);
  fill(255, 255, 255);
  textSize(40);
  text("SHIELD COMMAND", 0, height/3, width, 50);
  textSize(22);
  text("CLICK TO START", 0, height*2/3, width, 50);
}

public void drawFinish(){
  fill(255, 0, 0);
  textAlign(CENTER);
  textSize(50);
  text("GAME OVER", 0, height/3, width, 60);  
}
class Ground{
  static final int GROUND_HEIGHT = 100;
  
  public void draw(){
    noStroke();
    fill(139, 69, 19);
    rect(0, height-GROUND_HEIGHT, width, GROUND_HEIGHT);
  }
  
  public boolean contain(float xPos, float yPos){
    return yPos >= height-GROUND_HEIGHT;
  }
}

class Missile{
  float xPos0, yPos0;
  float xPos, yPos;
  float x, y;
  
  Missile(){
    xPos0 = random(width);
    yPos0 = 0;
    xPos = xPos0;
    yPos = yPos0;
    int a = PApplet.parseInt(random(targets.size()));
    x = targets.get(a).xPos - xPos0;
    y = targets.get(a).yPos - yPos0;

    x /= 500;
    y /= 500;
  }
  
  public void update(){
    stroke(255, 255, 255);
    xPos += x;
    yPos += y;
    strokeWeight(2);
    line(xPos, yPos, xPos0, yPos0);
  }
}
class Power{
  float power = 100.0f;
  
  public void draw(){
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
    rect(width-240, 10, 220 * (power / 100.0f), 20);
  }
  
  public void increase(){
    power+=0.1f;
    if(power >= 100){
      power = 100;
    }
  }
  
  public boolean decrease(){
    if(power < 15){
      return false;
    }else{
      power -= 15;
    }
    return true;
  }
}
class Ripple{
  float xPos, yPos;
  float size, speed;
  final float FRICTION = 0.985f;
  Shield shield;
  Ripple(float xPos, float yPos, Shield shield){
    this.xPos = xPos;
    this.yPos = yPos;
    size = 30;
    speed = 5;
    this.shield = shield;
  }
  
  public void draw(){
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
  
  public boolean isMaxSize(){
    if(size > 200){
      return true;
    }
    return false;
  }
  
  public ArrayList<Float> getAngles(){
    ArrayList<Float> angles = new ArrayList<Float>();
    
    float a = shield.xPos-xPos, b = shield.yPos-yPos;
    float c = 0.5f*((shield.size/2-size/2)*(shield.size/2+size/2)-a*(shield.xPos+xPos)-b*(shield.yPos+yPos));
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

class Score{
  int score = 0;
  
  public void draw(){
    fill(0, 0, 255);
    textSize(20);
    textAlign(LEFT);
    text("SCORE : "+score, 5, 25);
  }
  
  public void increase(){
    score += targets.size();
    if(score >= 1000000){
      println("flag");
    }
  }
}
class Shield{
  int size = 80;
  int nSize = 0;
  int xPos, yPos;
  int count = 0;
  
  Shield(int xPos, int yPos){
    this.xPos = xPos;
    this.yPos = yPos;
  }
  
  public void update(){
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
  
  public boolean contain(float x, float y){
    return dist(xPos, yPos, x, y) < nSize/2;
  }
  
  public int small(){   
    size -= 10;
    return nSize;
  }
}
class Target{
  int size[] = {50, 30};
  int xPos, yPos;
  
  Target(int xPos, int yPos){
    this.xPos = xPos;
    this.yPos = yPos;
  }
  
  public void draw(){
    /*
    stroke(155, 155, 155);
    fill(100, 100, 100);
    rect(xPos-size[0]/2, yPos-size[1]/2, size[0], size[1]);
    */
    image(targetImg, xPos-size[0]/2, yPos-size[1]/2);
  }
  
  public boolean contain(float xPos, float yPos){
    return this.xPos-size[0]/2 < xPos && xPos < this.xPos+size[0]/2 && this.yPos-size[1]/2 < yPos && yPos < this.yPos+size[1]/2 ;
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "scom" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
