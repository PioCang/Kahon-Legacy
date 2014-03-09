import processing.net.*;
import java.util.*;

//GUI Variables
int pSize = 20;

//Server Variables
int port = 5204;
int connected = 0;
Button button[];
Server server = null;
Queue<Client> playerQueue;

//Game Status
int status;
int counter = 0;
String command[];
GameEngine game;

void setup() {
  size(22*pSize, 30*pSize);
  button = new Button[7];
  _width = width-pSize*2;
  _height = 4*pSize;

  //Get port number from config.txt
  String arr[] = loadStrings("config.txt");
  port = parseInt(arr[0].split(" ")[1]);

  //Setting up server
  server = new Server(this, port);
  playerQueue = new LinkedList<Client>();
  status = WAITING_FOR_PLAYERS;
  command = new String[5];
  for (int i = 0; i < 7; i++)
    button[i] = new Button(pSize, pSize+_height*i, i);

}

void draw() {
  if(status == STARTING){
    //Give initial set up of the game
    game = new GameEngine();
    server.write(game.initString()+"*");
    status = ASK_FOR_COMMANDS;
  }else if(status == ASK_FOR_COMMANDS){
    //Send signal to get commands from clients
    server.write(game.nextRoundString()+"*");
    status = WAITING_FOR_COMMANDS;
    counter = 0;
  }else if(status == WAITING_FOR_COMMANDS){
    //Look if there is available data from clients and store them
    Client client = server.available();
    if(client==null) return;
    while(client.available() == 0);
    String temp = null;
    while(temp==null)
      temp = client.readStringUntil('*');
    temp = temp.replaceAll("\\*","");
    int index = parseInt(temp);
    temp = null;
    while(temp==null)
      temp = client.readStringUntil('*');
    command[index] = temp;
    counter++;

    //For updating in terminals
    // sever.write("COMMANDED "+ index + "*");

    if(counter == 5)
      status = PROCESSING_COMMANDS;
  }else if(status == PROCESSING_COMMANDS){
    //Give data to GameEngine
      if(!game.hasResults()){
        StringBuilder sb = new StringBuilder();
       for(int i = 0; i < 5; i++){
         sb.append(command[i] + ";");
         command[i] = null;
        }
        game.execute(sb.toString());
      }else{
        status = SENDING_GAMEDATA;
      }
  }else if(status == SENDING_GAMEDATA){
    //Send data to game engine 
    server.write(game.gamedataString());
    status = WAIT_FOR_TERMINALS;
    counter = 0;
  }else if(status == WAIT_FOR_TERMINALS){
    //Waiting for all the terminal to finish executing the tasks
    Client client = server.available();
    if(client==null) return;
    while(client.available() == 0);
    String temp = null;
    while(temp==null)
      temp = client.readStringUntil('*');
    temp = temp.replaceAll("\\*","");
    int index = parseInt(temp);
    counter++;

    if(counter == 5){
      status = ASK_FOR_COMMANDS;
      if(game.finished()){
        server.write("FINISHED*");
        status = FINISHED;
      }
    }
  }else if(status == WAITING_FOR_PLAYERS){
    if (client[0] == null && playerQueue.size() != 0) {
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
}

void mousePressed() {
  if (status!=WAITING_FOR_PLAYERS)
    return;

  int pressed = -1;
  for (int i = 0 ;i < button.length; i++)
    if (button[i].mousePressed())
      pressed = i;
  if (pressed == -1) return;

  if ((pressed == 0 || client[0] == null) && client[pressed] != null) {
    name[pressed] = null;
    client[pressed].write("DISCONNECTED*");
    client[pressed].stop();
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
    status = WAITING_FOR_PLAYERS;
  }
}

void serverEvent(Server server, Client c) {
  if (connected+playerQueue.size() == 5) {
    c.write("FULL*");
    c.stop();
    return;
  }
  else{
    c.write("INQEUEUE*");
    playerQueue.offer(c);
    return;
  }
}


