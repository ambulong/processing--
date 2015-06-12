

float baseLocaion[] = {
  0, 0
};
final int yearNum = 8;
Table[] table = new Table[yearNum];
String selected = "";
float w, h;
boolean isMoving = false;
float targetX = 0;
float startX = 0;
int time = 1000; //ms

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

  size(displayWidth, displayHeight);
  background(#FFFFFF);
  for (int i=0; i<yearNum; i++) {
    table[i] = loadTable("./res/"+(2007+i)+".csv", "header");
    println("Year "+(2007+i)+" num: "+table[i].getRowCount());
  }

  c07.setIndex(0);
  c08.setIndex(1);
  c09.setIndex(2);
  c10.setIndex(3);
  c11.setIndex(4);
  c12.setIndex(5);
  c13.setIndex(6);
  c14.setIndex(7);

  c07.setDivSize(displayWidth, displayHeight);
  c08.setDivSize(displayWidth, displayHeight);
  c09.setDivSize(displayWidth, displayHeight);
  c10.setDivSize(displayWidth, displayHeight);
  c11.setDivSize(displayWidth, displayHeight);
  c12.setDivSize(displayWidth, displayHeight);
  c13.setDivSize(displayWidth, displayHeight);
  c14.setDivSize(displayWidth, displayHeight);
}

void draw() {
  clear();
  background(#FFFFFF);
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
    if(baseLocaion[0] > targetX){
      baseLocaion[0]=baseLocaion[0]-3;
    }else{
      baseLocaion[0]=baseLocaion[0]+3;
    }
  }
  /*if (selected.equals("2007")) {
    if(baseLocaion[0] == 0){
      isMoving = false;
    }
  } else if (selected.equals("2008")) {
    if(baseLocaion[0] == -w){
      isMoving = false;
    }
  } else if (selected.equals("2009")) {
    if(baseLocaion[0] == -2*w){
      isMoving = false;
    }
  } else if (selected.equals("2010")) {
    if(baseLocaion[0] == -3*w){
      isMoving = false;
    }
  } else if (selected.equals("2011")) {
    if(baseLocaion[0] == -4*w){
      isMoving = false;
    }
  } else if (selected.equals("2012")) {
    if(baseLocaion[0] == -5*w){
      isMoving = false;
    }
  } else if (selected.equals("2013")) {
    if(baseLocaion[0] == -6*w){
      isMoving = false;
    }
  } else if (selected.equals("2014")) {
    if(baseLocaion[0] == -7*w){
      isMoving = false;
    }
  }*/
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

/**
 * Get detail info from table
 */
String[][] getDetail(Table table) {
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

void keyPressed() {
  if (key == ESC) {
    exit();
  }
}

