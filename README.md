Overview:

Spacetomb is a multiplayer roguelike game that uses a client server architecture model. The game is currently not live, though at one point we hosted the server through AWS.
The AWS server used bash scripts for starting server instances on different ports, and stopping instances. Those scripts are not featured here.

The game was developed using the Godot game engine, which uses Godotscript (similar to python).

There are two components to Spacetomb, the client code, and the server code. The server code is ran on our AWS server, and the client code was ran as an app by players.

At the end of our development period, Spacetomb had the following features:

  -Player movement physics system\
  -Player shooting projectiles\
  -Multiple players connecting and interacting in the same lobby\
  -Joining, leaving, disconnecting, reconnecting etc\
  -Multiple simultaneous lobbies/ matchmaking\
  -Main menu scene\
  -Player vs Player Combat\
  -Enemies which tracked and seeked out the nearest player\
  -Player vs Enemy Combat\
  -Randomly Generated map / room layout
  
