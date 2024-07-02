uniform float uTime;
uniform float uSpeedOffset;
uniform float uNoiseOffset;

varying vec3 vWorldPosition;
varying vec3 vWorldNormal;
varying vec3 vViewPosition;
varying float vNoise;
varying vec2 vUv;

#include ../shaders/includes/simplexNoise4d.glsl

void main()
{

    vec4 worldPosition = modelMatrix * vec4( position, 1.0 );
    vec4 worldNormals = modelMatrix * vec4( normal, 0.0 );
    vec3 viewPosition = cameraPosition - worldPosition.xyz;

    float noise = simplexNoise4d( vec4( worldPosition.xyz  * uNoiseOffset, uTime * uSpeedOffset ) );

    // Final position
    gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );

    // Varyings
    vUv = uv;
    vWorldPosition = worldPosition.xyz;
    vWorldNormal = normalize( worldNormals.xyz );
    vViewPosition = normalize( viewPosition );
    vNoise = noise;

}