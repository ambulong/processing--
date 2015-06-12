/**
 * Chart. 
 * 
 * 图表
 */

class Chart {
  
  private String name;
  private int index;
  private float divW, divH;
  public ChartRect cr07, cr08, cr09, cr10, cr11, cr12, cr13, cr14;
  
  Chart(String name){
    this.name = name;
    this.index = 0;
    this.divW = 0;
    this.divH = 0;
    
    cr07 = new ChartRect("2007");
    cr08 = new ChartRect("2008");
    cr09 = new ChartRect("2009");
    cr10 = new ChartRect("2010");
    cr11 = new ChartRect("2011");
    cr12 = new ChartRect("2012");
    cr13 = new ChartRect("2013");
    cr14 = new ChartRect("2014");
  }
  
  public void addItem(){
    
  }
  
  public void setIndex(int i){
    this.index = i;
  }
  
  public void setDivSize(float w, float h){
    this.divW = w;
    this.divH = h;
  }
  
  public String getName(){
    return this.name;
  }

  /**
  * 绘制图表
  * 
  * @param x float 基础坐标x
  * @param y float 基础坐标y
  */
  public void draw(float x, float y){
    float lx = x+(this.index*this.divW);
    float ly = y;
    cr07.setLocation(lx+10, ly+10);
    cr08.setLocation(lx+60, ly+10);
    cr09.setLocation(lx+120, ly+10);
    cr10.setLocation(lx+180, ly+10);
    cr11.setLocation(lx+240, ly+10);
    cr12.setLocation(lx+300, ly+10);
    cr13.setLocation(lx+360, ly+10);
    cr14.setLocation(lx+420, ly+10);
    
    cr07.draw();
    cr08.draw();
    cr09.draw();
    cr10.draw();
    cr11.draw();
    cr12.draw();
    cr13.draw();
    cr14.draw();
    
    text(this.name, lx+500, ly+500); 
  }
  
  public String getSelected(){
    if(cr07.isHover()) {
      return cr07.getName();
    }else if(cr08.isHover()) {
      return cr08.getName();
    }else if(cr09.isHover()) {
      return cr09.getName();
    }else if(cr10.isHover()) {
      return cr10.getName();
    }else if(cr11.isHover()) {
      return cr11.getName();
    }else if(cr12.isHover()) {
      return cr12.getName();
    }else if(cr13.isHover()) {
      return cr13.getName();
    }else if(cr14.isHover()) {
      return cr14.getName();
    }else{
      return "";
    }
  }
}
