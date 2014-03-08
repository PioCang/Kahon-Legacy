Client[] client = new Client[6];
String display[] = {"","Kahon Guards","Bruno","Dustin","Tresia","Tutu", "Waiting for more players..."};
String name[] = {null,null,"Pepe","Berba",null,null,null};

int h[] = {0,299,358, 60,112,229,0}; 
int s[] = {0,0,68,100,69,69,0};
int b[] = {100,14,69,90,71,71,50};
int _width,_height;

class Button{
   int x,y;
   int index;
   
   Button(int x, int y, int index){
    this.x = x;
    this.y = y;
    this.index = index; 
   }
   
   void display(){
       colorMode(HSB,360,100,100,100);
       String toDisplay = name[index];
      if(x <= mouseX && mouseX <= x + _width && y <= mouseY && mouseY <= y + _height)
      {
        if(toDisplay != null && name[0] == null)
          toDisplay = "Disconnect " + toDisplay + " ?";
        else if(toDisplay == null && name[0] != null && index!=6) 
          toDisplay = "Put " + name[0] + " here?";
        else if(toDisplay != null && name[0] != null && index == 0)
          toDisplay = "Disconnect " + toDisplay + " ?";
        fill(h[index],s[index]-20,b[index]+20);
      }
      else fill(h[index],s[index],b[index]);
      
     if(toDisplay == null)
         toDisplay = display[index];
     
     if(index == 0)
      {
        toDisplay = "Port: " + port + "\n" + toDisplay;
        setFontColor(0,0,0);
      } 
     else setFontColor(0,0,100);
     pushMatrix();
     translate(x,y);
     rectMode(CORNER);
     noStroke();
     rect(0,0,_width,_height);
     bitText(toDisplay,20,20);
     popMatrix(); 
   }
   
   boolean mousePressed(){
      return x <= mouseX && mouseX <= x + _width && y <= mouseY && mouseY <= y + _height;
   }
}

