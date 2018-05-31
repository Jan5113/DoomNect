import shapes3d.*;
import shapes3d.animation.*;
import shapes3d.utils.*;
import KinectPV2.KJoint;
import KinectPV2.*;

KinectPV2 kinect;

PShape s;
PShape diamondShape;
Shape3D[] shapes = new Shape3D[1];
boolean[] moveDir = {false, false, false, false};
Camera c = new Camera(new PVector(0,50,-200));
boolean clicking = false;
float[] lastMousePos = {0,0};
long time;
ArrayList<Ball> balls = new ArrayList<Ball>();
ArrayList<Diamond> diamonds = new ArrayList<Diamond>();
int points;

Diamond d;

public void setup() {
  size(1600, 900, P3D);
  perspective(1  , (float) width/(float) height, 10, 2000);
  
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
  diamondShape = loadShape("shapes/diamond.obj");
  diamonds.add(new Diamond(new PVector(50, 50, 50), diamondShape));
  
  
  smooth(4);
  hint(DISABLE_TEXTURE_MIPMAPS);
  ((PGraphicsOpenGL)g).textureSampling(2);
  
  time = millis();
  
  kinect = new KinectPV2(this);

  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);

  kinect.init();
}

public void draw() {
  float dt = (millis() - time)*0.001;
  time = millis();
  
  background(51, 204, 255);
  ambientLight(100,100,100);
  directionalLight(255, 255, 255, 0.7, -0.7, 1);
  
  c.draw();
  shape(s);
  s.translate(0,0.5 * sin(time/500.0),0);
  s.rotateY(0.01);
  shapes[0].draw();
  //text("Points: "+ points, 1300,0);
  
  for (int i = 0; i < balls.size(); i++) {
    balls.get(i).draw();
    balls.get(i).move(dt);
    if (balls.get(i).lifetime<0){
      balls.remove(i);
    }
  }
  for (int i = 0; i < diamonds.size(); i++) {
    diamonds.get(i).draw();
    //diamonds.get(i).move(dt);
    for (Ball b:balls) {
      if (diamonds.get(i).isColliding(b)){
        diamonds.remove(i);
        points++;
        break;
      
      }
    }
    ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();

  //individual JOINTS
  for (i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();

      color col  = skeleton.getIndexColor();
      fill(col);
      stroke(col);

      //draw different color for each hand state
      drawHandState(joints[KinectPV2.JointType_HandRight]);
      drawHandState(joints[KinectPV2.JointType_HandLeft]);
    }
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

public void points(){
  
}

public void mouseClicked(MouseEvent evt) {
  if (evt.getCount() == 2){
    shootBall(mouseX,mouseY);
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

public void shootBall(float x, float y) {
  x = ((float)x/width-0.5);
  y = ((float)y/height-0.5);
  PVector dir = new PVector (1, 0, 0);
  float rotAz = x*1.5;
  float rotEl = y;
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

void drawHandState(KJoint joint) {
  handState(joint);
  //translate(joint.getX(), joint.getY(), joint.getZ());
}

void handState(KJoint j) {
  int handState = j.getState();
  switch(handState) {
  case KinectPV2.HandState_Open:
    shootBall(j.getX(), j.getY());
    println(j.getX(), j.getY());
    break;
  case KinectPV2.HandState_Closed:
    fill(255, 0, 0);
    break;
  case KinectPV2.HandState_Lasso:
    fill(0, 0, 255);
    break;
  case KinectPV2.HandState_NotTracked:
    fill(255, 255, 255);
    break;
  }
}
