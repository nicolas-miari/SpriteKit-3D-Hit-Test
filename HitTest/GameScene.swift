//
//  GameScene.swift
//  HitTest
//
//  Created by Nicolás Miari on 2020/04/28.
//  Copyright © 2020 Nicolás Miari. All rights reserved.
//

import SpriteKit
import SceneKit

class GameScene: SKScene {

    let objectNode: SK3DNode

    override init(size: CGSize) {
        self.objectNode = SK3DNode(viewportSize: size)
        super.init(size: size)

        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        objectNode.scnScene = ObjectScene()
        self.addChild(objectNode)

        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        objectNode.pointOfView = cameraNode
        objectNode.pointOfView?.position = SCNVector3(x: 0, y: 0, z: 10)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: objectNode)

        let results = objectNode.hitTest(location, options: nil)

        print("Results: \(results.count)")
    }
}

class ObjectScene: SCNScene {

    override init() {
        super.init()
        let box = createSolidBox(side: 1, radius: 0.05, color: .red)
        let boxNode = SCNNode(geometry: box)
        self.rootNode.addChildNode(boxNode)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

func createSolidBox(side: CGFloat, radius: CGFloat, color: SKColor) -> SCNBox {
    let box = SCNBox(width: side, height: side, length: side, chamferRadius: radius)

    let material = SCNMaterial()
    material.diffuse.contents = color
    material.locksAmbientWithDiffuse = true
    box.materials = [SCNMaterial](repeating: material, count: 6)
    return box
}
