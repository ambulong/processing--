/**
 * Chart. 
 * 
 * 图表
 */
import java.awt.Color;
import java.text.DecimalFormat;

class Chart {

  private String name;
  private int index;
  private float divW, divH;
  private String[][] data;
  private float[] rankProportion;
  private int num; //number of rows
  private float nwTotal; //net worth
  private int rankBarSelected;
  private Table[] crData;
  private ChartRect[] cr;
  private float[] crYearTotal;
  private float maxCrYearTotal = 0;
  private float maxHeight = 444;

  Chart(String name) {
    this.name = name;
    this.index = 0;
    this.divW = 0;
    this.divH = 0;
    this.num = 0;
    this.nwTotal = 0;
    this.rankBarSelected = 0;
    this.crYearTotal = null;
  }

  public void addData(Table t) {
    this.data = getDetail(t);
    this.num = t.getRowCount();
    this.rankProportion = new float[this.num];
    for (int i=0; i<this.num; i++) {
       this.nwTotal += Float.parseFloat(this.data[i][4].trim());
    }
    for (int i=0; i<this.num; i++) {
       rankProportion[i] = Float.parseFloat(this.data[i][4].trim())/this.nwTotal;
       //println("2013 "+i+" "+this.data[i][4].trim()+" "+rankProportion[i]);
    }
  }
  
  public void addCrData(Table[] t){
    this.cr = new ChartRect[t.length];
    this.crYearTotal = new float[t.length];
    
    
    
    
    for(int i=0; i<t.length; i++){
      String name = ""+(2007+i);
      cr[i] = new ChartRect(name);
      
      String[][] tDetail = getDetail(t[i]);
      int numTemp = t[i].getRowCount();
      float totalTemp = 0;
      for (int i2=0; i2<numTemp; i2++) {
       totalTemp += Float.parseFloat(tDetail[i2][4].trim());
       
       
       
      }
      this.crYearTotal[i] = totalTemp;
      //println(i+" "+totalTemp);
    }
    crData = t;
    for(int i=0; i<crYearTotal.length; i++){
      if(crYearTotal[i]>maxCrYearTotal){
        maxCrYearTotal = crYearTotal[i];
      }
    }
    
    
  }

  public void setIndex(int i) {
    this.index = i;
  }

  public void setDivSize(float w, float h) {
    this.divW = w;
    this.divH = h;
  }

  public String getName() {
    return this.name;
  }

  /**
   * 绘制图表
   * 
   * @param x float 基础坐标x
   * @param y float 基础坐标y
   */
  public void draw(float x, float y) {
    float lx = x+(this.index*this.divW);
    float ly = y;

    drawBaseLine(lx, ly);
    drawRankBar(lx, ly);
    

    for(int i=0; i<cr.length; i++){
      float margin = 0.6*width/(float)crYearTotal.length*(1.0/2.0)/2.0;
      float w = 0.6*width/(float)crYearTotal.length*(1.0/2.0);
      cr[i].setLocation(lx+0.025*width+(0.6*width/crYearTotal.length)*i+margin, ly+0.7*height-maxHeight*(crYearTotal[i]/maxCrYearTotal));
      cr[i].setSize(w,maxHeight*(crYearTotal[i]/maxCrYearTotal));
      cr[i].setData(this.crData[i]);
      if(name.equals((2007+i)+"")){
        cr[i].setSelected();
        //println(name+" "+i);
      }
      cr[i].draw();
    }
    
    drawPointLine(lx, ly);
    

    //text(this.name, lx+500, ly+500);
  }
  
  private void drawPointLine(float x, float y) {
    float w = 0.6*width/(float)crYearTotal.length*(1.0/2.0);
    float margin = 0.6*width/(float)crYearTotal.length*(1.0/2.0)/2.0;
    
    
    for(int i=0; i<crYearTotal.length; i++){
      drawPoint(x+0.025*width+(0.6*width/crYearTotal.length)*i+margin+w/2, y+0.7*height, 3);
      //println(margin+" "+w);
      stroke(70);
      textSize(13);
      text((2007+i)+"", x+0.025*width+(0.6*width/crYearTotal.length)*i+margin+w/2-15, y+0.7*height+20);
      
      DecimalFormat decimalFormat=new DecimalFormat(".00");
      drawPoint(x+0.025*width+(0.6*width/crYearTotal.length)*i+margin+w/2, y+0.7*height-maxHeight*(crYearTotal[i]/maxCrYearTotal), 3);
      text(decimalFormat.format(crYearTotal[i])+" $bil", x+0.025*width+(0.6*width/crYearTotal.length)*i+margin+w/2-33, y+0.7*height-maxHeight*(crYearTotal[i]/maxCrYearTotal)-13);
      
      if(i>0){
        stroke(#3F51B5);
        strokeWeight(1);
        strokeCap(ROUND);
        line(x+0.025*width+(0.6*width/crYearTotal.length)*(i-1)+margin+w/2, y+0.7*height-maxHeight*(crYearTotal[i-1]/maxCrYearTotal), x+0.025*width+(0.6*width/crYearTotal.length)*i+margin+w/2, y+0.7*height-maxHeight*(crYearTotal[i]/maxCrYearTotal));
      }
    }
  }
  
  private void drawBaseLine(float x, float y) {
    stroke(70);
    strokeWeight(1);
    strokeCap(ROUND);
    line(x+0.025*width, y+0.7*height, x+0.025*width+0.6*width, y+0.7*height);
    fill(70);
    //triangle(startPoint_x, startPoint_y-height-3, startPoint_x-3, startPoint_y-height+3, startPoint_x+3, startPoint_y-height+3);
    triangle(x+0.025*width+0.6*width+3, y+0.7*height, x+0.025*width+0.6*width-3, y+0.7*height+3, x+0.025*width+0.6*width-3, y+0.7*height-3);
  }
  
  private void drawRankBar(float x, float y) {
    int h = 574;
    int s = 1000;
    int b = 900;
    float sx = x; //start x
    float ellipseX = x + 0.025*width+0.63*width, ellipseY = y + 90;
    //noStroke();
    
    colorMode(HSB, 1000);
    //color cTemp = color(57, 100, 255);
    //color cTemp = color(#2196F3);
    //println(hue(cTemp)+", "+saturation(cTemp)+", "+brightness(cTemp));
    for(int i=0; i<rankProportion.length; i++){
      stroke(#FFFFFF);
      strokeWeight(1);
      color c = color(h, s, b);
      fill(c);
      updateRankBarSelected(sx, y + 0.75*height, width/(float)rankProportion.length, 2300.0*(rankProportion[i]), i);
      if(i == rankBarSelected){
        rect(sx, y + 0.75*height-3, width/(float)rankProportion.length, 2300.0*(rankProportion[i])+3);
      }else if(i == rankBarSelected+1 || i == rankBarSelected-1){
        rect(sx, y + 0.75*height-2, width/(float)rankProportion.length, 2300.0*(rankProportion[i])+2);
      }else if(i == rankBarSelected+2 || i == rankBarSelected-2){
        rect(sx, y + 0.75*height-1, width/(float)rankProportion.length, 2300.0*(rankProportion[i])+1);
      }else{
        rect(sx, y + 0.75*height, width/(float)rankProportion.length, 2300.0*(rankProportion[i]));
      }
      s = (int)(s-i*(s/rankProportion.length));
      sx = sx+(width/rankProportion.length);
      //if(name.equals("2013"))
      //  println("* "+name+" "+i+" "+rankProportion[i]+" "+2300.0*(rankProportion[i]));
      
      noStroke();
      //fill(#4CAF50);
      if(i == rankBarSelected-2){
        ellipse(ellipseX, ellipseY, 5, 5);
        if(rankBarSelected-2>=0){
          textSize(15);
          fill(#FF5722);
          text(data[rankBarSelected-2][1]+" # "+data[rankBarSelected-2][0],ellipseX+18,ellipseY-12);

          textSize(10);
          fill(#424242);
          String subtext = "From "+data[rankBarSelected-2][2]+", Net Worth "+data[rankBarSelected-2][4]+" $bil";
          if(!data[rankBarSelected][3].equals("NA")){
            subtext = subtext+", "+data[rankBarSelected-2][3]+" years old";
          }
          text(subtext,ellipseX+20,ellipseY+12);
        }
        ellipseY = ellipseY+80;
      }else if(i == rankBarSelected-1){
        ellipse(ellipseX, ellipseY, 7, 7);
        if(rankBarSelected-1>=0){
          textSize(17);
          fill(#FF5722);
          text(data[rankBarSelected-1][1]+" # "+data[rankBarSelected-1][0],ellipseX+18,ellipseY-12);

          textSize(12);
          fill(#424242);
          String subtext = "From "+data[rankBarSelected-1][2]+", Net Worth "+data[rankBarSelected-1][4]+" $bil";
          if(!data[rankBarSelected][3].equals("NA")){
            subtext = subtext+", "+data[rankBarSelected-1][3]+" years old";
          }
          text(subtext,ellipseX+20,ellipseY+12);
        }
        ellipseY = ellipseY+90;
      }else if(i == rankBarSelected){
        ellipse(ellipseX, ellipseY, 9, 9);
        if(rankBarSelected>=0){
          textSize(19);
          fill(#FF5722);
          text(data[rankBarSelected][1]+" # "+data[rankBarSelected][0],ellipseX+18,ellipseY-12);

          textSize(14);
          fill(#424242);
          String subtext = "From "+data[rankBarSelected][2]+", Net Worth "+data[rankBarSelected][4]+" $bil";
          if(!data[rankBarSelected][3].equals("NA")){
            subtext = subtext+", "+data[rankBarSelected][3]+" years old";
          }
          text(subtext,ellipseX+20,ellipseY+12);
        }
        ellipseY = ellipseY+90;
      }else if(i == rankBarSelected+1){
        ellipse(ellipseX, ellipseY, 7, 7);
        if(rankBarSelected+1<rankProportion.length){
          textSize(17);
          fill(#FF5722);
          text(data[rankBarSelected+1][1]+" # "+data[rankBarSelected+1][0],ellipseX+18,ellipseY-12);

          textSize(12);
          fill(#424242);
          String subtext = "From "+data[rankBarSelected+1][2]+", Net Worth "+data[rankBarSelected+1][4]+" $bil";
          if(!data[rankBarSelected][3].equals("NA")){
            subtext = subtext+", "+data[rankBarSelected+1][3]+" years old";
          }
          text(subtext,ellipseX+20,ellipseY+12);
        }
        ellipseY = ellipseY+80;
      }else if(i == rankBarSelected+2){
        ellipse(ellipseX, ellipseY, 5, 5);
        if(rankBarSelected+2<rankProportion.length){
          textSize(15);
          fill(#FF5722);
          text(data[rankBarSelected+2][1]+" # "+data[rankBarSelected+2][0],ellipseX+18,ellipseY-12);

          textSize(10);
          fill(#424242);
          String subtext = "From "+data[rankBarSelected+2][2]+", Net Worth "+data[rankBarSelected+2][4]+" $bil";
          if(!data[rankBarSelected][3].equals("NA")){
            subtext = subtext+", "+data[rankBarSelected+2][3]+" years old";
          }
          text(subtext,ellipseX+20,ellipseY+12);
        }
      }
    }
  }
  

  
  
  public void updateRankBarSelected(float x, float y, float w, float h, int i){
    if(mouseX > x && mouseX < (x+w) && mouseY > y/* && mouseY < (y+h)*/){
      rankBarSelected = i;
      //println(i);
    }
  }

  public String getSelected() {
    for(int i=0; i<cr.length; i++){
      if(cr[i].isHover()){
        return cr[i].getName();
      }
    }
    return "";
    
  }

  /**
   * Get detail info from table
   */
  public String[][] getDetail(Table table) {
    String[][] data;
    data = new String[table.getRowCount()][5];
    int iR = 0;
    for (TableRow row : table.rows ()) {
      String rank = row.getString("Rank");
      String name = row.getString("Name");
      String country = row.getString("Country");
      String age = row.getString("Age");
      String nw = row.getString("Net Worth ($bil)");
      String item[] = { 
        rank, name, country, age, nw
      };
      data[iR++] = item;
    }
    return data;
  }
  
  void drawPoint(float x, float y, float s) {
    color c = color(70); 
    fill(c);
    noStroke();
    ellipse(x, y, s, s);
  }
}

