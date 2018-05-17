import shapes3d.*;
import shapes3d.animation.*;
import shapes3d.utils.*;

import KinectPV2.KJoint;
import KinectPV2.*;

KinectPV2 kinect;

PShape s;
Shape3D[] shapes = new Shape3D[1];
boolean[] moveDir = {false, false, false, false};
Camera c = new Camera(new PVector(0,50,-200));
boolean clicking = false;
float[] lastMousePos = {0,0};
long time;

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
  s = loadShape("shapes/pickaxe.obj");
  s.translate(0,0,-70);
  s.rotateX(0.5*PI);
  
  smooth(4);
  hint(DISABLE_TEXTURE_MIPMAPS);
  ((PGraphicsOpenGL)g).textureSampling(2);
  
  time = millis();
}

public void draw() {
  long t = millis() - time;
  time = millis();
  
  background(51, 204, 255);
  ambientLight(100,100,100);
  directionalLight(255, 255, 255, 0.7, -0.7, 1);
  
  c.draw();
  shape(s);
  s.translate(0,0.5 * sin(time/500.0),0);
  s.rotateY(0.01);
  shapes[0].draw();
  
  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeleton3d();

  //individual JOINTS
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();

      //Draw body
      color col  = skeleton.getIndexColor();
      stroke(col);
      drawBody(joints);
    }
  }
  
  moveC();
  
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

void drawBody(KJoint[] joints) {
  drawJoint(joints, KinectPV2.JointType_HandTipLeft);
  drawJoint(joints, KinectPV2.JointType_HandTipRight);
  drawJoint(joints, KinectPV2.JointType_FootLeft);
  drawJoint(joints, KinectPV2.JointType_FootRight);

  drawJoint(joints, KinectPV2.JointType_ThumbLeft);
  drawJoint(joints, KinectPV2.JointType_ThumbRight);

  drawJoint(joints, KinectPV2.JointType_Head);
}

void drawJoint(KJoint[] joints, int jointType) {
  strokeWeight(2.0f + joints[jointType].getZ()*8);
  point(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());
}
