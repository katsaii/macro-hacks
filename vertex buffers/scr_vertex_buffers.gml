/* Vertex Format Extension Functions
 * ---------------------------------
 * Kat @Katsaii
 */

/// @desc Returns the size (in bytes) of a vertex format.
/// @param {real} vformat The vertex format to inspect.
function vertex_format_size(_vformat) {
	static max_size = 256;
	// 32 bytes is a realistic size.
	// 256 is an, unrealistic, finite upper limit.
	var buff = buffer_create(max_size, buffer_grow, 1);
	var vbuff = vertex_create_buffer_from_buffer(buff, _vformat);
	var vbuff_buff = buffer_create_from_vertex_buffer(vbuff, buffer_grow, 1);
	var vcount = vertex_get_number(vbuff);
	var size = vcount > 0 ? floor(buffer_get_size(vbuff_buff) / vcount) : -1;
	buffer_delete(buff);
	vertex_delete_buffer(vbuff);
	buffer_delete(vbuff_buff);
	return size;
}