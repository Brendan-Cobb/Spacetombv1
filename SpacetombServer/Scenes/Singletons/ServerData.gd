extends Node

# Array that stores IDs of all players. Stored in order of connection (first to connect, first in array)
# IDs are removed on disconnect, so playerIDs[0] will always be the oldest player
var playerIDS = []

# Array that stores IDs of all enemies. Stored in order of spawning. IDs are removed on enemy death or despawning
var enemyIDS = []

# Int that stores how many enemies have been made since the server has started. Used to create enemyIDs
var enemyCount = 0

var oxygenRoom = load("res://Scenes/Rooms/oxygenroom.tscn")
var roomsS = {1: oxygenRoom}

var mazeRoom = load("res://Scenes/Rooms/MazeRoom.tscn")
var pylonRoom = load("res://Scenes/Rooms/PylonRoom.tscn")
var spikePitRoom = load("res://Scenes/Rooms/SpikePitRoom.tscn")
var tombRoom = load("res://Scenes/Rooms/TombRoom.tscn")
var roomsM = {1: mazeRoom, 2: pylonRoom, 3: spikePitRoom, 4: tombRoom}

var cafeteria = load("res://Scenes/Rooms/cafeteria.tscn")
var reactorRoom = load("res://Scenes/Rooms/ReactorRoom.tscn")
var roomsL = {1: cafeteria, 2: reactorRoom}

var currentRooms = []
