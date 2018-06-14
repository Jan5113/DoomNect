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
    
  }
  
  
  public void draw(PGraphics pg){
    pg.pushMatrix();
    pg.translate(pos.x, pos.y, pos.z);
    pg.stroke(255, 0, 0);
    pg.fill(9, 255, 255);
    
    pg.shape(d);
    move();
    //translate(0, 150, 0);
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

    pg.popMatrix();
  }
  
  public boolean isColliding(Ball b){
    float distance = sqrt(pow(b.pos.x-pos.x, 2)+pow((b.pos.y-pos.y)-150,2)+pow(b.pos.z-pos.z, 2));
    
    if(distance <= size){
      
      collision = true;
    }
    
    return collision;    
  }
  
  public void move(){
    pos.y = ystart*sin(time/500.0) + ystart;
  }
  
}
