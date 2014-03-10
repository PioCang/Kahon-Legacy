//Game Status
int WAITING_FOR_PLAYERS = 0;
int STARTING = 1;
int ASK_FOR_COMMANDS = 2;
int WAITING_FOR_COMMANDS = 3;
int PROCESSING_COMMANDS = 4;
int SENDING_GAMEDATA = 5;
int WAIT_FOR_TERMINALS = 6;
int FINISHED = 7;

int MOVE_LEFT = 50;
int MOVE_UP = 51;
int MOVE_RIGHT = 52;
int MOVE_DOWN = 53;
int DASH_LEFT = 1;
int DASH_UP = 2;
int DASH_RIGHT = 3 ;
int DASH_DOWN = 4;
int STOP = 0;
int DROP_THE_LOOT = 1000;

//Grammar
String guard_credentials ="(MATT|JEREMY)";
String theif_credentials = "(BRUNO|DOSTIN|TRESIA|TUTU)";
String direction = "(UP|DOWN|LEFT|RIGHT)";
String positive_integer = "([1-9][0-9]*)";
String stop = String.format("(STOP( %s)?)",positive_integer);
String move = String.format("(MOVE( %s)+)",direction);
String dash = String.format("(DASH %s)",direction);
String theif = String.format("((%s|%s)\\.)",move,stop);
String guard = String.format("((%s|%s|%s)\\.)",stop,move,dash);
String theif_program = String.format("(%s:(DROP THE LOOT\\.)?(%s)*)",theif_credentials,theif);
String guard_program = String.format("(%s:(%s)*)",guard_credentials,guard);
String program = String.format("(%s|%s)",theif_program,guard_program);
