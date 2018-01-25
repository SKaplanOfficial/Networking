/*
 
 Light Client
 
 */

//*****************************//
//   IMPORTS, VARIABLES, ETC   //
//*****************************//

// IMPORTS
import processing.net.*;

// NETWORK
Client myClient;
int port = 10001; // Port must be same as server port!
String id = "Tablet A";

//*****************************//
//       SETUP  FUNCTION       //
//*****************************//

void setup() {
  size(300, 500);

  //myClient = new Client(this, "54.208.53.64", port); // Global Server
  myClient = new Client(this, "localhost", port); // CONNECT TO SERVER & SEND INITIAL MESSAGE

  myClient.write(id+" has connected!"); // Announce user's arrival
}



//*****************************//
//        DRAW FUNCTION        //
//*****************************//

void draw() {
  if (myClient.available() > 0) { // Are there messages being sent to the Client?
    String msg = myClient.readString(); // Store them
    if (msg.equals(""+true)) {
      background(255);
    } else {
      background(0);
    }
    myClient.clear(); // Prepare to recieve other messages
  }
}
