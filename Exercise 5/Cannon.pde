class Cannon {

  PVector position;
  float rot = 0;
  float rotDelta = 2;
  ArrayList<Bullet> bullets;
  PImage img1, img2;
  boolean armRecoil = false;
  float recoilAmount = 4;
  boolean ready = true;
  int readyInterval = 150;
  int markTime = 0;
  
  Cannon(float x, float y) {
    position = new PVector(x, y);
    bullets = new ArrayList<Bullet>();
    img1 = loadImage("cannon.png");
    img2 = loadImage("base.png");
  }
  
  void update() {
    ready = millis() > markTime + readyInterval;
    
    rot += rotDelta;    
    if (rot < -90 || rot > 90) rotDelta *= -1;  
    
    for (int i=bullets.size()-1; i>=0; i--) {
      Bullet bullet = bullets.get(i);
      if (bullet.alive) {
        bullet.run();
      } else {
        bullets.remove(i);
      }
    }
  }
  
  void fire() {
    if (ready) {
      markTime = millis();
      bullets.add(new Bullet(position.x, position.y, rot + rotDelta * 2));
      armRecoil = true;
      
      soundCannon.rate(random(0.8, 1.2));
      soundCannon.jump(0);   
    }
  }
  
  void draw() {
    // back of base
    noStroke();
    fill(0);
    rect(width/2, 506, 8, 30);
    
    // rotating cannon
    pushMatrix(); 
    if (armRecoil) {
      translate(position.x, position.y + recoilAmount);
    } else {
      translate(position.x, position.y);
    }
    rotate(radians(rot));
    
    if (armRecoil) {
      noStroke();
      if (random(1) < 0.5) {
        fill(255, 127, 0);
      } else {
        fill(0, 127, 255);
      }
      blendMode(ADD);
      ellipse(0, -80, 30, 30);
      blendMode(NORMAL);
    }

    image(img1, 0, 0);
    if (armRecoil) {
      blendMode(ADD);
      float r = random(40, 80);
      fill(255, 20);
      ellipse(0, -80, r, r);
      blendMode(NORMAL);
      armRecoil = false;
    }
    popMatrix();
    
    // front of base
    image(img2, width/2, 516);
  }
  
  void run() {
    update();
    draw();
  }

}
