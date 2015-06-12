/**
 * ChartRect. 
 * 
 * 图表中的长方形条
 */

class ChartRect{
  private String name;
  private float w, h;
  private float x, y;
  private boolean isOver;
  private color defaultColor = color(44);
  private color hoverColor = color(55);
  private color c;
  
  public ChartRect(String name){
    this.name = name;
    this.w = 30;
    this.h = 200;
    this.isOver = false;
    this.c = defaultColor;
  }
  
  public void setLocation(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  public void setSize(float w, float h){
    this.w = w;
    this.h = h;
  }
  
  public String getName(){
    return this.name;
  }
  
  public boolean isHover(){
    return this.isOver;
  }
  
  public void draw(){
    fill(this.c);
    rect(this.x, this.y, this.w, this.h);
    if(mouseX > x && mouseX < (x+w) && mouseY > y && mouseY < (y+h)){
      this.isOver = true;
    }else{
      this.isOver = false;
    }
    if(this.isOver){
      this.c = hoverColor;
    }else{
      this.c = defaultColor;
    }
  }
}
