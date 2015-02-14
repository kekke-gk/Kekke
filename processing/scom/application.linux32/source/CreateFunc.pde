void createTarget(){
  targets.add(new Target(25, height-Ground.GROUND_HEIGHT-25));
  targets.add(new Target(152, height-Ground.GROUND_HEIGHT-25));
  targets.add(new Target(290, height-Ground.GROUND_HEIGHT-25));
  targets.add(new Target(428, height-Ground.GROUND_HEIGHT-25));
  targets.add(new Target(555, height-Ground.GROUND_HEIGHT-25));
}

void createMissile(){
  if(targets.size() != 0 && frameCount % 50 == 0){
    missiles.add(new Missile());
  }
}
