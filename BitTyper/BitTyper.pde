import java.util.*;

Typer t;
String s = "  Hello World! This is a sample text. Simply write here to produce create the text thingie...";
void setup(){
    size(padding+800,padding+400);
    t = new Typer();
     background(0);
}

void draw(){
   t.draw(s);
}
//
//void mousePressed(){
//  int x = mouseX/pSize;
//  int y = mouseY/pSize;
//  currPattern = currPattern ^ (1<<(y*5 + x));
//  letter[currChar] = currPattern;
//}
//
//void mouseDragged(){
//  int x = mouseX/pSize;
//  int y = mouseY/pSize;
//  currPattern = currPattern | (1<<(y*5 + x));
//  letter[currChar] = currPattern;
//}

void keyPressed(){
  if(keyCode == 8){
     if(s.length() >= 1) 
        s = s.substring(0,s.length()-1); 
  }else if(key >= 0 && key < 256){
      s = s + key;
  }
}
