import shapes3d.*;
import shapes3d.animation.*;
import shapes3d.utils.*;

float x, y, z;
float fov = PI/3;
float cameraZ = (height/2.0) / tan(fov/2.0);

PVector cPos;
PVector speed;

void setup(){
  size(640,360,P3D);
  background(0);
  perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);
  
  cPos = new PVector(width/2, height/2, height/tan(PI/6));
  speed = new PVector(0, 0, 0);
}

void draw(){
  
  lightSetup();
  
  /* #simple 3d shapes
  pushMatrix();
  translate(130, height/2, 0);
  rotateY(1.25);
  rotateX(0.4);
  noStroke();
  box(100);
  popMatrix();
  
  pushMatrix();
  translate(500, height*0.35, -200);
  noFill();
  stroke(255);
  sphere(280);
  popMatrix();
  
  #custom shapes
  translate(width/2, height/2, 0);
  stroke(255);
  rotateX(PI/2);
  rotateZ(-PI/6);
  noFill();
  
  beginShape();
  vertex(-100, -100, -100);
  vertex( 100, -100, -100);
  vertex(   0,    0,  100);
  
  vertex( 100, -100, -100);
  vertex( 100,  100, -100);
  vertex(   0,    0,  100);
  
  vertex( 100, 100, -100);
  vertex(-100, 100, -100);
  vertex(   0,   0,  100);
  
  vertex(-100,  100, -100);
  vertex(-100, -100, -100);
  vertex(   0,    0,  100);
  endShape();
  
  #lights
  background(0);
  translate (100, 100, 0);
  if(mousePressed){
    lights();
  }
  
  noStroke();
  fill(255);
  sphere(50);
    
  #Perspective
  background(0);
  lights();

  if(mousePressed) {
    float fov = PI/3.0; 
    float cameraZ = (height/2.0) / tan(fov/2.0); 
    perspective(fov, float(width)/float(height), cameraZ/2.0, cameraZ*2.0); 
  } else {
    ortho(-width/2, width/2, -height/2, height/2);
  }
  translate(width/2, height/2, 0);
  rotateX(-PI/6); 
  rotateY(PI/3); 
  box(160); 
  */
  
  
  background(0);
  camera(cPos.x, cPos.y, cPos.z, mouseX, mouseY, 0, 0, 1, 0);
  translate(width/2, height/2, -100);
  //stroke(55, 200, 55);
  noStroke();
  fill(255, 255, 255);
  sphere(200);
  
  move();
}

void move(){
  cPos.x += speed.x;
  cPos.y += speed.y;
  cPos.z += speed.z;
}

void keyPressed(){
  if(key == 'w'){
    speed.z = -10;
  }
  if(key == 's'){
    speed.z = 10;
  }
  if(key == 'a'){
    speed.x = -10;
  }
  if(key == 'd'){
    speed.x = 10;
  }
}

void keyReleased(){
  speed = new PVector(0, 0, 0);
}

void lightSetup(){
  //lights();
  //directionalLight(255, 0, 255, 0, -1, 0);
  spotLight(255, 0, 255, width*0.6, height/2, 400, 0, 0, -1, PI/6, 2);
}