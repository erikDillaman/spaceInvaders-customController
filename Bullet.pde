class Bullet
{
  
  PImage sprite = loadImage("data/bullet.png");
  int x, y;
  float yVel = -BULLET_SPEED;
  boolean dead = false;
  
  Bullet(int x){
    this.x = x;
    y = height-50;
    bullets.add(this);
  }  
  
  boolean isDead(){
    return dead;
  }
  
  void killed(){
    dead = true;
  }
  
  boolean offScreen(){
    if (y < -10){
      return true;
    } else {
      return false;
    }
  }
  
  void update(){
    y += yVel;
    image(sprite, x, y);
  }
  
}