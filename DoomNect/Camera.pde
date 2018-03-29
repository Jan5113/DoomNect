public class Camera {
  private PVector pos = new PVector(0, 0, 0);
  private float azimuth = PI*1.5; // 0 to 2PI
  private float elevation = -0.1; // -PI/2 to PI/2
  
  public Camera() {
  }
  
  
  public Camera(PVector pos) {
    this.pos = pos;
  }
  
  public void moveAbs(PVector dPos) {
    pos = pos.add(dPos);
  }
  
  
  
  public void moveAbs(float x, float y, float z) {
    move(new PVector(x,y,z));
  }
  
  public void move(PVector dPosRot){
    moveAbs(rotY(rotZ(dPosRot, elevation), -azimuth));
  }
  
  public void rotateView(float dAzi, float dEle) {
    azimuth += dAzi;
    elevation += dEle;
    if (elevation < -PI/2) elevation = -PI/2;
    if (elevation > PI/2) elevation = PI/2;
    if (azimuth > 2*PI) azimuth -= 2*PI;
    if (azimuth < 0) azimuth += 2*PI;
  }
  
  public void draw() {
    PVector dir = new PVector (1, 0, 0);
    dir = rotY(rotZ(dir, elevation), -azimuth);
    dir.add(pos);
    camera(pos.x, pos.y, pos.z, dir.x, dir.y, dir.z, 0, -1, 0);
    //pos = rotY(pos, 0.01);
    //azimuth -= 0.01;
  }
  
  private PVector rotY(PVector v, float rad) {
    return new PVector(v.x*cos(rad) - v.z*sin(rad), v.y,v.x*sin(rad) + v.z*cos(rad));
  }
  
  private PVector rotZ(PVector v, float rad) {
    return new PVector(v.x*cos(rad) - v.y*sin(rad), v.x*sin(rad) + v.y*cos(rad), v.z);

  }
  
}
