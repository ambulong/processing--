/**
 * ChartRect. 
 * 
 * 图表中长方形条内的数据快
 */
 
class ChartRectItem{
  private color c;
  private float x, y, w, h; 
   
  public void setLocation(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  public void setSize(float w, float h){
    this.w = w;
    this.h = h;
  }
  
  public void setColor(color c){
    this.c = c;
  }
  
  public void draw(){
    fill(this.c);
    rect(this.x, this.y, this.w, this.h);
  }
 }
