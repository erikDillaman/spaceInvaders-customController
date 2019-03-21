/*--------------------------------------------------

  Space Invaders v2.0          Arduino Edition
          Programmed by: Erik Dillaman
          
---------------------------------------------------*/
// Importing Arduino Libraries /////////////////////////////////////////////////////////////////////////////
import processing.serial.*;
import cc.arduino.*;
////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Arduino Variable Declarations /////////////////////////////////////////////////////////////////////////////
// CHANGE VALUES BELOW IN ORDER TO CORRESPOND TO YOUR WIRING ON THE ARDUINO
Arduino arduino;
int digPin = 8;  // Change this to be the digital port of the first switch
int digPin2 = 9;   // Change this to be the digital port of the second switch
int anaPin = 0;    // Change this to be the analog port of the potentiometer
float screenPos, screenPos2 = 400;
boolean moved = false;
boolean buttonState = true;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

ArrayList<Alien> aliens = new ArrayList<Alien>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Fire> fires = new ArrayList<Fire>();
gameLogic logic = new gameLogic();
Cannon cannon;
int animTime, animTime2, myScore = 0;
int CANNON_SPEED = 6;
int BULLET_SPEED = 10;
int FIRE_SPEED = 6;
PFont gameFont, gameFont2;


void setup()
{
  size(800, 600);
  imageMode(CENTER);
  //  noCursor();
  gameInit();
  gameFont = createFont("data/pixel_pirate.ttf", 20);
  gameFont2 = createFont("data/pixel_pirate.ttf", 80);

  // Arduino Variable Initializations //////////////////////////////////////////////////////////////////////////
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(digPin, Arduino.INPUT);
  arduino.pinMode(digPin2, Arduino.INPUT);
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////
}

void draw()
{

  // Game Logic Checks /////////////////////////////////////////////////////////////////////////////////////////
  if (!logic.freeze) {
    background(0);
    logic.bulletOffscreen();
    logic.fireOffscreen();
    logic.collisionCheck();
    logic.makeFire();
    cannon.update();

    //Animation Frames /////////////////////////////////////////////////////////////////////////////////////////
    if (millis() - animTime > 1000-(logic.level*175)) {
      for (Alien alien : aliens) {
        alien.moveSprite();
        alien.wallColl();
      }
      animTime = millis();
    }

    //Alien drawing updates /////////////////////////////////////////////////////////////////////////////////////////
    for (Alien alien : aliens) {
      alien.drawSprite();
    }


    //Arduino Functions /////////////////////////////////////////////////////////////////////////////////////////
    screenPos = map(arduino.analogRead(anaPin), 0, 1023, 0, 800);
    
    if(screenPos != screenPos2){
      cannon.move((int)screenPos);
      screenPos2 = screenPos;
    }
    
    if(arduino.digitalRead(digPin) == 0) buttonState = true;
     
    if(arduino.digitalRead(digPin) == 1 && buttonState){
      Bullet bullet = new Bullet(cannon.x);
      buttonState = false;
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    logic.topInfo();
    logic.levelCheck();
  }

  if (logic.freeze) {
    if (cannon.health<=0) logic.gameOver(); 
    else logic.endGame();
  }
}

void gameInit()
{
  logic.populate();
  cannon = new Cannon(width/2, height-50, CANNON_SPEED);
}

void keyPressed()
{
  if (keyPressed && logic.freeze) {
    if (key == CODED) {
      if (keyCode == ENTER) {
        myScore = 0;
        logic.level = 0;
        gameInit();

        logic.freeze = false;
        logic.populate();
      }
    }
  }
}