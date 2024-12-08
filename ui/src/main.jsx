import { createRoot } from "react-dom/client"
import "./index.css"
import App from "./App.jsx"

// const domNode = document.getElementById("eolas-graph")
// const root = createRoot(domNode)

// root.render(<App />)

function initializeReactApp() {
   const domNode = document.getElementById("eolas-graph")
   if (!domNode) {
      console.error("Target container #eolas-graph not found")
      return
   }
   const root = createRoot(domNode)
   root.render(<App />)
}

document.addEventListener("DOMContentLoaded", initializeReactApp)
