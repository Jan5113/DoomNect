public class Ball {
  private PVector pos = new PVector(0, 0, 0);
  private PVector vel = new PVector();
  private PVector acc = new PVector(0, -500, 0);
  private float lifetime = 10;
  private float radius = 10;
  
  public Ball(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
  }
  
  public void move(float dt) {
    lifetime -= dt;
    vel = vel.add(PVector.mult(acc,dt));
    pos = pos.add(PVector.mult(vel,dt));
    if(pos.y <= radius) {
      pos.y = radius;
      vel.y = -vel.y*0.95;
    };
  }
  
  public void draw(){
    if (lifetime <= 0) return;
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    noStroke();
    fill(0,0,255);
    sphere(radius);
    popMatrix();
  }
  
}
