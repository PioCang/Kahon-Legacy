HashMap<String,Integer> hm = new HashMap<String,Integer>();
String credentials[] = {"MATT","JEREMY","BRUNO","DOSTIN","TRESIA","TUTU","LEFT","UP","RIGHT","DOWN"};
int priority[] = new int[4];

void setupParser(){
  for(int i = 0 ; i < credentials.length; i++)
    hm.put(credentials[i],i>6?i-6:i);
  for(int i = 0; i < 4; i++)
    priority[i] = i+1;
}

Queue<Move>[] parsePrograms(String program){
  setupParser();
    StringTokenizer st = new StringTokenizer(program,";");
    Queue<Move> ret[] = new Queue[6];
    for(int i = 0; i < 1; i++){
      String s = st.nextToken();
      println(s);
      String temp[] = s.split(":");
      int index = hm.get(temp[0]);
      if(index <= 1) ret[index] = parseGuard(temp[1],index);
      else ret[index] = parseTheif(temp[1],index);
    }
  return ret;
}

Queue<Move> parseTheif (String program, int ID){
  Queue<Move> ret = new LinkedList<Move>();
  StringTokenizer st = new StringTokenizer(program,".");
  while(st.hasMoreTokens()){
    StringTokenizer stLine = new StringTokenizer(st.nextToken());
    String s = stLine.nextToken();
    println(s);
    if(s.equals("DROP"))
      ret.offer(new Move(ID,DROP_THE_LOOT));
    else if(s.equals("STOP")){
      int times = 1;
      if(stLine.hasMoreTokens())
        times = parseInt(stLine.nextToken());
      while(times-->0)
        ret.offer(new Move(ID,STOP));
    }else if(s.equals("MOVE")){
      while(stLine.hasMoreTokens())
        ret.offer(new Move(ID,50+hm.get(stLine.nextToken())));
    }
  }
  return ret;
}

Queue<Move> parseGuard (String program, int ID){
  Queue<Move> ret = new LinkedList<Move>();
  StringTokenizer st = new StringTokenizer(program,".");
  while(st.hasMoreTokens()){
    StringTokenizer stLine = new StringTokenizer(st.nextToken());
    String s = stLine.nextToken();
    if(s.equals("STOP")){
      int times = 1;
      if(stLine.hasMoreTokens())
        times = parseInt(stLine.nextToken());
      while(times-->0)
        ret.offer(new Move(ID,STOP));
    }else{
      while(stLine.hasMoreTokens())
        ret.offer(new Move(ID,hm.get(stLine.nextToken()) + (s.equals("DASH")?0:50)));
    }
  }
  return ret;
}

