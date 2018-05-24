public class Ball {
  private PVector pos = new PVector(0, 0, 0);
  private PVector vel = new PVector();
  private PVector acc = new PVector(0, -1, 0);
  private float lifetime = 10;
  private float radius = 10;
  
  public Ball(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
  }
  
  public void move(float dt) {
    lifetime -= dt;
    vel = vel.add(acc.mult(dt));
    pos = pos.add(vel.mult(dt));
    if(pos.y <= 0) {
      pos.y = 0;
      vel.y = -vel.y;
    };
  }
  
  public void draw(){
    if (lifetime <= 0) return;
    
    sphere(radius);
  }
  
}
