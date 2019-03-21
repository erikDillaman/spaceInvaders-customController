class Fire
{

  int x, y;
  float yVel = FIRE_SPEED;
  PImage[] sprite = new PImage[4];
  int timer = millis();

  Fire(int x, int y) {

    this.x = x;
    this.y = y;

    for (int j = 0; j < 4; j++) {
      sprite[j] = loadImage("data/fire"+j+".png");
    }

    fires.add(this);
  }

  boolean offScreen() {
    if (y > height) {
      return true;
    } else {
      return false;
    }
  }

  void update() {
    y += yVel;
    if (millis() - timer > 1500) {
      image(sprite[3], x, y);
    } else if (millis() - timer > 1000) {
      image(sprite[2], x, y);
    } else if (millis() - timer > 500) {
      image(sprite[1], x, y);
    } else {
      image(sprite[0], x, y);
    }
  }
}