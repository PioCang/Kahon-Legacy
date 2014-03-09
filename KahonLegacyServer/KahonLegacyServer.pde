import processing.net.*;
import java.util.*;

int pSize = 20;
String status = "";
int connected = 0;
Button button[];
Server server = null;
int port = 5204;
Queue<Client> playerQueue;
boolean startGame = false;

void setup() {
  size(22*pSize, 30*pSize);
  button = new Button[7];
  _width = width-pSize*2;
  _height = 4*pSize;

  //Get port number from config.txt
  String arr[] = loadStrings("config.txt");
  port = parseInt(arr[0].split(" ")[1]);
  server = new Server(this, port);

  playerQueue = new LinkedList<Client>();

  for (int i = 0; i < 7; i++)
    button[i] = new Button(pSize, pSize+_height*i, i);
}

void draw() {
  if (!startGame && client[0] == null && playerQueue.size() != 0) {
    client[0] = playerQueue.poll();
    while (name[0]==null)
      name[0] = client[0].readStringUntil('*');
    name[0] = name[0].replaceAll("\\*","");
  }
  
  for(int i = 1; i <= 5; i++){
     if(client[i] != null && !client[i].active()){
        client[i] = null;
        name[i] = null;
        connected--;
     } 
  }
  
  background(0);
  for (Button e: button)
    e.display();
}

void mousePressed() {
  if (startGame)
    return;
  int pressed = -1;
  for (int i = 0 ;i < button.length; i++)
    if (button[i].mousePressed())
      pressed = i;

  if (pressed == -1) return;

  if ((pressed == 0 || client[0] == null) && client[pressed] != null) {
    name[pressed] = null;
    client[pressed ].stop();
    client[pressed] = null;
    if (pressed != 0)
      connected--;
  } 
  else if (client[0] != null && client[pressed] == null && pressed != 6) {
    client[pressed] = client[0];
    name[pressed] = name[0];
    client[0] = null;
    name[0] = null;
    client[pressed].write("SET " + pressed+"*");
    connected++;
  }
  else if (pressed == 6 && connected == 5) {
    startGame = true;
  }
}

void serverEvent(Server server, Client c) {
  if (connected+playerQueue.size() == 5) {
    if (connected == 5)c.write("FULL*");
    c.stop();
    return;
  }
  else if (client[0] != null) {
    c.write("BUSY*");
    playerQueue.offer(c);
    return;
  }
  String temp = null;
  while (temp == null) {
    temp = c.readStringUntil('*');
  }
  name[0] = temp.replaceAll("\\*","");
  client[0] = c;
}


