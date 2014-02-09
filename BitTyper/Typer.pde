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
     StringTokenizer st = new StringTokenizer(s.toUpperCase()," \t\n",true);
    while(st.hasMoreTokens()){
       String toPrint = st.nextToken();
        if(toPrint.equals("\n"))
         nextLine();
        else{
            check(toPrint.length());
            for(int i = 0; i < toPrint.length(); i++)
            {
              draw(letter[toPrint.charAt(i)]);
              nextChar();  
            }
         } 
    }
     reset();
  }
  
  void reset(){
     currX = 0;
     currY = 0; 
  }
  
  void check(int next){
      if(padding*2/pSize + (currX+next)*6 >= width/pSize)
         nextLine();  
  }
  
  void nextChar(){
     currX++; 
  }
  void nextLine(){
     currX = 0;
    currY++; 
  }
}
class Paragraph {
}

