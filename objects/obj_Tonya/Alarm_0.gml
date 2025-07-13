state = TonyaState.SKATING;

if (instance_exists(obj_Player)) {
    for (var i = 0; i < follow_delay; i++) {
        var pos_data = [obj_Player.x, obj_Player.y];
        ds_list_add(path_history, pos_data);
    }
}