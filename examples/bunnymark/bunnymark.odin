package bunnymark

import "core:fmt"
import "core:strings"

using import "../../raylib_types"
using import "../../raylib_bindings"

MAX_BUNNIES :: 100000;

Bunny :: struct {
    position : Vector2,
    speed : Vector2,
    color : Color,
}

main :: proc() {

    screen_width :: 1280;
    screen_height :: 960;

    init_window(screen_width, screen_height, "raylib-odin example :: Bunnymark");
    defer close_window();

    tex_bunny := load_texture("resources/bunnymark/wabbit_alpha.png");

    bunnies := make([]Bunny, MAX_BUNNIES);

    bunnies_count := 0;

    set_target_fps(60);

    for !window_should_close() {
        if is_mouse_button_down(.LEFT_BUTTON) {
            for _ in 0..100 {
                bunnies[bunnies_count].position = get_mouse_position();
                bunnies[bunnies_count].speed.x = f32(get_random_value(250, 500)) / f32(60);
                bunnies[bunnies_count].speed.y = f32(get_random_value(250, 500) - 500) / f32(60);
                bunnies[bunnies_count].color = Color {
                    cast(u8)get_random_value(0, 255), cast(u8)get_random_value(0, 255), cast(u8)get_random_value(0, 255), 255 };
                bunnies_count += 1;
            }
        }

        for i in 0..bunnies_count {
            bunnies[i].position.x += bunnies[i].speed.x;
            bunnies[i].position.y += bunnies[i].speed.y;

            if bunnies[i].position.x > cast(f32)get_screen_width() || bunnies[i].position.x < 0 do bunnies[i].speed.x *= -1;
            if bunnies[i].position.y > cast(f32)get_screen_height() || bunnies[i].position.y < 0 do bunnies[i].speed.y *= -1;
        }

        begin_drawing();
        defer end_drawing();

        clear_background(RAYWHITE);

        for i in 0..bunnies_count {
            draw_texture(tex_bunny, cast(i32)bunnies[i].position.x, cast(i32)bunnies[i].position.y, bunnies[i].color);
        }

        draw_rectangle(0, 0, screen_width, 40, LIGHTGRAY);
        draw_text("raylib-odin bunnymark", 10, 10, 20, DARKGRAY);
        s := strings.clone_to_cstring(fmt.tprint("bunnies:", bunnies_count)); defer delete(s);
        draw_text(s, 400, 10, 20, RED);
        draw_fps(260, 10);
    }
}