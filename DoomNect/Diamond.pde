public class Diamond{
  PVector pos;
  float ystart;
  boolean collision;
  int size = 100;
  //Haaa loool sourcetree figgt chnüüü
  PShape d;
  
  public Diamond(PVector position, PShape shape){
    pos = position;
    ystart = position.y;
    d = shape;
    d.scale(20);
    
  }
  
  
  public void draw(){
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    stroke(255, 0, 0);
    fill(9, 255, 255);
    
    shape(d);
    move();
    //sphere(size);
    
    /*
    beginShape();
    vertex(-10, -10, -10);
    vertex( 10, -10, -10);
    vertex(  0,   0,  10);
    
    vertex( 10, -10, -10);
    vertex( 10,  10, -10);
    vertex(  0,  0,  10);
    
    vertex( 10, 10, -10);
    vertex(-10, 10, -10);
    vertex(  0,  0,  10);
    
    vertex(-10,  10, -10);
    vertex(-10, -10, -10);
    vertex(  0,   0,  10);
    endShape()
    */

    popMatrix();
  }
  
  public boolean isColliding(Ball b){
    float distance = sqrt(b.pos.x*b.pos.x+b.pos.y*b.pos.y+b.pos.z*b.pos.z);
    
    if(distance <= size){
      
      collision = true;
    }
    
    return collision;    
  }
  
  public void move(){
    pos.y = ystart*sin(time/500.0) + ystart;
    
    
  }
  
}