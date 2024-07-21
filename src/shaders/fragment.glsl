uniform vec3 uBaseColor;
uniform vec3 uGlowColor;
uniform float uFresnelAmount;
uniform float uFresnelIntensity;
uniform float uFrenselBlend;
uniform float uTime;
uniform float uSpeedOffset;
uniform float uNoiseOffset;


varying vec3 vWorldPosition;
varying vec3 vWorldNormal;
varying vec3 vViewPosition;
varying float vNoise;

#include ../shaders/includes/fresnelFactor.glsl
#include ../shaders/includes/lambertDiffuse.glsl
#include ../shaders/includes/cnoise.glsl


void main()
{

    // animated uv
    vec3 cUV = vec3( vWorldPosition.xy * uNoiseOffset, uTime * uSpeedOffset );
    // perlin noise, can be swapped with vNoise
    float noisePerlin = cnoise( cUV );
    // fresnel factor
    float fresnel = fresnelFactor( uFresnelAmount, vWorldNormal, vViewPosition );
    // mask to blend noise against the fresnel gradient
    float fresnelMask = smoothstep( uFrenselBlend, 0.0, fresnel );
    // blend the noise with the fresnel based on the mask. mask sets start position of the noise
    // along the fresnel gradient
    float fresnelNoise = mix( fresnel, fresnel * ( 1.0 + vNoise ), fresnelMask );
    // fresnel color
    vec3 colorFresnel = ( uGlowColor * fresnelNoise ) * uFresnelIntensity;
    // lambert lighting
    float lambert = lambertDiffuse( vWorldNormal, vViewPosition );
    // lambert color
    vec3 colorLambert = uBaseColor * lambert;
    // blend of lambert with fresnel on top
    vec3 colorBlend = colorLambert + colorFresnel;
    // final color
    vec4 colorFinal = vec4( colorBlend, 1.0 );

    gl_FragColor = colorFinal;
    #include <tonemapping_fragment>
    #include <colorspace_fragment>

}