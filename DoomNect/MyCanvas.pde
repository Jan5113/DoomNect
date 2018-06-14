public class MyCanvas extends Canvas{
  
  int y;
  int mx = 0;
  int my = 0;
  
  public void setup(){
    y = 200;
  }
  
  public void update(PApplet p){
    mx = p.mouseX;
    my = p.mouseY;
    
  }
  
  public void draw(PGraphics pg){    
    pg.fill(100);
    pg.rect(mx-20, y-20, 240, 30);
    pg.fill(255);
    pg.text("This text is drawn by MyCanvas", mx,y);
  }
  
}
