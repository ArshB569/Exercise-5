class Bullet {
  
  PVector position;
  float rot;
  int timestamp;
  float velocity = 10;
  float offset = 50;
  boolean alive = true;
  int lifetime = 1000;

  Bullet(float x, float y, float _rot) {
    position = new PVector(x, y);
    rot = _rot;
    timestamp = millis();
    newPosition(offset);   
  }
  
  void newPosition(float _velocity) {
    position.x += _velocity * sin(radians(rot));
    position.y -= _velocity * cos(radians(rot));  
  }
   
  void update() {
    newPosition(velocity);
    
    if (alive && millis() > timestamp + lifetime) alive = false;
  }
  
  void draw() {
    stroke(255);
    if (fullAuto) {
      if (random(1) < 0.5) {
        fill(0, 255, 255);
      } else {
        fill(0, 0, 255);
      }
    } else {
      if (random(1) < 0.5) {
        fill(255, 0, 0);
      } else {
        fill(0, 0, 255);
      }
    }
    ellipse(position.x, position.y, 10, 10);
  }
  
  void run() {
    update();
    draw();  
  }
  

}
