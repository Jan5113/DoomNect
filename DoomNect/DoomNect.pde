import shapes3d.*;
import shapes3d.animation.*;
import shapes3d.utils.*;

PShape s;
Shape3D[] shapes = new Shape3D[1];
boolean[] moveDir = {false, false, false, false};
Camera c = new Camera(new PVector(0,50,-200));
boolean clicking = false;
float[] lastMousePos = {0,0};

public void setup() {
  size(1600, 900, P3D);
  //s = loadShape("test.obj");
  
  Box box = new Box(this);
  
  box.fill(color(0, 204, 0));
  box.stroke(color(255,0,0));
  box.strokeWeight(5.2f);
  box.setSize(400, 40, 400);
  box.shapeOrientation(null, new PVector(0, -20, 0));
  shapes[0] = box;
}

public void draw() {
  background(51, 204, 255);
  ambientLight(100,100,100);
  directionalLight(255, 255, 255, 0.7, -0.7, 1);
  
  c.draw();
  
  shapes[0].draw();
  
  moveC();
  
}

public void moveC() {
  float speed = 10;
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

public void mouseReleased(){
  clicking = false;
}

public void mouseDragged(){
  if (clicking) {
    c.rotateView(0.005* (mouseX - lastMousePos[0]), -0.005 * (mouseY - lastMousePos[1]));
    lastMousePos[0] = mouseX; lastMousePos[1] = mouseY;
    println(lastMousePos[0], lastMousePos[1]);
  }
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
