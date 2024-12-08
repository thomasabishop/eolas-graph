import { createRoot } from "react-dom/client"
import App from "./App.jsx"

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
