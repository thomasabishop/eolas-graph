import { useEffect } from "react"
import Graph from "graphology"
import { SigmaContainer, useLoadGraph, useSigma } from "@react-sigma/core"
import { useWorkerLayoutForceAtlas2 } from "@react-sigma/layout-forceatlas2"

import "./App.css"
import "@react-sigma/core/lib/react-sigma.min.css"

const sigmaStyle = {
   height: "100%",
   width: "100%",
}

const ForceAtlasLayout = () => {
   const { start, kill } = useWorkerLayoutForceAtlas2({
      settings: {
         //         iterations: 10,
         slowDown: 100,
         gravity: 0,
      },
   })

   useEffect(() => {
      start()
      return () => {
         kill()
      }
   }, [start, kill])

   return null
}

export const LoadGraph = () => {
   const loadGraph = useLoadGraph()

   useEffect(() => {
      const graph = new Graph()
      graph.addNode("A", {
         x: Math.random(),
         y: Math.random(),
         label: "Node A",
         size: 10,
         color: "red",
      })
      graph.addNode("B", {
         x: Math.random(),
         y: Math.random(),
         label: "Node B",
         size: 10,
      })
      graph.addNode("C", {
         x: Math.random(),
         y: Math.random(),
         label: "Node C",
         size: 10,
      })
      graph.addNode("D", {
         x: Math.random(),
         y: Math.random(),
         label: "Node D",
         size: 10,
      })
      graph.addNode("E", {
         x: Math.random(),
         y: Math.random(),
         label: "Node E",
         size: 10,
      })
      graph.addNode("F", {
         x: Math.random(),
         y: Math.random(),
         label: "Node F",
         size: 10,
      })

      graph.addEdge("A", "B", {})
      graph.addEdge("A", "C", {})
      graph.addEdge("A", "D", {})
      graph.addEdge("A", "E", {})
      graph.addEdge("A", "F", {})

      loadGraph(graph)
   }, [loadGraph])

   return null
}

export const App = () => {
   return (
      <div className="eolas-graph">
         <div className="graph-container">
            <SigmaContainer style={sigmaStyle}>
               <LoadGraph />
               <ForceAtlasLayout />
            </SigmaContainer>
         </div>
      </div>
   )
}

export default App
