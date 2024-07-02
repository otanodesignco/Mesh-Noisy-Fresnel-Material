import { shaderMaterial } from "@react-three/drei"
import { extend, useFrame } from "@react-three/fiber"
import vertexShader from './shaders/vertex.glsl'
import fragmentShader from './shaders/fragment.glsl'
import { Color, DoubleSide } from "three"
import { useRef } from "react"

export default function MeshNoiseyFresnelMaterial({
    baseColor = '#a0b4fd', // base color
    glowColor = '#ffa360', // glow color for backface
    speedOffset = 2.00, // speed animation offset
    fresnelAmount = 1.00, // power factor for fresnel
    fresnelOffset = 0.02, // offset factor of fresnel
    fresnelColorIntensity = 1.25, // fresnel color brightness
    frenselBlend = 0.20, // blend of noise and fresnel
    noiseOffset = 5, // scale noise
})
{

    const self = useRef()

    const uniforms = {
        uTime: 0,
        uSpeedOffset: speedOffset,
        uBaseColor: new Color( baseColor ),
        uGlowColor: new Color( glowColor ),
        uFresnelAmount: fresnelAmount,
        uFresnelOffset: fresnelOffset,
        uFresnelIntensity: fresnelColorIntensity,
        uFrenselBlend: frenselBlend,
        uNoiseOffset: noiseOffset,
    }

    useFrame( ( state, delta ) =>
    {
        self.current.uniforms.uTime.value += delta
    })

    const MeshNoiseyFresnelMaterial = shaderMaterial( uniforms, vertexShader, fragmentShader )

    extend({ MeshNoiseyFresnelMaterial })

    return(
        <meshNoiseyFresnelMaterial
            key={ MeshNoiseyFresnelMaterial.key }
            ref={ self }
            side={ DoubleSide }
        />
    )
}