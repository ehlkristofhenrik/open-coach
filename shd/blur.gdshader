shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform float blur_amount : hint_range(0.0, 5.0) = 2.0;

void fragment() {
    // textureLod reads the texture at a specific Level of Detail (LOD)
    // Higher LOD = More Blur
    vec4 blurred_color = textureLod(screen_texture, SCREEN_UV, blur_amount);
    COLOR = blurred_color;
}