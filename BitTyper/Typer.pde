class Typer {
  int currX = 0;
  int currY = 0;
  
  void draw(int pattern) {
    noStroke();
    for (int i = 0; i < 5; i++)
      for (int j = 0; j < 5; j++) {
          if((pattern&(1<<(j*5 + i))) == 0) fill(0);
          else fill(255);
          rect(padding+currX*6*pSize + i*pSize, padding + currY*6*pSize + j*pSize,pSize,pSize);
      }
  }
  
  void draw(String s){
    s = s.toUpperCase();
     for(int i = 0; i < s.length(); i++){
       draw(letter[s.charAt(i)]);
       nextChar();
       if(s.charAt(i)=='\t')
         nextChar();
     } 
     reset();
  }
  
  void reset(){
     currX = 0;
     currY = 0; 
  }
  
  void nextChar(){
     currX++; 
     if(padding*2/pSize + (currX+1)*6 >= width/pSize)
       nextLine();  
  }
  void nextLine(){
     currX = 0;
    currY++; 
  }
}
class Paragraph {
}

