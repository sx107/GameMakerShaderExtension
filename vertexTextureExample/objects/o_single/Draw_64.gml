if is_undefined(surf_vtex) {
	surf_vtex = surface_create(floor_cw, floor_ch, surface_r32float);
	surface_set_target(surf_vtex);
	draw_clear(c_white);
	surface_reset_target();
}

surface_set_target(surf_vtex);
draw_set_alpha(0.1);
draw_set_color(c_black);
draw_rectangle(0, 0, floor_cw, floor_ch, 0);
draw_set_color(c_white);
draw_set_alpha(1.0);
draw_circle(circle_x, circle_y, 5, 0);
surface_reset_target();

buffer_get_surface(buf_vtex, surf_vtex, 0);
shader_load_texture_from_buffer(vtex, buffer_get_address(buf_vtex), 0);
shader_update_texture(vtex);

draw_surface(surf_vtex, 0, 0);

