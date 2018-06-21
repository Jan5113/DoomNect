public class Ball {
  private PVector pos = new PVector(0, 0, 0);
  private PVector vel = new PVector();
  private PVector acc = new PVector(0, -600, 0);
  private float lifetime = 30;
  private float radius = 10;
  
  public Ball(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
  }
  
  public void move(float dt) {
    lifetime -= dt;
    vel = vel.add(PVector.mult(acc,dt));
    pos = pos.add(PVector.mult(vel,dt));
  }
  
  public void draw(PGraphics pg){
    if (lifetime <= 0) return;
    pg.pushMatrix();
    pg.translate(pos.x, pos.y, pos.z);
    pg.noStroke();
    pg.fill(0,0,255);
    pg.sphere(radius);
    pg.popMatrix();
  }
  
}
