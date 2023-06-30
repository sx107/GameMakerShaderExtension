function vertex_add_point(vbuf, xx, yy, zz, u, v) {
	vertex_position_3d(vbuf, xx, yy, zz);
	vertex_normal(vbuf, 0, 0, 1);
	vertex_texcoord(vbuf, u, v);
	vertex_color(vbuf, c_white, 1);
}