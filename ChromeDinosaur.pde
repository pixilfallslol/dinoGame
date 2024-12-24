import java.awt.*;
import java.awt.event.*;
import java.util.ArrayList;

class ChromeDinosaur {
  int boardWidth = 750;
  int boardHeight = 250;
  int dinosaurWidth = 88;
  int dinosaurHeight = 94;
  int dinosaurX = 50;
  int dinosaurY = boardHeight - dinosaurHeight;

  boolean collision(Block a, Block b) {
    return a.x < b.x + b.w && a.x + a.w > b.x && a.y < b.y + b.h && a.y + a.h > b.y;
  }


  PImage dino, dinoDead, dinoJump, cactus1, cactus2, cactus3;
  Block dinosaur;

  int cactus1Width = 34;
  int cactus2Width = 69;
  int cactus3Width = 102;
  int cactusHeight = 70;
  int cactusX = 700;
  int cactusY = boardHeight - cactusHeight;
  ArrayList<Block> cactusArray;
  int lastCactusTime = 0;
  int cactusDelay = 1500; 

  class Block {
    int x, y, w, h;
    PImage img;

    Block(int x, int y, int w, int h, PImage img) {
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
      this.img = img;
    }

    void draw(PGraphics g) {
      if (img != null) {
        g.image(img, x, y, w, h);
      } else {
        g.fill(255, 0, 0);
        g.rect(x, y, w, h);
      }
    }
  }

  public ChromeDinosaur() {
    dino = loadImage("dino-run1.png");
    dinoDead = loadImage("dino-dead.png");
    dinoJump = loadImage("dino-jump.png");
    cactus1 = loadImage("cactus1.png");
    cactus2 = loadImage("cactus2.png");
    cactus3 = loadImage("cactus3.png");

    dinosaur = new Block(dinosaurX, dinosaurY, dinosaurWidth, dinosaurHeight, dino);
    cactusArray = new ArrayList<Block>();
  }

  void placeCactus() {
    if (gameOver2) {
      return;
    }

    // had to add my own timing stuff lol
    if (millis() - lastCactusTime > cactusDelay) {
      double placeCactusChance = random(0, 0.999999);
      if (placeCactusChance > .90) { // 10% you get cactus3
        Block cactus = new Block(cactusX, cactusY, cactus3Width, cactusHeight, cactus3);
        cactusArray.add(cactus);
      } else if (placeCactusChance > .70) { // 20% you get cactus2
        Block cactus = new Block(cactusX, cactusY, cactus2Width, cactusHeight, cactus2);
        cactusArray.add(cactus);
      } else if (placeCactusChance > .50) { // 50% you get cactus1
        Block cactus = new Block(cactusX, cactusY, cactus1Width, cactusHeight, cactus1);
        cactusArray.add(cactus);
      }
      lastCactusTime = millis();
    }
  }


  void display() {
    if (dinosaur.img != null) {
      image(dinosaur.img, dinosaur.x, dinosaur.y, dinosaur.w, dinosaur.h);
      for (int i = 0; i < cactusArray.size(); i++) {
        Block cactus = cactusArray.get(i);
        image(cactus.img, cactus.x, cactus.y, cactus.w, cactus.h);
      }
    }
  }

  void move() {
    if (gameOver2) {
      return;
    }
    velocityY += gravity;
    dinosaur.y += velocityY;

    if (dinosaur.y > dinosaurY) {
      dinosaur.y = dinosaurY;
      velocityY = 0;
    }

    for (int i = 0; i < cactusArray.size(); i++) {
      Block cactus = cactusArray.get(i);
      cactus.x += velocityX;

      if (collision(dinosaur, cactus)) {
        gameOver2 = true;
        println("game over");
      }
    }
    placeCactus();
  }
}
