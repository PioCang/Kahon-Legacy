import processing.net.*;

int x = 0;
Client client;
String name = "Pepe";
String response;
void setup() {
  size(300, 200, P3D);
  client = new Client(this, "127.0.0.1", 5000);
  client.write(name+"*");
  response = null;
  while (response==null) {
    response = client.readStringUntil('*');
  }
  println(response);
  bitText(response, 0, 0);
}

void draw() {
  if(!client.active()){
    println("ERROR");
  }else{
     println(">__<"); 
  }
}

