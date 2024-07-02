uniform vec3 uBaseColor;
uniform vec3 uGlowColor;
uniform float uFresnelAmount;
uniform float uFresnelOffset;
uniform float uFresnelIntensity;
uniform float uFrenselBlend;
uniform float uTime;
uniform float uSpeedOffset;
uniform float uNoiseOffset;


varying vec3 vWorldPosition;
varying vec3 vWorldNormal;
varying vec3 vViewPosition;
varying float vNoise;
varying vec2 vUv;

#include ../shaders/includes/fresnelFactor.glsl
#include ../shaders/includes/lambertDiffuse.glsl
#include ../shaders/includes/cnoise.glsl


void main()
{

    vec2 uv = vUv;

    float noisePerlin = cnoise( vec3( vWorldPosition.xy * uNoiseOffset, uTime * uSpeedOffset ) );
    //vec4 colorNoise = vec4( vec3( noisePerlin ), 1.0 ); noise debug

    float fresnel = fresnelFactor( uFresnelAmount, uFresnelOffset, vWorldNormal, vViewPosition );
    float fresnelNoise = fresnel * ( 0.5 + 0.5 * ( 1.0 - vNoise ) );
    fresnel = mix( fresnel, fresnelNoise, uFrenselBlend );
    
    vec4 colorFresnel = vec4( uGlowColor, fresnel );
    colorFresnel.rgb *= fresnel;
    colorFresnel.rgb *= uFresnelIntensity;

    float lambert = lambertDiffuse( vWorldNormal, vViewPosition );
    lambert = smoothstep( 0.0, 1.0, lambert );
    vec4 colorLambert = vec4( uBaseColor, lambert );
    colorLambert.rgb *= lambert;

    
    

    vec4 finalColor = mix( colorLambert, colorFresnel, fresnel );

    gl_FragColor = finalColor;
    #include <tonemapping_fragment>
    #include <colorspace_fragment>

}