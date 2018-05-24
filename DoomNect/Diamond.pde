public class Diamond{
  PVector pos;
  boolean collision;
  int size = 10;
  
  public Diamond(PVector position){
    pos = position;
     
  }
  
  public void draw(){
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    stroke(255, 0, 0);
    fill(9, 255, 255);
    sphere(size);
    popMatrix();
  }
  
  public boolean isColliding(Ball b){
    float distance = sqrt(b.pos.x*b.pos.x+b.pos.y*b.pos.y+b.pos.z*b.pos.z);
    
    if(distance <= size){
      collision = true;
    }
    
    return collision;    
  }
  
}