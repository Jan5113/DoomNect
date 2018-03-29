public class Camera {
  private PVector pos = new PVector(0, 0, 0);
  private float azimuth = PI*1.5; // 0 to 2PI
  private float elevation = 0; // -PI/2 to PI/2
  
  public Camera() {
  }
  
  
  public Camera(PVector pos) {
    this.pos = pos;
  }
  
  public void move(PVector translation) {
    pos = pos.add(translation);
  }
  
  
  
  public void move(float x, float y, float z) {
    move(new PVector(x,y,z));
  }
  
  public void draw() {
    PVector dir = new PVector (1, 0, 0);
    dir = rotZ(dir, elevation);
    dir = rotY(dir, -azimuth);
    
    camera(pos.x, pos.y, pos.z, pos.add(dir).x, pos.add(dir).y, pos.add(dir).z, 0, -1, 0);
  }
  
  private PVector rotY(PVector v, float rad) {
    return new PVector(v.x*cos(rad) - v.z*sin(rad), v.y,v.x*sin(rad) + v.z*cos(rad));
  }
  
  private PVector rotZ(PVector v, float rad) {
    return new PVector(v.x*cos(rad) - v.y*sin(rad), v.x*sin(rad) + v.y*cos(rad), v.z);

  }
  
}