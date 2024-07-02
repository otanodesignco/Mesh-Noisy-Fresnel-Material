 float fresnelFactor( float amount, float offset, vec3 normal, vec3 view)
{
    return offset + ( 1.0 - offset ) * pow( 1.0 - dot( normal , view ), amount );
}