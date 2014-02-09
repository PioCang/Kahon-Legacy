int currChar = '0';
int currPattern = 0;
class Typer {
  int currX = -1;
  int currY = 0;
  void draw() {
    int pattern = currPattern;
    noStroke();
    for (int i = 0; i < 5; i++)
      for (int j = 0; j < 5; j++) {
          if((pattern&(1<<(j*5 + i))) == 0) fill(0);
          else fill(255);
          rect(currX*6*pSize + i*pSize,currY*6*pSize + j*pSize,pSize,pSize);
      }
  }
  
  void nextChar(){
     currX++; 
     if((currX+1)*6 >= width/pSize)
     {
       nextLine();
        currX++;  
     }
  }
  void nextLine(){
     currX = -1;
    currY++; 
  }
}
class Paragraph {
}

