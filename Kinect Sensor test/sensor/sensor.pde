import shapes3d.*;
import shapes3d.animation.*;
import shapes3d.utils.*;
import KinectPV2.*;

int bilds = 400;

KinectPV2 kinect;

void setup() {
  size(1820,900);
  kinect = new KinectPV2(this);
  //Start up methods go here
  kinect.enableColorImg(true);
  kinect.enableBodyTrackImg(true);
  kinect.enableInfraredImg(true);
  kinect.enableDepthImg(true);
  kinect.init();
  
}

void draw()
{
  background(0);
  PImage bodyI = kinect.getBodyTrackImage();
  PImage colorI = kinect.getColorImage();
  PImage infraredI = kinect.getInfraredImage();
  PImage debthI = kinect.getDepthImage();
  image(bodyI,0,0,200,200);
  image(colorI,200,0,200,200);
  image(infraredI,0,200,200,200);
  image(debthI,200,200,200,200);
}