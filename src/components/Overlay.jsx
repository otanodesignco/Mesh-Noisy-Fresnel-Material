import gsap from "gsap"
import { useGSAP } from "@gsap/react"
import { useEffect } from "react"
import splitType from "split-type"

export default function Overlay( props )
{
    
    gsap.registerPlugin( useGSAP )

    useGSAP( () => 
    {
        const type = new splitType('.overlayTitle', { types: 'chars' })

        gsap.to('.char', 
        {
            opacity: 1,
            y: 0,
            duration: 0.4,
            stagger:
            {
                each: 0.1,
                from: 'start',
                ease: 'power2.inOut',
            }
        })

        gsap.to('.char',
            {
                opacity: 0,
                delay: 3,
                stagger:
                {
                    from: 'random',
                    each: 0.1,
                    ease: 'bounce.out'
                }
            }
        )

    }, [])

   
    return(
        <div className="overlayGrid">
            <h1 className="overlayTitle">Animated Fresnel</h1>
        </div>
    )
}