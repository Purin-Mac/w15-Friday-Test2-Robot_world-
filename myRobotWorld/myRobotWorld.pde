World myRobotWorld;  //Set myRobotWorld as object of World
boolean load = true;
int[][] data = new int[24][2];
char[] Key = new char[3];

void setup() {
  size(720, 720);
  readFile();
  if(load){myRobotWorld = new World(data[0][0],data[0][1]);}
  else{myRobotWorld = new World(12,12);}
}

void readFile(){
  BufferedReader reader = createReader("SaveWorld.txt");
  String line = null;
  int i = 0;
  try {
    while ((line = reader.readLine()) != null) {
      if (i < 24) {
        String[] pieces = split(line,",");
        data[i][0] = int(pieces[0]);
        data[i][1] = int(pieces[1]);
      } else {
        String[] pieces = split(line,"=");
        Key[i-24] = pieces[1].charAt(0);
      }
      i++;
    }
    reader.close();
  }
  catch (NullPointerException e) {
    e.printStackTrace();
    load = false;
  }
  catch (IOException e) {
    e.printStackTrace();
    load = false;
  }
  if(i != 27){
    load = false;
  }
}

void draw() {
  background(40);  //Draw black background
  noStroke();
  myRobotWorld.drawLine();      //Draw World line
  myRobotWorld.drawWorld();     //Draw all of World
}

/////////////////////////////////////////////////////
//
// Programmer: Purin Petch-in
//
// Description: call updateWorld method when key is release
// 
/////////////////////////////////////////////////////
void keyReleased(){
  myRobotWorld.updateWorld();
}

class Robot {
  int row, column, size, direction;     //Set row, column, size as attribute
  float heightPerBlock, widthPerBlock;  //Set height,wieght per block and degree as attribute

  Robot(int row, int column, int size, float widthPerBlock, float heightPerBlock) {
    this.row = row;
    this.column = column;
    this.size = size;
    this.widthPerBlock = widthPerBlock;
    this.heightPerBlock = heightPerBlock;
    this.direction = 1;
  }
  
  Robot(int row, int column, int size, float widthPerBlock, float heightPerBlock, int direction) {
    this.row = row;
    this.column = column;
    this.size = size;
    this.widthPerBlock = widthPerBlock;
    this.heightPerBlock = heightPerBlock;
    this.direction = direction;
  }

  /////////////////////////////////////////////////////
  //
  // Programmer: Purin Petch-in
  //
  // Description: move robot depend on where it point
  // 
  /////////////////////////////////////////////////////
  void move() {    //move method to move depend on how it look
     if (direction == 1) {
      //print(row);
      row += 1;
    } else if (direction == 3) {
      //print(row);
      row -= 1;
    } else if (direction == 2) {
      //print(column);
      column += 1;
    } else if (direction == 4) {
      //print(column);
      column -= 1;
    }
  }

  /////////////////////////////////////////////////////
  //
  // Programmer: Purin Petch-in
  //
  // Description: make robot turn left (change direction)
  // 
  /////////////////////////////////////////////////////
  void turnLeft() {
    if (direction == 1){
      direction = 4;
    } else {
      direction -= 1;
    }
  }
  
  /////////////////////////////////////////////////////
  //
  // Programmer: Purin Petch-in
  //
  // Description: make robot turn right (change direction)
  // 
  /////////////////////////////////////////////////////
  void turnRight() {
    if (direction == 4) {
      direction = 1;
    } else {
      direction += 1;
    }
  }

  /////////////////////////////////////////////////////
  //
  // Programmer: Purin Petch-in
  //
  // Description: draw robot depend on direction, direction = 1 is when robot point to east, direction = 2 when robot point to south 
  //              direction = 3 is when robot point to west and direction = 4 is when robot point to north
  // 
  /////////////////////////////////////////////////////
  void drawRobot() {   //draw robot
    stroke(155, 100, 255);
    strokeWeight(2.5);
    if (direction == 1) {
      line(widthPerBlock*row, heightPerBlock*column, widthPerBlock*row + widthPerBlock, heightPerBlock*column + heightPerBlock/2);
      line(widthPerBlock*row, heightPerBlock*column + heightPerBlock, widthPerBlock*row + widthPerBlock, heightPerBlock*column + heightPerBlock/2);
      line(widthPerBlock*row, heightPerBlock*column, widthPerBlock*row, heightPerBlock*column + heightPerBlock);
    } else if (direction == 2) {
      line(widthPerBlock*row, heightPerBlock*column, widthPerBlock*row + widthPerBlock/2, heightPerBlock*column + heightPerBlock);
      line(widthPerBlock*row + widthPerBlock, heightPerBlock*column, widthPerBlock*row + widthPerBlock/2, heightPerBlock*column + heightPerBlock);
      line(widthPerBlock*row, heightPerBlock*column, widthPerBlock*row + widthPerBlock, heightPerBlock*column);
    } else if (direction == 3) {
      line(widthPerBlock*row + widthPerBlock, heightPerBlock*column, widthPerBlock*row, heightPerBlock*column + heightPerBlock/2);
      line(widthPerBlock*row + widthPerBlock, heightPerBlock*column + heightPerBlock, widthPerBlock*row, heightPerBlock*column + heightPerBlock/2);
      line(widthPerBlock*row + widthPerBlock, heightPerBlock*column, widthPerBlock*row + widthPerBlock, heightPerBlock*column + heightPerBlock);
    } else if (direction == 4) {
      line(widthPerBlock*row, heightPerBlock*column + heightPerBlock, widthPerBlock*row + widthPerBlock/2, heightPerBlock*column);
      line(widthPerBlock*row + widthPerBlock, heightPerBlock*column + heightPerBlock, widthPerBlock*row + widthPerBlock/2, heightPerBlock*column);
      line(widthPerBlock*row, heightPerBlock*column + heightPerBlock, widthPerBlock*row + widthPerBlock, heightPerBlock*column + heightPerBlock);
    }
  }

  int getRow() {
    return row;
  }

  int getColumn() {
    return column;
  }
  
  float getDirection() {
    return direction;
  }
  
  void setRow(int r){
    row = r;
  }
  
  void setColumn(int c){
    column = c;
  }
  
  void setDirection(float d){
    direction = (int) d;
  }
}

class Wall {
  int row, column, size;      //Set row, column, size as attribute
  float widthPerBlock, heightPerBlock;  //Set width,height per block as attribute


  Wall(int row, int column, int size, float widthPerBlock, float heightPerBlock) {
    this.row = row;
    this.column = column;
    this.size = size;
    this.widthPerBlock = widthPerBlock;
    this.heightPerBlock = heightPerBlock;
  }

  void drawWall() {
    fill(100, 100, 80);
    rect(widthPerBlock*row+2, heightPerBlock*column+2, widthPerBlock-2, heightPerBlock-2);    //fill the block
  }

  int getRow() {
    return row;
  }

  int getColumn() {
    return column;
  }
}

class Objective {
  int row, column, size; //Set row, column, size as attribute
  float widthPerBlock, heightPerBlock;  //Set width,height per block as attribute

  Objective(int row, int column, int size, float widthPerBlock, float heightPerBlock) {
    this.row = row;
    this.column = column;
    this.size = size;
    this.widthPerBlock = widthPerBlock;
    this.heightPerBlock = heightPerBlock;
  }


  void drawObjective() {
    fill(255, 100, 80); //fill red
    ellipse(widthPerBlock*row + widthPerBlock/2, heightPerBlock*column + heightPerBlock/2, size, size); //draw circle object
  }

  int getRow() {
    return row;
  }

  int getColumn() {
    return column;
  }
}

class World {
  int row, column; //set row, column as attribute
  float widthPerBlock;  //set height,width as attribute
  float heightPerBlock;
  Robot[] myRobot;        //set myRobot that is Robot object as attribute
  Objective myObjective;  //set myObject that is Objective object as attribute
  Wall[] myWall;         //set myWall that is Wall[] object as attribute
  InputProcessor Input;
  int lengthRobot = 4;

  World(int row, int column) {
    this.row = row;
    this.column = column;
    heightPerBlock = height/column; //calculate height,width per block
    widthPerBlock = width/row;

    if(load){
      //myRobot = new Robot(data[1][0],data[1][1], 40, widthPerBlock, heightPerBlock,data[23][0]);    //instance myRobot at 1,2 size =40 ,and send width,heigh per block
      myObjective =  new Objective(data[2][0],data[2][0], 40, widthPerBlock, heightPerBlock); //instance myObject at 11,11 size =40 ,and send width,heigh per block
      myWall = new Wall[20];  //Initialization Wall array
      for (int i=3; i<23; i++) {
        myWall[i-3] = new Wall(data[i][0],data[i][1] , 40, widthPerBlock, heightPerBlock); //random wall position
      }
      Input = new InputProcessor(Key[0], Key[1], Key[2]);
      load = false;
    }
    else{
      //myRobot = new Robot(1, 2, 40, widthPerBlock, heightPerBlock,1);    //instance myRobot at 1,2 size =40 ,and send width,heigh per block
      for (int i = 0; i < lengthRobot; i++){
        myRobot[i] = new Robot(6-i, 2, 40, widthPerBlock, heightPerBlock, 1);
      }
      myObjective =  new Objective(11, 11, 40, widthPerBlock, heightPerBlock); //instance myObject at 11,11 size =40 ,and send width,heigh per block
      myWall = new Wall[20];  //Initialization Wall array
      for (int i=0; i<20; i++) {
        int x = (int)random(0, 12);
        int y = (int)random(0, 12);
        for (int j = 0; j < lengthRobot; i++){
          if (x == myRobot[i].getRow() && y == myRobot[i].getColumn() && x == myObjective.getRow() && y == myObjective.getColumn() ) {
            break;
          } else if (j == lengthRobot -1){
            myWall[i] = new Wall(x, y, 40, widthPerBlock, heightPerBlock); //random wall position
          }
        }
        i--;
      }
      if (Key[0] == 0) {
        Input = new InputProcessor('w', 'a', 'd');
      } else {
        Input = new InputProcessor(Key[0], Key[1], Key[2]);
      }
    }

  }

  void drawLine() { //draw line
    fill(255);
    for (int i = 0; i<=row; i++) {
      rect(widthPerBlock*i, 0, 2, height);  //draw horizontal line
    }
    for (int j = 0; j<=column; j++) {
      rect(0, heightPerBlock*j, width, 2);  //draw vertical line
    }
  }

  void drawWorld() {
    for (Wall eachWall : myWall) {
      eachWall.drawWall();        //draw each wall
    }
    myObjective.drawObjective();    //draw objective
    for (Robot eachRobot : myRobot){
      eachRobot.drawRobot();     //draw robot
    }    
  }

  /////////////////////////////////////////////////////
  //
  // Programmer: Purin Petch-in
  //
  // Description: call checkMove from keyprocessor to check input and if robot is on target restart and save game
  // 
  /////////////////////////////////////////////////////
  void updateWorld(){
    Input.checkMove(key, row, column, myRobot, myWall, 20, lengthRobot);
    if(targetCheck()){restartGame();}
    saveGame();
  }
  
  void saveGame(){
    PrintWriter output;
    output = createWriter("SaveWorld.txt"); 
    output.println(this.row+","+this.column);
    for (int i = 0; i < lengthRobot; i++){
      output.println(myRobot[i].row+","+myRobot[i].column);
    }
    output.println(myObjective.row+","+myObjective.column);
    for (Wall eachWall : myWall) {
      output.println(eachWall.row+","+eachWall.column);      
    }
    for (int i = 0; i < lengthRobot; i++){
      output.println(myRobot[i].getDirection()+","+0);
    }
    output.println("Move="+Input.getMoveKey());
    output.println("Turn Left="+Input.getLeftKey());
    output.println("Turn Right="+Input.getRightKey());
    output.flush();
    output.close();
  }
  
  boolean targetCheck(){
    if (myRobot[0].row == myObjective.row && myRobot[0].column == myObjective.column){
      return true;
    }
    return false;
  }

  void restartGame(){
    myRobotWorld = new World(12,12);
  }
}

class InputProcessor {
  char moveKey, turnLeftKey, turnRightKey;
  InputProcessor(char move, char turnLeft, char turnRight){
    this.moveKey = move;
    this.turnLeftKey = turnLeft;
    this.turnRightKey = turnRight;
  }
  
  /////////////////////////////////////////////////////
  //
  // Programmer: Purin Petch-in
  //
  // Description: check input if it the move or turn key it will make robot move (if infront of robot is wall or edge it can't move forward)
  // 
  /////////////////////////////////////////////////////
  void checkMove(char inputKey, int worldRow, int worldColumn, Robot[] robot, Wall[] wall, int maxWall, int lengthRobotSnake){
    if (inputKey == moveKey) {
      for (int i = 0; i<maxWall; i++) {
        if (robot[0].getDirection() == 1 && robot[0].getRow()+1 == wall[i].getRow() && robot[0].getColumn() == wall[i].getColumn()) {
          break;
        } else if (robot[0].getDirection() == 3 && robot[0].getRow()-1 == wall[i].getRow() && robot[0].getColumn() == wall[i].getColumn()) {
          break;
        } else if (robot[0].getDirection() == 2 && robot[0].getRow() == wall[i].getRow() && robot[0].getColumn()+1 == wall[i].getColumn()) {
          break;
        } else if (robot[0].getDirection() == 4 && robot[0].getRow() == wall[i].getRow() && robot[0].getColumn()-1 == wall[i].getColumn()) {
          break;
        } else if (robot[0].getDirection() == 1 && robot[0].getRow()+1 == worldRow) {
          break;
        } else if (robot[0].getDirection() == 3 && robot[0].getRow()-1 < 0) {
          break;
        } else if (robot[0].getDirection() == 2 && robot[0].getColumn()+1 == worldColumn) {
          break;
        } else if (robot[0].getDirection() == 4 && robot[0].getColumn()-1 < 0) {
          break;
        } else if (i == 19) {
          for(int j = 0; j < lengthRobotSnake - 1; j++){
            robot[4-j].setDirection(robot[4-j-1].getDirection());
          }
          for(int k = 0; k < lengthRobotSnake - 1; k++){
            robot[k].move();
          }
        }
      }
    } else if (inputKey == turnLeftKey) {
      robot[0].turnLeft();
    } else if (inputKey == turnRightKey) {
      robot[0].turnRight();
    }
  }
  
  char getMoveKey(){
    return moveKey;
  }
  
  char getLeftKey(){
    return turnLeftKey;
  }
  
  char getRightKey(){
    return turnRightKey;
  }
}
