# GameMakerShaderExtension
 Vertex fetching for HLSL shaders.
 GMC forum topic: https://forum.gamemaker.io/index.php?threads/vertex-fetching-dll-for-hlsl.95806/

 A fork that adds loading from GM buffer and new texture formats.

 __TODO:__
 - Add 8-bit int formats
 - Add examples, especially with loading from buffer

 ## Functions and usage
 
 ### shader_set_device(device, context)
 
 Initializes everything by passing the device to the DLL. Use it like this:

     var _info = os_get_info();
     shader_set_device(_info[? "video_d3d11_device"], _info[? "video_d3d11_context"]);

### shader_create_vertex_texture(width, height, value, format)

Creates the texture that can be later used in HLSL. Returns the texture ID.
Width and height are the width and height of the texture. Remember the power-of-two rule.
Value is the value the texture will be initialized with.
Format can be either ``surface_r32float`` or ``surface_rgba32float``. Support for other formats will be added later.

### shader_set_texture(texture_id, slot)

Called after ``shader_set``. First argument is the texture ID, second is the slot. See below ("HLSL Usage") for slots explanation. "Alternative" to texture_set_stage, in a way.

### shader_update_texture(texture_id)

Update the texture ``texture_id``. Loads the data into the GPU. Use after you've made any changes to the texture; original author recommends calling it in __step__ event, which only makes sense if you update the texture regularly. May be called just after all changes as well.

### shader_set_texture_value(texture_id, index, value), shader_get_texture_value(texture_id, index)

Access to the raw data of the texture (still in RAM). For ``r32float`` textures essentially sets the pixel value, for ``rgba32float`` you have to take into account that every pixel takes 4 elements - r, g, b and a.

### shader_set_texture_pixel(id, x, y, r, g, b, a), shader_get_texture_pixel(id, x, y, channel)

Access to the pixel data of the texture in RAM in a bit more convinient way.

### shader_load_texture_from_buffer(texture_id, buffer_address, buffer_offset)

Loads the texture from GM buffer from the ``buffer_offset`` offset. Buffer address can be get using the ``buffer_get_address`` function; copying the surface to buffer can be done using ``buffer_get_surface``. In the latter case, be sure to use the same format for the surface and texture.

### shader_get_texture_memsize(texture_id)

Get the texture size in bytes. Useful for creating buffers of right size.

### shader_delete_texture(texture_id)

Deletes the texture texture_id.

### shader_free_slot

Unlinks the texture from the shader.

### shader_texture_free_ram(texture_id)

Frees the texture RAM, but leaves it in the GPU. After this procedure, the texture is unmodifiable. It can only be deleted.

### shader_clear_memory()

Full clearup, delete all textures. Can be used only once. Call in the __game_end__ event.

## HLSL Usage

``Texture2D myTexture : register( t0 );``

Adds the texture to slot 0. *t1* will add it to slot 1, *t2* will add it to slot 2 and so forth.

Texture fetching in vertex buffer is done using ``myTexture[uint2(6,6)]``. Note the _uint2_ type. There is no sub-sampling available in vertex shaders.
