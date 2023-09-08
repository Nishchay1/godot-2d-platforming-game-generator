extends Node

func obtain_tiles():
	return $LevelEditorTileMap.get_used_cells()

func obtain_size():
	return $LevelEditorTileMap.get_used_rect().size

func obtain_tile_index(pos):
	return $LevelEditorTileMap.get_cellv(pos)

func obtain_all_other_objects():
	var objects = get_children()
	objects.erase($LevelEditorTileMap)
	return objects

func remove_tiles():
	$LevelEditorTileMap.queue_free()
