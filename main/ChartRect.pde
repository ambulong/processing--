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
  private color defaultColor = color(230);
  private color hoverColor = color(220);
  private color defaultAlpha = 2000;
  private color hoverAlpha = 2000;
  private color c;
  private color alpha;
  private boolean hasData, isSelected;
  private String[] countryList, ageRangeList;
  private int[] countryListNum, ageRangeListNum;
  private String[][] data;
  
  public ChartRect(String name){
    this.name = name;
    this.w = 30;
    this.h = 200;
    this.isOver = false;
    this.c = defaultColor;
    this.alpha = defaultAlpha;
    this.hasData = false;
    this.isSelected =false;
  }
  
  public void setSelected(){
    this.defaultColor = color(#BDBDBD);
    this.defaultAlpha = this.hoverAlpha;
    this.isSelected = true;
  }
  
  public void setLocation(float x, float y){
    this.x = x;
    this.y = y-1;
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
  
  public void setData(Table t){
    this.hasData = true;
    this.data = getDetail(t);
    int num = t.getRowCount();
    countryList = new String[num];
    ageRangeList = new String[6];
    countryListNum = new int[num];
    ageRangeListNum = new int[6];
    ageRangeList[0] = "0~25";
    ageRangeList[1] = "25~35";
    ageRangeList[2] = "35~45";
    ageRangeList[3] = "45~55";
    ageRangeList[4] = ">55";
    ageRangeList[5] = "NA";
    for(int i=0; i<ageRangeListNum.length; i++){
      ageRangeListNum[i]=0;
    }
    for(int i=0; i<countryListNum.length; i++){
      countryListNum[i]=0;
    }
    for (int i=0; i<num; i++) {
       addtoCountryList(this.data[i][2].trim());
       addtoAgeRangeList(this.data[i][3].trim());
    }
  }
  
  private void addtoCountryList(String str){
    for(int i=0; i<countryList.length; i++){
      if(countryList[i] == null){
        countryList[i] = str;
        countryListNum[i] += 1;
        break;
      }
      if(countryList[i].equals(str)){
        countryListNum[i] += 1;
        return;
      }
    }
  }
  
  private void addtoAgeRangeList(String str){
    if(str.equals("NA")){
      ageRangeListNum[5] += 1;
      return;
    }
    int age = Integer.parseInt(str);
    if(age>0 && age<=25){
      ageRangeListNum[0] += 1;
    }else if(age>25 && age<=35){
      ageRangeListNum[1] += 1;
    }else if(age>35 && age<=45){
      ageRangeListNum[2] += 1;
    }else if(age>45 && age<=55){
      ageRangeListNum[3] += 1;
    }else if(age>55){
      ageRangeListNum[4] += 1;
    }
  }
  
  public void drawItem(){
    int ageTotal = 0, countryTotal = 0;
    for(int i=0; i<ageRangeListNum.length; i++){
      ageTotal+=ageRangeListNum[i];
    }
    for(int i=0; i<countryListNum.length; i++){
      countryTotal+=countryListNum[i];
    }
  }
  
  public void drawItemInfo(){
    
  }
  
  public void draw(){
    if(this.hasData){
      drawItem();
      if(this.isSelected){
        drawItemInfo();
      }
    }
    
    fill(this.c, this.alpha);
    rect(this.x, this.y, this.w, this.h);
    if(mouseX > x && mouseX < (x+w) && mouseY > y && mouseY < (y+h)){
      this.isOver = true;
    }else{
      this.isOver = false;
    }
    if(this.isOver){
      this.c = hoverColor;
      this.alpha = hoverAlpha;
    }else{
      this.c = defaultColor;
      this.alpha = defaultAlpha;
    }
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
}
