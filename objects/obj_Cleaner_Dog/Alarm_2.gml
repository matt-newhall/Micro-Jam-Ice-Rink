// Generate random position
var rnd_x = random_range(0, 1);
var rnd_y = random_range(0, 1);
target_x = global.play_left + 100 + rnd_x * ((global.play_right - 150) - (global.play_left + 100));
target_y = global.play_top + 100 + rnd_y * ((global.play_bottom - 150) - (global.play_top + 100));

// Start moving to that position
state = CleanerState.MOVING;
