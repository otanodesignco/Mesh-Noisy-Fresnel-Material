float lambertDiffuse( vec3 normal, vec3 viewDirection )
{
    return max( dot( normal, viewDirection ), 0.0 );
}