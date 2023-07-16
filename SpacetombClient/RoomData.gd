extends Node

var oxygenRoom = load("res://oxygenroom.tscn")
var roomsS = {1: oxygenRoom}

var mazeRoom = load("res://MazeRoom.tscn")
var pylonRoom = load("res://PylonRoom.tscn")
var spikePitRoom = load("res://SpikePitRoom.tscn")
var tombRoom = load("res://TombRoom.tscn")
var roomsM = {1: mazeRoom, 2: pylonRoom, 3: spikePitRoom, 4: tombRoom}

var cafeteria = load("res://cafeteria.tscn")
var reactorRoom = load("res://ReactorRoom.tscn")
var roomsL = {1: cafeteria, 2: reactorRoom}
