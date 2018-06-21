public class Diamond{
  PVector pos;
  float diffy = 0;
  boolean collision;
  int size = 100;
  float phase;
  //Haaa loool sourcetree figgt chnüüü
  PShape d;
  
  public Diamond(PVector position, PShape shape){
    pos = position;
    d = shape;
    phase = random(0, 2*PI);
  }
  
  
  public void draw(PGraphics pg){
    pg.pushMatrix();
    pg.translate(pos.x, pos.y+diffy, pos.z);
    pg.stroke(255, 0, 0);
    pg.fill(9, 255, 255);
    
    pg.shape(d);
    move();

    pg.popMatrix();
  }
  
  public boolean isColliding(Ball b){
    float distance = sqrt(pow(b.pos.x-pos.x, 2)+pow((b.pos.y-(pos.y+diffy+150)),2)+pow(b.pos.z-pos.z, 2));
    
    if(distance <= size){
      
      collision = true;
    }
    
    return collision;    
  }
  
  public void move(){
    diffy = sin(phase + time/500.0)*100;
    pos.z -= 2;
  }
  
}
