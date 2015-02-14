void collisionTargets(){
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

void collisionShields(){
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

void collisionGround(){
  for(int j = missiles.size()-1; j >= 0; j--){
    if(ground.contain(missiles.get(j).xPos, missiles.get(j).yPos)){
      bombs.add(new Bomb(missiles.get(j).xPos, missiles.get(j).yPos));
      missiles.remove(j);
      score.increase();
    }
  }
}

void bombChain(){
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



  

