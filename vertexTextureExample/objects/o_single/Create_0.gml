#region Initialize the vertex texture fetching system

var _info = os_get_info();
shader_set_device(_info[? "video_d3d11_device"],_info[? "video_d3d11_context"]);

#endregion

#region Basic 3d settings

display_reset(4, true);

gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);

vertex_format_begin();
vertex_format_add_position_3d(); // 12
vertex_format_add_normal();  //24
vertex_format_add_texcoord(); // 32
vertex_format_add_color(); // 32 + 4
vformat = vertex_format_end();

view_mat = matrix_build_lookat(x, y+100, 100, x, y, 0, 0, 0, -1);
proj_mat = matrix_build_projection_perspective_fov(75, window_get_width()/window_get_height(), 1, 10000);

depth = 1000;

#endregion

#region Initalize the camera movement

cam_pitch = 90+45;
cam_dir = 0;
display_mouse_set(window_get_width() / 2, window_get_height() / 2);

#endregion

#region Create the floor vertex buffer

floor_w = 300;
floor_h = floor_w;
floor_cw = 64;
floor_ch = floor_cw;

floorModel = vertex_create_buffer();
vertex_begin(floorModel, vformat);

for(var i = 0; i < floor_cw; i++) {
	for(var j = 0; j < floor_ch; j++) {
		var xx = i * (floor_w / floor_cw);
		var yy = j * (floor_h / floor_ch);
		var xx2 = xx + (floor_w / floor_cw);
		var yy2 = yy + (floor_h / floor_ch);
		
		// x, y, z, u, v
		vertex_add_point(floorModel, xx, yy, 0, 0, 0);
		vertex_add_point(floorModel, xx2, yy, 0, 1, 0);
		vertex_add_point(floorModel, xx, yy2, 0, 0, 1);
		
		vertex_add_point(floorModel, xx2, yy, 0, 1, 0);
		vertex_add_point(floorModel, xx2, yy2, 0, 1, 1);
		vertex_add_point(floorModel, xx, yy2, 0, 0, 1);
	}
}

vertex_end(floorModel);

x = floor_w / 2.0;
y = floor_h / 2.0 - floor_h;
z = floor_h/2.0;

#endregion

#region Create the floor vtex
vtex = shader_create_vertex_texture(floor_cw, floor_ch, 0.0, surface_r32float);
buf_vtex = buffer_create(shader_get_texture_memsize(vtex), buffer_fixed, 1);
buffer_fill(buf_vtex, 0, buffer_u8, 10.0, buffer_get_size(buf_vtex));
surf_vtex = undefined;

// Circle movement
circle_x = floor_cw / 4;
circle_y = floor_ch / 2;
circle_vx = 0.3;
circle_vy = 0.3;
#endregion