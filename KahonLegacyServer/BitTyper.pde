import java.util.StringTokenizer;

/*
BitTyper by Pepe Berba
https://github.com/pepeberba/Kahon-Legacy

Used to display bit font. 

Things to add:
Adding alignment feature
Letter outlines
Dynamic Resizing of Font
Dynamic sized characters (current each character has the same width)
*/

//Font Color
int _fontH = 255; 
int _fontS = 0;
int _fontB = 100;
int _fontAlpha = 100;
//Font size
float _fontSize = 3;

//Spacing
float _fontLine = 1.3;
float _fontSpacing = 1.3;

//Font
int _fontLetter[] = {
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4198532, 330, 11512810, 33193151, 17895697, 24821070, 196, 6325286, 13124108, 4096, 145536, 6422528, 14336, 4194304, 1118480, 33080895, 4329604, 32570911, 33059359, 17333809, 33061951, 33094719, 17318431, 33095231, 17333823, 131200, 6422656, 4260932, 459200, 4473092, 4223551, 32568895, 18415167, 33094823, 32539711, 16303663, 32545855, 1088575, 33092671, 18415153, 66195615, 33079824, 18414889, 32539681, 1125701311, 51955263, 33080895, 1113663, 33343039, 51969191, 33061951, 4329631, 972604977, 4532785, 33216049, 28774875, 4357681, 32575775, 7373863, 151261249, 29901340, 324, 32505856, 194, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6360134, 4329604, 12869900, 939232, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6422528, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};

void setFontColor(int h, int s, int b, int alpha) {
  _fontH = h;
  _fontS = s;
  _fontB = b;
  _fontAlpha = alpha;
}

void setFontColor(int h, int s, int b) {
  setFontColor(h, s, b, 100);
}
void setBitFontSize(int fontSize) {
  _fontSize = fontSize;
}

void setBitFontLine(float line) {
  _fontLine = line;
}

void setBitFontSpacing(float space) {
  _fontSpacing = space;
}

void bitChar(char c, int x, int y) {
  colorMode(HSB, 360, 100, 100, 100);
  stroke(_fontH, _fontS, _fontB, _fontAlpha);
  fill(_fontH, _fontS, _fontB, _fontAlpha);
  int pattern = _fontLetter[c];
  pushMatrix();
  translate(x, y);
  for (int i = 0; i < 5; i++)
    for (int j = 0; j < 5; j++) 
      if ((pattern&(1<<(j*5 + i)))!= 0)
        rect(i*_fontSize, j*_fontSize, _fontSize, _fontSize);
  popMatrix();
}


void bitText(String text, int x, int y, int textWidth, int textHeight, int padding) {
  if(text== null) return;
  pushMatrix();
  translate(x+padding, y+padding);
  textWidth-=padding*2;
  textHeight-=padding*2;
  int currX = 0;
  int currY = 0;
  StringTokenizer st = new StringTokenizer(text.toUpperCase(), " \t\n", true);
  while (st.hasMoreTokens ()) {
    String toPrint = st.nextToken();
    if (toPrint.equals("\n")) {
      currY += 5*_fontSize*_fontLine;
     currX = 0; 
      continue;
    }
    else if (toPrint.equals(" ") || toPrint.equals("\t")) {
      currX += 5*_fontSize*_fontSpacing;
      if (toPrint.equals("\t"))
        currX += 5*_fontSize*_fontSpacing;
      continue;
    }
    else if (currX!=0 && currX + bitTextWidth(toPrint) > textWidth) {
      currX = 0;
      currY += 5*_fontSize*_fontLine;
    }
    if (currY >= textHeight)
      break;
    for (int i = 0; i < toPrint.length(); i++)
    {
      bitChar(toPrint.charAt(i), currX, currY);
      currX += 5*_fontSize*_fontSpacing;
    }
  }
  popMatrix();
}

void bitText(String text, int x, int y, int textWidth, int textHeight) {
  bitText(text, x, y, textWidth, textHeight, 0);
}

void bitText(String text, int x, int y) {
  bitText(text, x, y, width-x, height-y);
}

int bitTextWidth(String s) {
  return (int)(s.length()*5*_fontSize*_fontSpacing);
}

