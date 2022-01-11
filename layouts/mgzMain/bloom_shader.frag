precision highp float;
uniform sampler2D bgl_RenderedTexture;

void main() {
	vec4 sum = vec4(0);
	vec2 texcoord = vec2(gl_TexCoord[0]);
	int j;
	int i;
	for(i= -4 ;i < 4; i++) {
		for (j = -3; j < 3; j++) {
			sum += gl_Color * texture2D(bgl_RenderedTexture, texcoord + vec2(j, i) * 0.004) * 0.25;
		}
	}
	vec4 bloomColor = vec4(0);
	if (texture2D(bgl_RenderedTexture, texcoord).r < 0.3) {
		bloomColor = sum * sum * 0.012 + gl_Color * texture2D(bgl_RenderedTexture, texcoord);
	} else {
		if (texture2D(bgl_RenderedTexture, texcoord).r < 0.5) {
			bloomColor = sum * sum * 0.009 + gl_Color * texture2D(bgl_RenderedTexture, texcoord);
		} else {
			bloomColor = sum * sum * 0.0075 + gl_Color * texture2D(bgl_RenderedTexture, texcoord);
		}
	}
	gl_FragColor = mix(texture2D(bgl_RenderedTexture, texcoord), bloomColor, 0.3);
}
