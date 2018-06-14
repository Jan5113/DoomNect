 //<>//
PShape s;
PShape diamondShape;
PShape diamondShape2;
boolean[] moveDir = {false, false, false, false};
Camera c = new Camera(new PVector(0,50,-200));
boolean clicking = false;
float[] lastMousePos = {0,0};
long time;
ArrayList<Ball> balls = new ArrayList<Ball>();
ArrayList<Diamond> diamonds = new ArrayList<Diamond>();
int points;

PGraphics p2, p3;

Diamond d;

public void setup() {
  size(1600, 900, P2D);
  perspective(1  , (float) width/(float) height, 10, 2000);
  
  p2 = createGraphics(width, height, P2D);
  p3 = createGraphics(width, height, P3D);
  
  diamondShape = loadShape("shapes/diamond.obj");
  diamondShape.scale(100);
  diamondShape2 = loadShape("shapes/diamond.obj");
  diamondShape2.scale(10);
  //diamonds.add(new Diamond(new PVector(random(100),random(50),random(50)), diamondShape));
  //diamonds.add(new Diamond(new PVector(random(50),random(50),random(50)), diamondShape));
  
  diamonds.add(new Diamond(new PVector(100,30,400), diamondShape));
  diamonds.add(new Diamond(new PVector(500,30,400), diamondShape));
  diamonds.add(new Diamond(new PVector(200,30,40), diamondShape));
  diamonds.add(new Diamond(new PVector(100,30,200), diamondShape));
  
  /*for(int i = 0; i<10; i++){
  diamonds.add(new Diamond(new PVector(int(random(50)), int(random(50)), int(random(50))), diamondShape));
  //print(random(20,50));
  }*/
  
  smooth(4);
  hint(DISABLE_TEXTURE_MIPMAPS);
  ((PGraphicsOpenGL)g).textureSampling(2);
  /*
  cp5 = new ControlP5(this);
  cc = new MyCanvas();
  cc.pre();
  cp5.addCanvas(cc);
  */
  time = millis();
}

public void draw() {
  background(51, 204, 255);
  
  draw3D(p3);
  drawHUD(p2);
  
  image(p3, 0, 0);
  image(p2, 0, 0);
  moveC();
}

void drawHUD(PGraphics pg){
  pg.beginDraw();
  pg.text("loooooolololol", 10, 10);
  pg.endDraw();
}

void draw3D(PGraphics pg){
  pg.beginDraw();
  pg.clear();
  float dt = (millis() - time)*0.001;
  time = millis();
  
  pg.ambientLight(100,100,100);
  pg.directionalLight(255, 255, 255, 0.7, -0.7, 1);
  pg.smooth(4);
  pg.hint(DISABLE_TEXTURE_MIPMAPS);
  ((PGraphicsOpenGL)g).textureSampling(2);
  
  c.draw(pg);
  
  for (int i = 0; i < balls.size(); i++) {
    balls.get(i).draw(pg);
    balls.get(i).move(dt);
    if (balls.get(i).lifetime<0){
      balls.remove(i);
    }
  }
  for (int i = 0; i < diamonds.size(); i++) {
    diamonds.get(i).draw(pg);
    //println(i);
    //diamonds.get(i).move(dt);
    for (Ball b:balls) {
      if (diamonds.get(i).isColliding(b)){
        diamonds.remove(i);
        println("Removed Diamond:", i);
        balls.remove(b);
        diamonds.add(new Diamond(new PVector(random(-100,500),random(0,100),random(-100,500)), diamondShape));
        points++;
        break;
      
      }
    }
    
  }
  pg.endDraw();
}

public void moveC() {
  float speed = 2;
  if (moveDir[0] && !moveDir[2]) {
    c.move(new PVector(speed, 0, 0));
  } else if (!moveDir[0] && moveDir[2]){
    c.move(new PVector(-speed, 0, 0));
  }
  
  if (moveDir[1] && !moveDir[3]) {
    c.move(new PVector(0, 0, speed));
  } else if (!moveDir[1] && moveDir[3]){
    c.move(new PVector(0,0,-speed));
  }
  
}

public void mousePressed(){
  clicking = true;
  lastMousePos[0] = mouseX; lastMousePos[1] = mouseY;
}

public void points(){
  
}

public void mouseClicked(MouseEvent evt) {
  if (evt.getCount() == 2){
    shootBall();
  }
}

public void mouseReleased(){
  clicking = false;
}

public void mouseDragged(){
  if (clicking) {
    c.rotateView(0.005* (mouseX - lastMousePos[0]), -0.005 * (mouseY - lastMousePos[1]));
    lastMousePos[0] = mouseX; lastMousePos[1] = mouseY;
    //println(lastMousePos[0], lastMousePos[1]);
  }
}


public void shootBall() {
  PVector dir = new PVector (1, 0, 0);
  float rotAz = ((float)mouseX/width-0.5)*1.5;
  float rotEl = ((float)mouseY/height-0.5)*1;
  dir = c.rotY(c.rotZ(dir, c.elevation-rotEl), -c.azimuth-rotAz);
  Ball b = new Ball(c.pos.copy(), dir.mult(750));
  balls.add(b);
}

public void keyPressed() {
  if (key == 'w') {
    moveDir[0] = true;
  } else if (key == 'a') {
    moveDir[1] = true;
  } else if (key == 's') {
    moveDir[2] = true;
  } else if (key == 'd') {
    moveDir[3] = true;
  }
}

public void keyReleased() {
  if (key == 'w') {
    moveDir[0] = false;
  } else if (key == 'a') {
    moveDir[1] = false;
  } else if (key == 's') {
    moveDir[2] = false;
  } else if (key == 'd') {
    moveDir[3] = false;
  } 
}
