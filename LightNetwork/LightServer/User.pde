class User {
  Client me;
  int timer, id, delay;
  boolean state = false; // False = off, true = on

  User(Client c, int id_) {
    me = c;
    id = id_;
    timer = 0;
    delay = 10*id;
  }

  void display() {
    if (timer > 0) {
      if (delay > 0) {
        delay--;
      } else {
        timer--;
      }
    } else if (timer == 0) {
      switchState(50);
    }
  }

  void switchState(int time) {
    state = !state;
    me.write(""+state);
    messages.add(me+" : "+state);
    timer = time;
    //delay = 10*id;
  }
}
