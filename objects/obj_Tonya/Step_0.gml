switch (state) {
    case TonyaState.PREPARING:
		sprite_index = spr_tonya_idle;
		if !(alarm[0]) {
			alarm[0] = game_get_speed(gamespeed_fps) * 3.5;
		}
		x -= 2;
		y += 2;
        break;
        
    case TonyaState.SKATING:
		sprite_index = spr_tonya_skate;
        if (instance_exists(obj_Player)) {
            var pos_data = [obj_Player.x, obj_Player.y];
            ds_list_add(path_history, pos_data);
			
			if (place_meeting(x, y, obj_Player) && !obj_Player.is_player_invuln && obj_Player.state != PlayerState.JUMP) {
				obj_Game_Controller.handle_score_event("bd_tonya_collision");
				obj_Player.state = PlayerState.HIT;
				
                state = TonyaState.ANGRY;
				audio_play_sound(snd_Angry_Tonya, 100, false);
                anger_timer = 0;
                frozen_x = x;
                frozen_y = y;
                break;
			} else if (place_meeting(x, y, obj_Player) && !obj_Player.is_player_invuln && !given_jump_bonus) {
				given_jump_bonus = true;
				obj_Game_Controller.handle_score_event("gd_dodge_success");
			}
           
            if (transition_timer < transition_duration) {
                transition_timer++;
                
                if (ds_list_size(path_history) > follow_delay) {
                    var delayed_pos = path_history[| 0];
                    var target_x = delayed_pos[0];
                    var target_y = delayed_pos[1];
                    
                    var transition_progress = transition_timer / transition_duration;
                    x = lerp(x, target_x, transition_progress * 0.1);
                    y = lerp(y, target_y, transition_progress * 0.1);
                    
                    ds_list_delete(path_history, 0);
                }
            } else {
                if (ds_list_size(path_history) > follow_delay) {
                    var delayed_pos = path_history[| 0];
					
                    var target_x = delayed_pos[0];
                    var target_y = delayed_pos[1];
					
                    var dist_to_target = point_distance(x, y, target_x, target_y);
                    var current_speed = (dist_to_target > 100) ? catch_up_speed : normal_follow_speed;
                    
                    x = lerp(x, target_x, current_speed * 0.1);
                    y = lerp(y, target_y, current_speed * 0.1);
                    
                    ds_list_delete(path_history, 0);
                }
            }
        }
        break;
        
    case TonyaState.ANGRY:
		sprite_index = spr_tonya_angry;
        x = frozen_x;
        y = frozen_y;
		
        if (instance_exists(obj_Player)) {
            var pos_data = [obj_Player.x, obj_Player.y];
            ds_list_add(path_history, pos_data);
			
			if (ds_list_size(path_history) > follow_delay) {
	            ds_list_delete(path_history, 0);
	        }
        }
        
		
        anger_timer++;
        
        if (anger_timer >= anger_duration) {
			
            state = TonyaState.SKATING;
            
            transition_timer = 0;
            transition_duration = 30;
        }
        break;
}