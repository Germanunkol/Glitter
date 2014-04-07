// The size of a pixel (or larger if a larger blur is wanted)
// Get this size by calculating 1/imageWidth
extern number blurSize = 0.005;

/*
0, 0.199
1, 0.176
2, 0.121
3, 0.064
4, 0.026
*/

vec4 effect(vec4 color, Image texture, vec2 vTexCoord, vec2 pixel_coords)
{
	vec4 sum = vec4(0.0);

	// take nine samples, with the distance blurSize between them
	sum += texture2D(texture, vec2(vTexCoord.x - 4.0*blurSize, vTexCoord.y)) * 0.026;
	sum += texture2D(texture, vec2(vTexCoord.x - 3.0*blurSize, vTexCoord.y)) * 0.064;
	sum += texture2D(texture, vec2(vTexCoord.x - 2.0*blurSize, vTexCoord.y)) * 0.121;
	sum += texture2D(texture, vec2(vTexCoord.x - blurSize, vTexCoord.y)) * 0.176;
	sum += texture2D(texture, vec2(vTexCoord.x, vTexCoord.y)) * 0.199;
	sum += texture2D(texture, vec2(vTexCoord.x + blurSize, vTexCoord.y)) * 0.176;
	sum += texture2D(texture, vec2(vTexCoord.x + 2.0*blurSize, vTexCoord.y)) * 0.121;
	sum += texture2D(texture, vec2(vTexCoord.x + 3.0*blurSize, vTexCoord.y)) * 0.064;
	sum += texture2D(texture, vec2(vTexCoord.x + 4.0*blurSize, vTexCoord.y)) * 0.026;

	return sum;
}

