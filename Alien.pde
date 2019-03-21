class Alien
{

  int x, y, speed, row, health, type;
  boolean flipFlap, dead = false;
  PImage[] pos = new PImage[2];
  int counter = 0;
  int tint = 50;
  int score;

  Alien(int x, int y, int speed, int row, int health, int type, int score) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.row = row;
    this.health = health;
    this.type = type;
    this.score = score;

    for (int i = type; i < type+1; i++) {
      for (int j = 1; j < 3; j++) {
        pos[counter] = loadImage("data/alien"+i+"_"+j+".png");
        counter++;
      }
    }
    
  }

  void drawSprite() {
    if (!dead) {
      if (flipFlap) {
        image(pos[0], x, y);
      } else {
        image(pos[1], x, y);
      }
    }
  }

  void moveSprite() {
    x += speed;
    flipFlap = !flipFlap;
  }

  void wallColl() {
    for (Alien alien : aliens) {
      if (alien.x >= 770 || alien.x <= 30) {
        alien.speed = -speed;
        alien.x += (alien.speed/abs(alien.speed))*10;
        alien.y += 70;
      }
      if (alien.y >= 540){
        cannon.health = 0;
        logic.freeze = true;
      }
    }
  }

  boolean isDead() {
    return dead;
  }
  
  int getScore(){
    return score;
  }

  void killed() {
    dead = true;
  }

  int getHealth() {
    return health;
  }

  void decreaseHealth() {
    health--;
    darken();
  }

  void darken(){
    for (int k = 0; k < 2; k++){
      pos[k].loadPixels();
      for (int i = 0, j = pos[k].pixels.length; i < j; i++){
        pos[k].pixels[i] = color(red(pos[k].pixels[i]), green(pos[k].pixels[i])-50, blue(pos[k].pixels[i])-50, alpha(pos[k].pixels[i]));  
      }
      pos[k].updatePixels();
    }
  }

  void lighten(){
    for (int k = 0; k < 2; k++){
      pos[k].loadPixels();
      for (int i = 0, j = pos[k].pixels.length; i < j; i++){
        pos[k].pixels[i] = color(red(pos[k].pixels[i])+50, green(pos[k].pixels[i])+50, blue(pos[k].pixels[i])+50, alpha(pos[k].pixels[i]));  
      }
      pos[k].updatePixels();
    }
  }


  void bulletColl() {

    ArrayList toRemove = new ArrayList();

    for (Bullet bullet : bullets) {
      if (abs(bullet.x-x) < 52 && abs(bullet.y-y) < 42) {
        toRemove.add(bullet);
        dead = true;
        //logic.alienUpdate(alien);
      }
    }
    bullets.remove(toRemove);
  }
}