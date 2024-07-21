 float fresnelFactor( float amount, vec3 normal, vec3 view)
{
    return pow( 1.0 - max( dot( normal, view ), 0.0 ), amount );
}