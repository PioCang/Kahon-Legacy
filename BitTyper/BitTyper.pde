import java.util.*;

 Typer t;
void setup(){
    size(800,400);
    t = new Typer();
     background(0);
}

void draw(){
 t.draw(); 
 println(Arrays.toString(letter));
}

void mousePressed(){
  int x = mouseX/pSize;
  int y = mouseY/pSize;
  currPattern = currPattern ^ (1<<(y*5 + x));
  letter[currChar] = currPattern;
}

void mouseDragged(){
  int x = mouseX/pSize;
  int y = mouseY/pSize;
  currPattern = currPattern | (1<<(y*5 + x));
  letter[currChar] = currPattern;
}

void keyPressed(){
  if(key == '\n'){
    t.nextLine();
  }
  else
  if(key >= 0 && key < 256){
      t.nextChar();
     currChar = Character.toUpperCase(key);
     currPattern = letter[currChar];
  }
}
