class Cannon
{
  int x, y, speed, health;
  boolean boost; 
  PImage sprite = loadImage("data/cannon.png");

  Cannon(int x, int y, int speed) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    health = 3;
    boost = false;
  }

  void update() {
    image(sprite, x, y);
  }

  void move(int mult) {
    if (x > 30 & x < width-30) {
      x = mult;
    }

    if (x <= 30) x++;
    if (x >= width-30) x--;
  }

  void hit() { 
    lighten();
    health -= 1;
    if (health <= 0) {   
     logic.freeze = true;
    }
  }

  void darken() {
    for (int i = 0, j = sprite.pixels.length; i < j; i++) {
      sprite.pixels[i] = color(red(sprite.pixels[i])+50, green(sprite.pixels[i])-50, blue(sprite.pixels[i])-50, alpha(sprite.pixels[i]));
    }
    sprite.updatePixels();
  }

  void lighten() {
    for (int i = 0, j = sprite.pixels.length; i < j; i++) {
      sprite.pixels[i] = color(red(sprite.pixels[i])+70, green(sprite.pixels[i])+70, blue(sprite.pixels[i])+70, alpha(sprite.pixels[i]));
    }
    sprite.updatePixels();
  }
  
  
}