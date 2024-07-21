import { Center, OrbitControls } from '@react-three/drei'
import Luma from './components/Luma.jsx'
import Orb from './components/Orb.jsx'

export default function Experience()
{

    return <>
        <Center>
            {/* <Luma scale={ 0.05 } /> */}
            <Orb />
        </Center>

    </>
}