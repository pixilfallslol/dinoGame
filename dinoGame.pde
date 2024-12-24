// Java no internet dino game tutoiral ported to processing original video is this https://www.youtube.com/watch?v=DVI4IvK-R6Q&t=428s

int boardWidth = 750;
int boardHeight = 250;
int velocityY = 0;
int gravity = 1;
int time = 0;
int velocityX = -12;
boolean gameOver2 = false;

PImage bigCactus1, bigCactus2, bigCactus3, bird, bird1, bird2, cactus1, cactus2, cactus3, cloud, dino, dinoDead, dinoDuck, dinoDuck1, dinoDuck2, dinoJump, dinoRun, dinoRun1, dinoRun2, gameOver, reset, track; 
PFont font;
ChromeDinosaur chromeDino;

void setup() {
  chromeDino = new ChromeDinosaur();
  font = loadFont("ComicSansMS-32.vlw");
  textFont(font);
  size(750, 250);
}

void draw() {
  background(200);
  chromeDino.move();
  chromeDino.display();
  drawTime();
}

void drawTime() {
  fill(0);
  text(time, 30, 30);
  if (gameOver2) {
    return;
  }
  time++;
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      if (chromeDino.dinosaur.y == boardHeight - chromeDino.dinosaur.h) {
        velocityY = -17;
      }
    }
  }
}
