// The size of a pixel (or larger if a larger blur is wanted)
// Get this size by calculating 1/imageHeight
extern number blurSize = 0.005;

// Gaussian function used:
// 1/sqrt(2*pi*2^2)*exp(-(x^2)/(2*2^2))

vec4 effect(vec4 color, Image texture, vec2 vTexCoord, vec2 pixel_coords)
{
	vec4 sum = vec4(0.0);

	// take nine samples, with the distance blurSize between them
	sum += texture2D(texture, vec2(vTexCoord.x, vTexCoord.y - 4.0*blurSize)) * 0.026;
	sum += texture2D(texture, vec2(vTexCoord.x, vTexCoord.y - 3.0*blurSize)) * 0.064;
	sum += texture2D(texture, vec2(vTexCoord.x, vTexCoord.y - 2.0*blurSize)) * 0.121;
	sum += texture2D(texture, vec2(vTexCoord.x, vTexCoord.y- blurSize)) * 0.176;
	sum += texture2D(texture, vec2(vTexCoord.x, vTexCoord.y)) * 0.199;
	sum += texture2D(texture, vec2(vTexCoord.x, vTexCoord.y + blurSize)) * 0.176;
	sum += texture2D(texture, vec2(vTexCoord.x, vTexCoord.y + 2.0*blurSize)) * 0.121;
	sum += texture2D(texture, vec2(vTexCoord.x, vTexCoord.y + 3.0*blurSize)) * 0.064;
	sum += texture2D(texture, vec2(vTexCoord.x, vTexCoord.y + 4.0*blurSize)) * 0.026;

	return sum;
}

