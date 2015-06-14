

float baseLocaion[] = {
  0, 0
};
final int yearNum = 8;
Table[] table = new Table[yearNum];
String selected = "";
int w, h;
boolean isMoving = false;
float targetX = 0;
float startX = 0;
int time = 100;
int currentT = 50;
color bgcolor = #FFFFFF;

Chart c07, c08, c09, c10, c11, c12, c13, c14;

void setup() {
  c07 = new Chart("2007");
  c08 = new Chart("2008");
  c09 = new Chart("2009");
  c10 = new Chart("2010");
  c11 = new Chart("2011");
  c12 = new Chart("2012");
  c13 = new Chart("2013");
  c14 = new Chart("2014");
  w = displayWidth;
  h = displayHeight;

  size(w, h);
  background(bgcolor);
  for (int i=0; i<yearNum; i++) {
    table[i] = loadTable("./res/"+(2007+i)+".csv", "header");
    //println("Year "+(2007+i)+" num: "+table[i].getRowCount());
  }

  c07.setIndex(0);
  c08.setIndex(1);
  c09.setIndex(2);
  c10.setIndex(3);
  c11.setIndex(4);
  c12.setIndex(5);
  c13.setIndex(6);
  c14.setIndex(7);

  c07.setDivSize(w, h);
  c08.setDivSize(w, h);
  c09.setDivSize(w, h);
  c10.setDivSize(w, h);
  c11.setDivSize(w, h);
  c12.setDivSize(w, h);
  c13.setDivSize(w, h);
  c14.setDivSize(w, h);
  
  c07.addData(table[0]);
  c08.addData(table[1]);
  c09.addData(table[2]);
  c10.addData(table[3]);
  c11.addData(table[4]);
  c12.addData(table[5]);
  c13.addData(table[6]);
  c14.addData(table[7]);
  
  c07.addCrData(table);
  c08.addCrData(table);
  c09.addCrData(table);
  c10.addCrData(table);
  c11.addCrData(table);
  c12.addCrData(table);
  c13.addCrData(table);
  c14.addCrData(table);
}

void draw() {
  clear();
  background(bgcolor);
  //baseLocaion[0] = baseLocaion[0]-1;
  c07.draw(baseLocaion[0], baseLocaion[1]);
  c08.draw(baseLocaion[0], baseLocaion[1]);
  c09.draw(baseLocaion[0], baseLocaion[1]);
  c10.draw(baseLocaion[0], baseLocaion[1]);
  c11.draw(baseLocaion[0], baseLocaion[1]);
  c12.draw(baseLocaion[0], baseLocaion[1]);
  c13.draw(baseLocaion[0], baseLocaion[1]);
  c14.draw(baseLocaion[0], baseLocaion[1]);
  
  if(baseLocaion[0] == targetX){
    isMoving = false;
  }else if(baseLocaion[0]>startX && baseLocaion[0]>targetX){
    isMoving = false;
    baseLocaion[0] = targetX;
  }else if(baseLocaion[0]<startX && baseLocaion[0]<targetX){
    isMoving = false;
    baseLocaion[0] = targetX;
  }else{
    baseLocaion[0]=getBaseLocationX();
  }
  if (currentT<=time) {
    colorMode(RGB, 255);
    drawLayer();
    currentT++;
  }
}

void mousePressed() {
  if (isMoving) {
    return;
  }
  if (!c07.getSelected().equals("")) {
    selected = c07.getSelected();
    println("Click div "+c07.getName()+ " item "+c07.getSelected());
  } else if (!c08.getSelected().equals("")) {
    selected = c08.getSelected();
    println("Click div "+c08.getName()+ " item "+c08.getSelected());
  } else if (!c09.getSelected().equals("")) {
    selected = c09.getSelected();
    println("Click div "+c09.getName()+ " item "+c09.getSelected());
  } else if (!c10.getSelected().equals("")) {
    selected = c10.getSelected();
    println("Click div "+c10.getName()+ " item "+c10.getSelected());
  } else if (!c11.getSelected().equals("")) {
    selected = c11.getSelected();
    println("Click div "+c11.getName()+ " item "+c11.getSelected());
  } else if (!c12.getSelected().equals("")) {
    selected = c12.getSelected();
    println("Click div "+c12.getName()+ " item "+c12.getSelected());
  } else if (!c13.getSelected().equals("")) {
    selected = c13.getSelected();
    println("Click div "+c13.getName()+ " item "+c13.getSelected());
  } else if (!c14.getSelected().equals("")) {
    selected = c14.getSelected();
    println("Click div "+c14.getName()+ " item "+c14.getSelected());
  } else {
    selected = "";
  }
  if (!selected.equals("")) {
    println("Selected: "+selected);
    isMoving = true;
    currentT = 0;
    startX = baseLocaion[0];
    if (selected.equals("2007")) {
      targetX = 0;
    } else if (selected.equals("2008")) {
      targetX = -w;
    } else if (selected.equals("2009")) {
      targetX = -2*w;
    } else if (selected.equals("2010")) {
      targetX = -3*w;
    } else if (selected.equals("2011")) {
      targetX = -4*w;
    } else if (selected.equals("2012")) {
      targetX = -5*w;
    } else if (selected.equals("2013")) {
      targetX = -6*w;
    } else if (selected.equals("2014")) {
      targetX = -7*w;
    } else {
      isMoving = false;
    }
  }
}


float getBaseLocationX(){
  if(currentT >= 0.5*time){
    return targetX;
  }else{
    return baseLocaion[0];
  }
}

/**
* 分块切换班透明层
*/
void drawLayer(){
  noStroke();
  color c = bgcolor;
  float alpha = 0;
  if(currentT <= 0.5*time){
    alpha = 255*(currentT/(0.5*time));
  }else{
    alpha = 255*(1-(currentT-0.5*time)/(0.5*time));
  }
  //println(alpha);
  fill(c, alpha);
  rect(0, 0, w, h);
}

void keyPressed() {
  if (key == ESC) {
    exit();
  }
}

