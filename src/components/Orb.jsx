import React, { useRef } from 'react'
import gsap  from 'gsap'
import MeshNoiseyFresnelMaterial from '../meshNoiseyFresnelMaterial.jsx'
import { useControls } from 'leva'
import useMouse from "../hooks/useMouse.jsx"
import { useFrame } from '@react-three/fiber'

function Orb( props ) 
{
    const self = useRef()
  
    const { x, y } = useMouse()
  
    const { colorBase, colorFresnel, noiseSpeed, noiseOffset, fresnelAmt, fresnelIntensity, fresnelBlend } = useControls({
      colorBase:
      {
          value: '#aa5939'
      }, 
      colorFresnel:
      {
          value: '#f2b717'
      }, 
      noiseSpeed:
      {
          value: 1.5,
          min: 0,
          max: 10,
          step: 0.001
      }, 
      noiseOffset:
      {
          value: 8.5,
          min: 1,
          max: 50,
          step: 0.001
      },
      fresnelAmt:
      {
          value: 4.00,
          min: 0,
          max: 10,
          step: 0.001
      }, 
      fresnelIntensity:
      {
          value: 1.25,
          min: 0,
          max: 10,
          step: 0.001
      },
      fresnelBlend:
      {
          value: 0.25,
          min: 0,
          max: 1,
          step: 0.001
      },
  })
  
  useFrame( ( state, delta ) =>
  {
      gsap.to( self.current.rotation, {
          x: gsap.utils.mapRange( 0, window.innerWidth, -.07, .07, y ),
          y: gsap.utils.mapRange( 0, window.innerHeight, -.07, .07, x )
        })
  } )
  
    return (
      <mesh ref={self} {...props}>
        <icosahedronGeometry args={[1.5, 16 ]} />
        <MeshNoiseyFresnelMaterial
            baseColor={ colorBase }
            glowColor={ colorFresnel }
            speedOffset={ noiseSpeed }
            fresnelAmount={ fresnelAmt }
            fresnelColorIntensity={ fresnelIntensity }
            noiseOffset={ noiseOffset }
            frenselBlend={ fresnelBlend }
        />
      </mesh>
    )
}

export default Orb