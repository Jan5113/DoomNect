import shapes3d.*;
import shapes3d.animation.*;
import shapes3d.utils.*;

PShape s;
Shape3D[] shapes = new Shape3D[1];
Camera c = new Camera(new PVector(0,0,-1));

public void setup() {
  size(1600, 900, P3D);
  //s = loadShape("test.obj");
  
  Box box = new Box(this);
  
  box.fill(color(255));
  box.stroke(color(190));
  box.strokeWeight(1.2f);
  box.setSize(100, 100, 100);
  //    box.rotateTo(radians(45), radians(45), radians(45));
  box.shapeOrientation(null, new PVector(20, 20, 20));
  shapes[0] = box;
}

public void draw() {
  background(51, 204, 255);
  ambientLight(100,100,100);
  directionalLight(255, 255, 255, 0.7, -0.7, 1);
  
  c.draw();
  
  shapes[0].draw();
}