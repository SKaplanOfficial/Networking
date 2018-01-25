/*
 
 Light Server
 
 */

//*****************************//
//   IMPORTS, VARIABLES, ETC   //
//*****************************//

// IMPORTS
import processing.net.*;

// SERVER
Server myServer; // Server Object
int port = 10001; // Helps other computers connect to the server, if properly set up
String msg; // Stores messages coming IN
boolean myServerRunning = true;

// REGULATORS
int messagesPos = 0; // Determines starting position of messages
boolean isGoing = false;

// LISTS
ArrayList<String> messages = new ArrayList<String>();
ArrayList<User> users = new ArrayList<User>();
// Using an ARRAYLIST so that we can control what messages are displayed on screen & when



//*****************************//
//       SETUP  FUNCTION       //
//*****************************//

void setup() {
  size(500, 300);
  myServer = new Server(this, port);
  // Server open on specified port
}



//*****************************//
//        DRAW FUNCTION        //
//*****************************//

void draw() {
  background(0);

  if (myServerRunning == true) { // IF the server is open
    Client sender = myServer.available(); // Find users connected
    if (sender != null && sender.available() > 0) { // Find any messages sent to the server
      msg = sender.readString(); // Store those messages in msg variable
      //regulate(msg, sender);

      if (!users.contains(sender)) {
        users.add(new User(sender, users.size()));
      }
    }

    messagesUI(); // Show messages on server screen
  } else { // IF the server is closed
    //  stopServerUI(); // Display a stopped screen
  }

  if (isGoing == true) {
    for (int i=0; i<users.size(); i++) {
      users.get(i).display();
    }
  }

  // Change amount of messages displayed based on window size
  if (messages.size()-messagesPos > int((height-32)/12) && messages.size() > 0) {
    messagesPos += 1;
  }
} // END OF DRAW FUNCTION



//*****************************//
//       USER  INTERFACE       //
//*****************************//

void messagesUI() { // Stored in separate function in case you want to add FEATURES
  for (int i=messagesPos; i<messages.size(); i++) { // For all messages in the ArrayList
    text(messages.get(i), 5, (i-messagesPos)*12+12); // Position them based on their location in the ArrayList (i)
    // i-messagePos results in the OLDEST MESSAGES being positioned OFF SCREEN as new ones are added
  }
}

//*****************************//
//      SHUTDOWN  SCRIPTS      //
//*****************************//

void stopServer() {
  myServer.stop(); // Shutdown server
  exit(); // Close window on shutdown
}
