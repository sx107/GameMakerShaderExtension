/// @description Camera movement and setup
#region Camera movement

var mx = mouse_x - window_get_width() / 2;
var my = mouse_y - window_get_height() / 2;
window_mouse_set(window_get_width() / 2, window_get_height() / 2);

cam_dir -= mx * 0.1;
cam_pitch += my * 0.1;
cam_pitch = clamp(cam_pitch, 90-60, 90+60);

var vf = keyboard_check(ord("W")) - keyboard_check(ord("S"));
var vs = keyboard_check(ord("D")) - keyboard_check(ord("A"));

x += dsin(cam_pitch) * (vf * dcos(cam_dir) + vs * dcos(cam_dir - 90));
y += dsin(cam_pitch) * (vf * dsin(cam_dir) + vs * dsin(cam_dir - 90));
z += vf * dcos(cam_pitch) + keyboard_check(vk_shift) - keyboard_check(vk_control);

#endregion

#region Camera setup

var lookat_x = x + dsin(cam_pitch) * dcos(cam_dir);
var lookat_y = y + dsin(cam_pitch) * dsin(cam_dir);
var lookat_z = z + dcos(cam_pitch);

draw_clear(c_white);
var camera = camera_get_active();
view_mat = matrix_build_lookat(x, y, z, lookat_x, lookat_y, lookat_z, 0, 0, -1);
camera_set_view_mat(camera, view_mat);
camera_set_proj_mat(camera, proj_mat);
camera_apply(camera);

#endregion