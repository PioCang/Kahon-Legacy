import ddf.minim.*;

Client[] client = new Client[7];
String display[] = {
  "", "Kahon Guards", "Bruno", "Dostin", "Tresia", "Tutu", "Waiting for more players..."
};
String name[] = {
  null, null, null, null, null, null, null
};

int h[] = {
  0, 299, 358, 60, 112, 229, 0
}; 
int s[] = {
  0, 0, 68, 100, 69, 69, 0
};
int b[] = {
  100, 14, 69, 90, 71, 71, 50
};

int _width, _height;

class Button {

  AudioPlayer buttonHoverSound, buttonClickSound;
  boolean hasBeenPlayed = false, isDarkFill = false;

  int x, y, frameToStopBlinking;
  int index;
  

  Button(int x, int y, int index) {
    this.x = x;
    this.y = y;
    this.index = index;
    this.buttonHoverSound = KahonLegacyServer.minim.loadFile("buttonHover.mp3");
    this.buttonClickSound = KahonLegacyServer.minim.loadFile("buttonClick.mp3");
  }

  void display() {
    
  
    
    colorMode(HSB, 360, 100, 100, 100);
    String toDisplay = name[index];
    if (x <= mouseX && mouseX <= x + _width && y <= mouseY && mouseY <= y + _height)
    {
      if (toDisplay != null && name[0] == null)
        toDisplay = "Disconnect " + toDisplay + "?";
      else if (toDisplay == null && name[0] != null && index!=6) 
        toDisplay = "Put " + name[0] + " here?";
      else if (toDisplay != null && name[0] != null && index == 0)
        toDisplay = "Disconnect " + toDisplay + "?";
      fill(h[index], s[index]-20, b[index]+20);
      
      
      if (!this.hasBeenPlayed)
      {
          this.hasBeenPlayed = true;
          this.buttonHoverSound.rewind();
          this.buttonHoverSound.play();
      } 
    }
    
    else{
      this.hasBeenPlayed = false;

      fill(h[index], s[index], b[index]);
      if(index==0 && toDisplay!=null)
        toDisplay = "Connecting: " + toDisplay;  
    }

    if (toDisplay == null)
      toDisplay = display[index];

    if (index == 0)
    {
      toDisplay = "Port: " + port + "\n" + toDisplay;
      setFontColor(0, 0, 0);
    } 
    else setFontColor(0, 0, 100);

    if (status != WAITING_FOR_PLAYERS && index!=0)
      toDisplay = name[index];
    if (index == 6 && connected == 5)
      toDisplay = "Start Game";

    if (frameCount < frameToStopBlinking && (frameCount - frameToStopBlinking) % 2 == 0)
    {
         if (isDarkFill)
         {
             fill(h[index], s[index]+20, b[index]-20);
             isDarkFill = false;
         }
         else if (!isDarkFill)
         {
              fill(h[index], s[index]-20, b[index]+20);
              isDarkFill = true;           
         }
    }


    pushMatrix();
    translate(x, y);
    rectMode(CORNER);
    noStroke();

    rect(0, 0, _width, _height);
    
    bitText(toDisplay, 20, 20);
 
    popMatrix();
    
  }

  boolean mousePressed() {   
   
    if (x <= mouseX && mouseX <= x + _width && y <= mouseY && mouseY <= y + _height)
    {
        this.buttonClickSound.rewind();
        this.buttonClickSound.play();
        
        frameToStopBlinking = frameCount + 24;    
        isDarkFill = false;    
    }
   
    
    return x <= mouseX && mouseX <= x + _width && y <= mouseY && mouseY <= y + _height;
  }
}

