class gameLogic
{

  int level;
  float fireTimer = millis()+1000;
  boolean freeze = false;



  gameLogic() {
    level = 0;
  }  

  void populate() {
    level++;
    aliens.clear();
    bullets.clear();
    fires.clear();

    if (level == 1) {
      for (int i = 0; i < 5; i++) {
        Alien alienRowOne = new Alien(int(i*150+100), 70, 10, 1, 1, 1, 100);
        Alien alienRowTwo = new Alien(int(i*150+100), 140, -10, 2, 1, 2, 100);

        aliens.add(alienRowOne);
        aliens.add(alienRowTwo);
      }
    }

    if (level == 2) {
      for (int i = 0; i < 5; i++) {
        Alien alienRowOne = new Alien(int(i*150+100), 70, 10, 2, 2, 1, 200);
        Alien alienRowTwo = new Alien(int(i*150+100), 140, -10, 1, 1, 2, 100);

        aliens.add(alienRowOne);
        aliens.add(alienRowTwo);
      }
    }

    if (level == 3) {
      for (int i = 0; i < 5; i++) {
        Alien alienRowOne = new Alien(int(i*150+100), 70, 10, 3, 3, 1, 500);
        Alien alienRowTwo = new Alien(int(i*150+100), 140, -10, 2, 2, 2, 200);
        Alien alienRowThree = new Alien(int(i*150+100), 210, 10, 1, 1, 3, 100);

        aliens.add(alienRowOne);
        aliens.add(alienRowTwo);
        aliens.add(alienRowThree);
      }
    }

    if (level == 4) {
      for (int i = 0; i < 5; i++) {
        Alien alienRowOne = new Alien(int(i*150+100), 70, 10, 3, 3, 1, 1000);
        Alien alienRowTwo = new Alien(int(i*150+100), 140, -10, 2, 2, 2, 200);
        Alien alienRowThree = new Alien(int(i*150+100), 210, 10, 3, 3, 3, 500);

        aliens.add(alienRowOne);
        aliens.add(alienRowTwo);
        aliens.add(alienRowThree);
      }
    }

    if (level == 5) {
      for (int i = 0; i < 5; i++) {
        Alien alienRowOne = new Alien(int(i*150+100), 70, 10, 1, 4, 1, 1500);
        Alien alienRowTwo = new Alien(int(i*150+100), 140, -10, 2, 3, 2, 1000);
        Alien alienRowThree = new Alien(int(i*150+100), 210, 10, 3, 4, 3, 500);

        aliens.add(alienRowOne);
        aliens.add(alienRowTwo);
        aliens.add(alienRowThree);
      }
    }

    if (level > 5) {
      freeze = true;
    }

  }

  boolean endLevel() {
    for (Alien alien : aliens) {
      if (alien.dead == false) return false;
    }
    return true;
  }

  void bulletOffscreen() {

    ArrayList toRemove = new ArrayList();

    for (Bullet bullet : bullets) {
      if (bullet.offScreen()) {
        toRemove.add(bullet);
      } else {
        bullet.update();
      }
    }
    bullets.removeAll(toRemove);
  }

  void fireOffscreen() {

    ArrayList toRemove = new ArrayList();

    for (Fire fire : fires) {
      if (fire.offScreen()) {
        toRemove.add(fire);
      } else {
        fire.update();
      }
    }
    fires.removeAll(toRemove);
  }



  void collisionCheck() {

    ArrayList<Alien> alienRemove = new ArrayList();
    //ArrayList alienRemove2 = new ArrayList();
    ArrayList bulletRemove = new ArrayList();
    ArrayList fireRemove = new ArrayList();

    for (Alien alien : aliens) {
      for (Bullet bullet : bullets) {

        if (abs(bullet.x-alien.x) < 46 && abs(bullet.y-alien.y) < 38) {

          alien.decreaseHealth();
          if (alien.getHealth() <= 0) {
            alienRemove.add(alien);
            alien.killed();
          }

          bulletRemove.add(bullet);
          bullet.killed();
        }
      }
    }

    for (Fire fire : fires) {

      if (abs(fire.x-cannon.x) < 35 && abs(fire.y-cannon.y) < 35) {
        cannon.hit();
        fireRemove.add(fire);
      }
    }
    
    for (Alien alien : alienRemove){
      myScore += alien.getScore();  
    }
    fires.removeAll(fireRemove);
    bullets.removeAll(bulletRemove);
    aliens.removeAll(alienRemove);
  }

  void makeFire() {

    if (millis()-fireTimer > 500 && aliens.size() > 0) {
      int indexMax = aliens.size();
      int whichSprite = int(random(0, indexMax));

      Alien alien = aliens.get(whichSprite);
      Fire fire = new Fire(alien.x, alien.y);

      fireTimer = millis();
    }
  }

  void topInfo() {
    fill(50);
    rect(0, 0, 800, 30);
    fill(255);
    textFont(gameFont);
    text("Level: ", 25, 25);
    text("Health: ", 250, 25);
    text("Score: ", 500, 25);

    for (int i = 0; i <= cannon.health-1; i++) {
      fill(160+(i*60), 80+(i*40), 20);
      strokeWeight(2);
      stroke(0);
      rect((370+(i*15)), 4, 13, 22);
    }
    
    fill(200, 180, 20);
    text(level, 130, 25);
    text(myScore, 600, 25);   
  }

  void gameOver() {
    textFont(gameFont2);
    fill(200, 180, 20);
    text("Game Over", 67, 327);
    fill(180, 80, 0);
    text("Game Over", 70, 330);
    fill(255);
    textFont(gameFont);
    text("Press <SPACE> to Restart ", 330, 400);
  }
  
  void endGame(){
    freeze = true;
    textFont(gameFont2);
    fill(200, 180, 20);
    text("You Win!", 127, 327);
    fill(180, 80, 0);
    text("You Win!", 130, 330);
  }
    
  void levelCheck(){
    if (aliens.size() <= 0){
      cannon.health++;
      cannon.darken();
      populate();  
    }
  }
  
}