import shapes3d.*;
import shapes3d.animation.*;
import shapes3d.utils.*;

Camera c = new Camera();
Box box;

float d = 50;

void setup(){
  size(1000, 1000, P3D);
  box = new Box(this, 50, 50, 50);
  box.fill(213,34);
  box.stroke(color(64, 0, 64));
  box.strokeWeight(0.6);
  box.drawMode(S3D.SOLID | S3D.WIRE);
  box.moveTo(random(-d, d), random(-d, d), random(-d, d));
  
}

void draw(){
  background(128);
  pushMatrix();
  box.draw();
  popMatrix();
  
  c.draw();
}