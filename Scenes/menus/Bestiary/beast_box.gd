extends Node2D

@export var beast:Beast


@onready var artwork = $beast_image
@onready var beast_name = $beast_name
@onready var beast_desc = $beast_desc


func _ready():
	artwork.texture=beast.artwork
	beast_name.text=beast.name
	beast_desc.text = beast.description
