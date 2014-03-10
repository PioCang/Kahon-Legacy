HashMap<String,Integer> hm = new HashMap<String,Integer>();
String credentials[] = {"MATT:","JEREMY:","BRUNO:","DOSTIN:","TRESIA:","TUTU:","LEFT","UP","RIGHT","DOWN"};

void setupParser(){
	for(int i = 0 ; i < credentials.length; i++)
		hm.put(credentials[i],i>5?i-5:i);
}

Queue<Move>[] parsePrograms(String program){
  	StringTokenizer st = new StringTokenizer(program,";");
  	Queue<Move> ret[] = new Queue[6];
  	for(int i = 0; i < 6; i++){
  		String temp[] = st.nextToken().split(":");
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
		String s = st.nextToken();
		if(s.equals("DROP THE LOOT"))
			ret.offer(new Move(ID,DROP_THE_LOOT));
		else if(s.equals("STOP")){
			int times = 1;
			if(st.hasMoreTokens())
				times = parseInt(st.nextToken());
			while(times-->0)
				ret.offer(new Move(ID,STOP));
		}else if(s.equals("MOVE")){
			while(st.hasMoreTokens())
				ret.offer(new Move(ID,50+hm.get(st.nextToken())));
		}
	}
	return ret;
}

Queue<Move> parseGuard (String program, int ID){
  Queue<Move> ret = new LinkedList<Move>();
  StringTokenizer st = new StringTokenizer(program,".");
  while(st.hasMoreTokens()){
    String s = st.nextToken();
    if(s.equals("STOP")){
      int times = 1;
      if(st.hasMoreTokens())
        times = parseInt(st.nextToken());
      while(times-->0)
        ret.offer(new Move(ID,STOP));
    }else{
      while(st.hasMoreTokens())
        ret.offer(new Move(ID,hm.get(st.nextToken()) + (s.equals("DASH")?0:50)));
    }
  }
  return ret;
}
