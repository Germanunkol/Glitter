vec4 resultCol;
extern vec2 stepSize;

vec4 effect( vec4 col, Image texture, vec2 texturePos, vec2 screenPos )
{
	// get color of pixels:
	number alpha = 4*texture2D( texture, texturePos ).a;
	alpha -= texture2D( texture, texturePos + vec2( stepSize.x, 0.0f ) ).a;
	alpha -= texture2D( texture, texturePos + vec2( -stepSize.x, 0.0f ) ).a;
	alpha -= texture2D( texture, texturePos + vec2( 0.0f, stepSize.y ) ).a;
	alpha -= texture2D( texture, texturePos + vec2( 0.0f, -stepSize.y ) ).a;

	// calculate resulting color
	//resultCol = vec4( 0.4f, 1.0f, 0.1f, alpha );
	resultCol = vec4( col.rgb, alpha );
	// return color for current pixel
	return resultCol;
}
