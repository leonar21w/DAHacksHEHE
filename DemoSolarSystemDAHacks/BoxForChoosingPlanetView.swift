import SwiftUI
import SceneKit

struct BoxForChoosingPlanetView: View {
	@State var celestialObject: String
	@State var typeOfView: String

	var body: some View {
		ZStack(alignment: .bottomLeading) {
			// 3D Earth background using SceneKit, clipped to a circular shape
			PlanetSceneView(typeofView: typeOfView)
				.frame(width: 150 , height: 150) // Set the size for the Earth
				.clipShape(Circle()) // Clip the SceneKit view to a circular shape
				.offset(x: 6, y: 35) // Position the Earth in the corner

			// Your original SwiftUI content
			Text(celestialObject)
				.font(.title)
				.fontWeight(.bold)
				.frame(width: 100, height: 100, alignment: .topLeading)
				.padding()
				.foregroundStyle(Color.white.opacity(0.8))
				.background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.2)))
		}
		.padding() // Optional: Add padding to the outer ZStack
	}
}

struct PlanetSceneView: UIViewRepresentable {
	@State var typeofView: String
	func makeUIView(context: Context) -> SCNView {
		let sceneView = SCNView()
		sceneView.scene = createEarthScene() // Configure the Earth scene
		sceneView.allowsCameraControl = true // Allow user interaction with the scene
		sceneView.backgroundColor = UIColor.clear // Transparent background
		return sceneView
	}
	
	func updateUIView(_ uiView: SCNView, context: Context) {}
	
	// Create a SceneKit scene with a 3D Earth
	func createEarthScene() -> SCNScene {
		let scene = SCNScene()
		
		// Add a 3D Earth node
		let earthNode = SCNNode(geometry: SCNSphere(radius: 1.0))
		let earthMaterial = SCNMaterial()
		earthMaterial.diffuse.contents = UIImage(named: typeofView) // Replace with your Earth texture image
		earthNode.geometry?.materials = [earthMaterial]
		scene.rootNode.addChildNode(earthNode)
		
		// Add a light source
		let lightNode = SCNNode()
		lightNode.light = SCNLight()
		lightNode.light?.type = .omni
		lightNode.light?.intensity = 1500
		lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
		scene.rootNode.addChildNode(lightNode)
		
		// Add a camera
		let cameraNode = SCNNode()
		cameraNode.camera = SCNCamera()
		cameraNode.position = SCNVector3(x: 0, y: 0, z: 5)
		scene.rootNode.addChildNode(cameraNode)
		
		return scene
	}
}

#Preview {
	BoxForChoosingPlanetView(celestialObject: "Earth", typeOfView: "earthTexture")
}

