//!HOOK LUMA
//!BIND HOOKED
//!DESC gaussian film grain. Modified from "https://raw.githubusercontent.com/haasn/gentoo-conf/xor/home/nand/.mpv/shaders/filmgrain.glsl" to account for luminance.

#define INTENSITY 0.16

float permute(float x)
{
    x = (34.0 * x + 1.0) * x;
    return fract(x * 1.0/289.0) * 289.0;
}

float rand(inout float state)
{
    state = permute(state);
    return fract(state * 1.0/41.0);
}

vec4 hook()
{
    vec3 m = vec3(HOOKED_pos, random) + vec3(1.0);
    float state = permute(permute(m.x) + m.y) + m.z;

    const float a0 = 0.151015505647689;
    const float a1 = -0.5303572634357367;
    const float a2 = 1.365020122861334;
    const float b0 = 0.132089632343748;
    const float b1 = 1.5; //-0.7607324991323768

    vec4 color = HOOKED_tex(HOOKED_pos);
    float luminance = dot(color.rgb, vec3(0.299, 0.587, 0.114));

    float p = 0.95 * rand(state) + 0.025;
    float q = p - 0.5;
    float r = q * q;

    float grain = q * (a2 + (a1 * r + a0) / (r*r + b1*r + b0));
    grain *= 0.255121822830526; // normalize to [-1,1)

    float mediumLuma = 0.5;
    float intensityFactor = 1.7 - smoothstep(mediumLuma - 0.05, mediumLuma - 0.05, luminance);
    grain *= mix(1.0, pow(luminance, 0.5), intensityFactor);

    color.rgb += vec3(INTENSITY * grain);
    return color;
} 
