shader_set(shader_hmap);
shader_set_uniform_f(shader_get_uniform(shader_hmap, "terrainSize"), floor_w);
shader_set_uniform_f(shader_get_uniform(shader_hmap, "terrainCellSize"), floor_cw);
shader_set_texture(vtex, 1);

vertex_submit(floorModel, pr_trianglelist, sprite_get_texture(s_square, 0));
shader_reset();