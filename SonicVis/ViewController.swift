//
//  ViewController.swift
//  SonicVis
//
//  Created by 程浩然 on 2019/3/8.
//  Copyright © 2019 ZJUVIS. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var flag:Bool = true;
    var pageNumberInt = 0;
    var bookNode:SCNNode = SCNNode();
    var fArrowNode:SCNNode = SCNNode();
    var bArrowNode:SCNNode = SCNNode();
    var land:SCNNode = SCNNode();
    var x:Float = 0,y:Float = 0,z:Float = 0;
    var girlSize:[Int:CGFloat] = [1:0.01, 2:0.05, 3:0.01]
    var flowerSize:[Int:CGFloat] = [1:0.01, 2:0.01, 3:0.01]
    var view1 = DrawBarView(frame: CGRect(x: 30, y: 30, width: 300, height: 250))
    var view2 = DrawSunFlower(frame: CGRect(x: 30, y: 30, width: 300, height: 250))
    var view3 = DrawPieView(frame: CGRect(x: 30, y: 30, width: 300, height: 250))
    var view4 = DrawMapView(frame: CGRect(x: 30, y: 30, width: 300, height: 250))
//    var player = PlayAudio()
//    var flowerDraw:DrawSunFlower = DrawSunFlower(frame: CGRect(x: 30, y: 30, width: 300, height: 250))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        player.playAudio(audioName: "flower")
//        let view5 = DrawSunFlower(frame: CGRect(x: 1, y: 1, width: 1, height: 1))
//
//        self.view.addSubview(view5)
//        view5.draw()
        
                // Set the view's delegate
        sceneView.delegate = self
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/Book.scn")!
//        // Set the scene to the view
//        sceneView.scene = scene
        addTapGestureToSceneView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    //Click the Screen and Add the Book
    func  addTapGestureToSceneView() {
        let  tapGestureRecognizer  =  UITapGestureRecognizer(target:  self,  action:  #selector(ViewController.didTap(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func  didTap(withGestureRecognizer recognizer:  UIGestureRecognizer)  {
        if flag {
            let  tapLocation  =  recognizer.location(in:  sceneView)
            let  hitTestResultsWithFeaturePoints  =  sceneView.hitTest(tapLocation,  types:  .featurePoint)
            if  let  hitTestResultWithFeaturePoints  =  hitTestResultsWithFeaturePoints.first  {
                let  translation  =  hitTestResultWithFeaturePoints.worldTransform.translation
                x = translation.x
                y = translation.y
                z = translation.z
                addBookSubject()
                flag = false
            }
            return
        }
    }
    
    func createNode(width:CGFloat, height:CGFloat, image:String, xx:Float, yy:Float, zz:Float) -> SCNNode{
        let plane = SCNPlane(width: width, height: height)
        plane.firstMaterial?.diffuse.contents = UIImage(named: image)
        plane.firstMaterial?.lightingModel = .constant
        let node = SCNNode(geometry: plane)
        node.position = SCNVector3(xx,yy,zz)
        return node
    }
    
    func createHorizonNode(width:CGFloat, height:CGFloat, image:String, xx:Float, yy:Float, zz:Float) -> SCNNode{
        let plane = SCNPlane(width: width, height: height)
        plane.firstMaterial?.diffuse.contents = UIImage(named: image)
        plane.firstMaterial?.lightingModel = .constant
        let node = SCNNode(geometry: plane)
        node.transform = SCNMatrix4MakeRotation(Float(-.pi / 2.0), 1.0, 0.0, 0.0)
        node.position = SCNVector3(xx,yy,zz)
        return node
    }
    
    func addBookSubject(){
        //Binding Tap Gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAnyNode))
        sceneView.addGestureRecognizer(tap)
        
        //Add Empty Book
        var geo:SCNBox = SCNBox();
        var material:SCNMaterial = SCNMaterial();
        geo = SCNBox(width: 0.4, height: 0.03, length: 0.25, chamferRadius: 0.005)
        material = SCNMaterial();
        material.lightingModel = .lambert
        material.ambient.contents = UIColor.init(white:0.1, alpha:1)
        material.locksAmbientWithDiffuse = false
        material.lightingModel = .blinn
        material.specular.contents = UIColor.gray
        material.shininess = 1.0
        material.diffuse.contents = UIColor.white
        bookNode.geometry = geo
        bookNode.geometry?.materials = [material]
        bookNode.position = SCNVector3(x,y-0.03,z)
        bookNode.name = "Book"
        sceneView.scene.rootNode.addChildNode(bookNode)
        
        //Add Forward Arrow
        fArrowNode = createNode(width: 0.08, height: 0.05, image: "left-arrow.png", xx: x+0.2, yy: y+0.15, zz: z)
        sceneView.scene.rootNode.addChildNode(fArrowNode)
        //Add Backward Arrow
        bArrowNode = createNode(width: 0.08, height: 0.05, image: "right-arrow.png", xx: x-0.2, yy: y+0.15, zz: z)
        sceneView.scene.rootNode.addChildNode(bArrowNode)
        //Add Grassland
        land = createHorizonNode(width: 0.4, height: 0.25, image: "land.png", xx: x, yy: y-0.014, zz: z)
        sceneView.scene.rootNode.addChildNode(land)
        
        //Content page
        pageNumberInt = 0;
        showContentPage();
    }
    
    ////////////////0: Content Page////////////////////
    var C1Node:SCNNode = SCNNode();
    var C2Node:SCNNode = SCNNode();
    var C3Node:SCNNode = SCNNode();
    var C4Node:SCNNode = SCNNode();
    var titleNode:SCNNode = SCNNode();
    var deco_dog:SCNNode = SCNNode();
    var deco_bush:SCNNode = SCNNode()
    var deco_bird:SCNNode = SCNNode()
    var deco_flower:SCNNode = SCNNode()
    func showContentPage(){
        pageNumberInt = 0
        print("0-Show")
        //Add "1"
        C1Node = createNode(width: 0.06, height: 0.08, image: "1.png", xx: x-0.15, yy: y+0.03, zz: z-0.07)
        sceneView.scene.rootNode.addChildNode(C1Node)
        //Add "2"
        C2Node = createNode(width: 0.06, height: 0.08, image: "2.png", xx: x-0.07, yy: y+0.03, zz: z+0.07)
        sceneView.scene.rootNode.addChildNode(C2Node)
        //Add "3"
        C3Node = createNode(width: 0.06, height: 0.08, image: "3.png", xx: x+0.07, yy: y+0.03, zz: z-0.07)
        sceneView.scene.rootNode.addChildNode(C3Node)
        //Add "4"
        C4Node = createNode(width: 0.06, height: 0.08, image: "4.png", xx: x+0.15, yy: y+0.03, zz: z+0.07)
        sceneView.scene.rootNode.addChildNode(C4Node)
        //Add title
        titleNode = createNode(width: 0.12, height: 0.12, image: "title.png", xx: x, yy: y+0.2, zz: z)
        sceneView.scene.rootNode.addChildNode(titleNode)
        //Add deco_dog
        deco_dog = createNode(width: 0.2, height: 0.06, image: "CA-grassland.png", xx: x-0.08, yy: y+0.008, zz: z-0.075)
        sceneView.scene.rootNode.addChildNode(deco_dog)
        //Add deco_bush
        deco_bush = createNode(width: 0.03, height: 0.05, image: "CA-dog2.png", xx: x-0.1, yy: y+0.016, zz: z+0.085)
        sceneView.scene.rootNode.addChildNode(deco_bush)
        //Add deco_bird
        deco_bird = createNode(width: 0.05, height: 0.035, image: "CA-bird2.png", xx: x+0.095, yy: y+0.08, zz: z-0.06)
        sceneView.scene.rootNode.addChildNode(deco_bird)
        //Add deco_flower
        deco_flower = createNode(width: 0.05, height: 0.04, image: "flower.png", xx: x+0.13, yy: y+0.008, zz: z+0.072)
        sceneView.scene.rootNode.addChildNode(deco_flower)
    }
    func removeContentPage(){
        print("0-Remove")
        C1Node.removeFromParentNode()
        C2Node.removeFromParentNode()
        C3Node.removeFromParentNode()
        C4Node.removeFromParentNode()
        titleNode.removeFromParentNode()
        deco_flower.removeFromParentNode()
        deco_bird.removeFromParentNode()
        deco_dog.removeFromParentNode()
        deco_bush.removeFromParentNode()
    }
    
    ////////////////1: Animal Page////////////////////
    var animalCount = 17
    var fieldNode:SCNNode = SCNNode()
    var hillNode:SCNNode = SCNNode()
    var skyNode:SCNNode = SCNNode()
    var grasslandNode:SCNNode = SCNNode()
    var houseNode:SCNNode = SCNNode()
    var sheepNode:[Int:SCNNode] = [1:SCNNode(), 2:SCNNode()]
    var chickNode:[Int:SCNNode] = [1:SCNNode(), 2:SCNNode(), 3:SCNNode()]
    var birdNode:[Int:SCNNode] = [1:SCNNode(), 2:SCNNode(), 3:SCNNode(), 4:SCNNode(), 5:SCNNode(), 6:SCNNode()]
    var duckNode:[Int:SCNNode] =  [1:SCNNode(), 2:SCNNode(), 3:SCNNode(), 4:SCNNode()]
    var dogNode:[Int:SCNNode] =  [1:SCNNode(), 2:SCNNode()]
    func showAnimalPage(){
        pageNumberInt = 1
        print("1-Show")
        //Add hill
        hillNode = createNode(width: 0.20, height: 0.06, image: "CA-mountain.png", xx: x-0.1, yy: y, zz: z-0.095 )
        sceneView.scene.rootNode.addChildNode(hillNode)
        //Add filed
        fieldNode = createHorizonNode(width: 0.12, height: 0.09, image: "CA-field.png", xx: x-0.1, yy: y, zz: z+0.07)
        sceneView.scene.rootNode.addChildNode(fieldNode)
        //Add sky
        skyNode = createNode(width: 0.06, height: 0.04, image: "CA-cloud.png", xx: x+0.05, yy: y+0.16, zz: z-0.07)
        sceneView.scene.rootNode.addChildNode(skyNode)
        //Add grassland
        grasslandNode = createNode(width: 0.17, height: 0.05, image: "CA-grassland.png", xx: x+0.1, yy: y+0.008, zz: z+0.07)
        sceneView.scene.rootNode.addChildNode(grasslandNode)
        //Add house
        houseNode = createNode(width: 0.23, height: 0.1, image: "CA-house.png", xx: x+0.05, yy: y+0.016, zz: z-0.07)
        sceneView.scene.rootNode.addChildNode(houseNode)
        //Add sheep
        sheepNode[1] = createNode(width: 0.04, height: 0.06, image: "CA-sheep.png", xx: x-0.15, yy: y+0.02, zz: z-0.06)
        sceneView.scene.rootNode.addChildNode(sheepNode[1]!)
        sheepNode[2] = createNode(width: 0.06, height: 0.09, image: "CA-sheep.png", xx: x-0.1, yy: y+0.03, zz: z-0.05)
        sceneView.scene.rootNode.addChildNode(sheepNode[2]!)
        //Add chick
        chickNode[1] = createNode(width: 0.015, height: 0.01, image: "CA-chick1.png", xx: x-0.14, yy: y+0.006, zz: z+0.09)
        sceneView.scene.rootNode.addChildNode(chickNode[1]!)
        chickNode[2] = createNode(width: 0.015, height: 0.015, image: "CA-chick3.png", xx: x-0.12, yy: y+0.006, zz: z+0.05)
        sceneView.scene.rootNode.addChildNode(chickNode[2]!)
        chickNode[3] = createNode(width: 0.015, height: 0.015, image: "CA-chick2.png", xx: x-0.1, yy: y+0.006, zz: z+0.07)
        sceneView.scene.rootNode.addChildNode(chickNode[3]!)
        //Add bird
        birdNode[1] = createNode(width: 0.02, height: 0.012, image: "CA-bird2", xx: x, yy: y+0.2, zz: z-0.1)
        sceneView.scene.rootNode.addChildNode(birdNode[1]!)
        birdNode[2] = createNode(width: 0.03, height: 0.02, image: "CA-bird2", xx: x-0.1, yy: y+0.12, zz: z-0.05)
        sceneView.scene.rootNode.addChildNode(birdNode[2]!)
        birdNode[3] = createNode(width: 0.03, height: 0.02, image: "CA-bird2", xx: x+0.06, yy: y+0.16, zz: z-0.06)
        sceneView.scene.rootNode.addChildNode(birdNode[3]!)
        birdNode[4] = createNode(width: 0.03, height: 0.02, image: "CA-bird2", xx: x+0.1, yy: y+0.14, zz: z-0.01)
        sceneView.scene.rootNode.addChildNode(birdNode[4]!)
        birdNode[5] = createNode(width: 0.03, height: 0.02, image: "CA-bird2", xx: x-0.04, yy: y+0.15, zz: z-0.06)
        sceneView.scene.rootNode.addChildNode(birdNode[5]!)
        birdNode[6] = createNode(width: 0.02, height: 0.012, image: "CA-bird2", xx: x-0.06, yy: y+0.18, zz: z-0.1)
        sceneView.scene.rootNode.addChildNode(birdNode[6]!)
        //Add duck
        duckNode[1] = createNode(width: 0.05, height: 0.03, image: "CA-rabbit1", xx: x+0.14, yy: y+0.01, zz: z+0.09)
        sceneView.scene.rootNode.addChildNode(duckNode[1]!)
        duckNode[2] = createNode(width: 0.05, height: 0.03, image: "CA-rabbit2", xx: x+0.1, yy: y+0.01, zz: z+0.12)
        sceneView.scene.rootNode.addChildNode(duckNode[2]!)
        duckNode[3] = createNode(width: 0.03, height: 0.02, image: "CA-rabbit1", xx: x+0.06, yy: y+0.01, zz: z+0.08)
        sceneView.scene.rootNode.addChildNode(duckNode[3]!)
        duckNode[4] = createNode(width: 0.03, height: 0.02, image: "CA-rabbit2", xx: x+0.02, yy: y+0.01, zz: z+0.1)
        sceneView.scene.rootNode.addChildNode(duckNode[4]!)
        //Add dog
        dogNode[1] = createNode(width: 0.07, height: 0.035, image: "CA-dog1", xx: x+0.13, yy: y+0.01, zz: z-0.06)
        sceneView.scene.rootNode.addChildNode(dogNode[1]!)
        dogNode[2] = createNode(width: 0.05, height: 0.025, image: "CA-dog1", xx: x+0.03, yy: y+0.01, zz: z-0.02)
        sceneView.scene.rootNode.addChildNode(dogNode[2]!)
        //chart view
        sceneView.addSubview(view1)
        sceneView.bringSubviewToFront(view1)
    }
    func removeAnmialPage(){
        print("1-Remove")
        hillNode.removeFromParentNode()
        fieldNode.removeFromParentNode()
        skyNode.removeFromParentNode()
        grasslandNode.removeFromParentNode()
        houseNode.removeFromParentNode()
        for i in 1..<3 { sheepNode[i]!.removeFromParentNode() }
        for i in 1..<4 { chickNode[i]!.removeFromParentNode() }
        for i in 1..<7 { birdNode[i]!.removeFromParentNode() }
        for i in 1..<5 { duckNode[i]!.removeFromParentNode() }
        for i in 1..<3 { dogNode[i]!.removeFromParentNode() }
        view1.removeFromSuperview()
    }
    
    ////////////////2: Sunflower Page////////////////////
    var girlNode:SCNNode = SCNNode()
    var flowerNode:SCNNode = SCNNode()
    var deco_house:SCNNode = SCNNode()
    var dayCount = 0;
    func showSunflowerPage(){
        pageNumberInt = 2
        print("2-Show")
        girlNode = createNode(width: 0.14, height: 0.16, image: "Sunflower-girl.png", xx: x-0.06, yy: y+0.03, zz: z+0.03)
        sceneView.scene.rootNode.addChildNode(girlNode)
        dayCount = 0;
        flowerNode = createNode(width: 0.07, height: 0.3, image: "SF-1", xx: x+0.02, yy: y+0.15, zz: z+0.03)
        sceneView.scene.rootNode.addChildNode(flowerNode)
        deco_house = createNode(width: 0.23, height: 0.1, image: "CA-house.png", xx: x+0.08, yy: y+0.016, zz: z-0.07)
        sceneView.scene.rootNode.addChildNode(deco_house)
        view2.draw(1)
        //chart view
        sceneView.addSubview(view2)
        sceneView.bringSubviewToFront(view2)
        
    }
    func removeSunflowerPage(){
        print("2-Remove")
        girlNode.removeFromParentNode()
        flowerNode.removeFromParentNode()
        deco_house.removeFromParentNode()
       view2.removeFromSuperview()
    }
    
    ////////////////3: Sports Page////////////////////
    var indoorNode:SCNNode = SCNNode()
    var outdoorNode:SCNNode = SCNNode()
    var badmintonNode:SCNNode = SCNNode()
    var baseballNode:SCNNode = SCNNode()
    var chessNode:SCNNode = SCNNode()
    var tabletennisNode:SCNNode = SCNNode()
    func showSportsPage(){
        pageNumberInt = 3
        print("3-Show")
        indoorNode = createNode(width: 0.1, height: 0.1, image: "Sports-indoor.png", xx: x-0.1, yy: y+0.04, zz: z-0.05)
        sceneView.scene.rootNode.addChildNode(indoorNode)
        outdoorNode = createNode(width: 0.12, height: 0.1, image: "Sports-outdoor.png", xx: x+0.1, yy: y+0.04, zz: z-0.05)
        sceneView.scene.rootNode.addChildNode(outdoorNode)
        badmintonNode = createNode(width: 0.08, height: 0.067, image: "Sports-badminton.png", xx: x+0.05, yy: y+0.03, zz: z+0.05)
        sceneView.scene.rootNode.addChildNode(badmintonNode)
        baseballNode = createNode(width: 0.05, height: 0.06, image: "Sports-baseball.png", xx: x+0.1, yy: y+0.03, zz: z+0.1)
        sceneView.scene.rootNode.addChildNode(baseballNode)
        chessNode = createNode(width: 0.08, height: 0.06, image: "Sports-chess.png", xx: x-0.06, yy: y+0.03, zz: z-0.01)
        sceneView.scene.rootNode.addChildNode(chessNode)
        tabletennisNode = createNode(width: 0.08, height: 0.06, image: "Sports-tabletennis.png", xx: x-0.12, yy: y+0.03, zz: z+0.1)
        sceneView.scene.rootNode.addChildNode(tabletennisNode)
        //chart view
        sceneView.addSubview(view3)
        sceneView.bringSubviewToFront(view3)
        view3.begin()
    }
    func removeSportsPage(){
        print("3-Remove")
        indoorNode.removeFromParentNode()
        outdoorNode.removeFromParentNode()
        badmintonNode.removeFromParentNode()
        baseballNode.removeFromParentNode()
        chessNode.removeFromParentNode()
        tabletennisNode.removeFromParentNode()
        view3.removeFromSuperview()
    }
    
    ////////////////4: Map Page////////////////////
    var bigMapNode:SCNNode = SCNNode()
    var asiaNode:SCNNode = SCNNode()
    var euNode:SCNNode = SCNNode()
    var africaNode:SCNNode = SCNNode()
    var ocNode:SCNNode = SCNNode()
    var naNode:SCNNode = SCNNode()
    var saNode:SCNNode = SCNNode()
    var show_asiaNode:SCNNode = SCNNode()
    var show_euNode:SCNNode = SCNNode()
    var show_africaNode:SCNNode = SCNNode()
    var show_ocNode:SCNNode = SCNNode()
    var show_naNode:SCNNode = SCNNode()
    var show_saNode:SCNNode = SCNNode()
    func showMapPage(){
        pageNumberInt = 4
        print("4-Show")
        bigMapNode = createHorizonNode(width: 0.4, height: 0.25, image: "map.png", xx: x, yy: y-0.012, zz: z)
        sceneView.scene.rootNode.addChildNode(bigMapNode)
        asiaNode = createHorizonNode(width: 0.18, height: 0.12, image: "map-asia.png", xx: x+0.085, yy: y-0.01, zz: z-0.0205)
        sceneView.scene.rootNode.addChildNode(asiaNode)
        euNode = createHorizonNode(width: 0.075, height: 0.044, image: "map-eu.png", xx: x-0.012, yy: y-0.01, zz: z-0.048)
        sceneView.scene.rootNode.addChildNode(euNode)
        africaNode = createHorizonNode(width: 0.098, height: 0.1, image: "map-africa.png", xx: x-0.002, yy: y-0.01, zz: z+0.021)
        sceneView.scene.rootNode.addChildNode(africaNode)
        naNode = createHorizonNode(width: 0.16, height: 0.098, image: "map-na.png", xx: x-0.113, yy: y-0.01, zz: z-0.034)
        sceneView.scene.rootNode.addChildNode(naNode)
        saNode = createHorizonNode(width: 0.07, height: 0.09, image: "map-sa.png", xx: x-0.105, yy: y-0.01, zz: z+0.049)
        sceneView.scene.rootNode.addChildNode(saNode)
        ocNode = createHorizonNode(width: 0.072, height: 0.062, image: "map-oce.png", xx: x+0.159, yy: y-0.01, zz: z+0.06)
        sceneView.scene.rootNode.addChildNode(ocNode)
        //chart view
        sceneView.addSubview(view4)
        sceneView.bringSubviewToFront(view4)
    }
    func removeMapPage(){
        print("4-Remove")
        bigMapNode.removeFromParentNode()
        asiaNode.removeFromParentNode()
        euNode.removeFromParentNode()
        africaNode.removeFromParentNode()
        ocNode.removeFromParentNode()
        naNode.removeFromParentNode()
        saNode.removeFromParentNode()
        removeShowPage()
        view4.removeFromSuperview()
    }
    func removeShowPage(){
        show_asiaNode.removeFromParentNode()
        show_euNode.removeFromParentNode()
        show_africaNode.removeFromParentNode()
        show_ocNode.removeFromParentNode()
        show_naNode.removeFromParentNode()
        show_saNode.removeFromParentNode()
    }
    
    ////////////////Handle Tap////////////////////
    @objc func tapAnyNode( withGestureRecognizer recognizer: UITapGestureRecognizer){
        let  tapLocation  =  recognizer.location(in:  sceneView)
        let  hitTestResults  =  sceneView.hitTest(tapLocation)
        let  node = hitTestResults.first?.node
        
        if (node == fArrowNode){
            if (pageNumberInt<4) {
                pageNumberInt = pageNumberInt+1
                switch pageNumberInt{
                case 1:
                    removeContentPage()
                    showAnimalPage()
                    animalCount = 17
                case 2:
                    removeAnmialPage()
                    showSunflowerPage()
                case 3:
                    removeSunflowerPage()
                    showSportsPage()
                case 4:
                    removeSportsPage()
                    showMapPage()
                default:
                    print("")
                }
            }
            
        } else if (node == bArrowNode){
            if (pageNumberInt>0){
                pageNumberInt = pageNumberInt-1
                switch pageNumberInt{
                case 0:
                    removeAnmialPage()
                    showContentPage()
                case 1:
                    removeSunflowerPage()
                    showAnimalPage()
                    animalCount = 17
                case 2:
                    removeSportsPage()
                    showSunflowerPage()
                case 3:
                    removeMapPage()
                    showSportsPage()
                default:
                    print("")
                }
            }
        } else{
            switch pageNumberInt {
            case 0:
                if (node == C1Node){
                    removeContentPage()
                    pageNumberInt = 1
                    showAnimalPage()
                } else if (node == C2Node){
                    removeContentPage()
                    pageNumberInt = 2
                    showSunflowerPage()
                } else if (node == C3Node){
                    removeContentPage()
                    pageNumberInt = 3
                    showSportsPage()
                } else if (node == C4Node){
                    removeContentPage()
                    pageNumberInt = 4
                    showMapPage()
                }
            case 1:
                if (animalCount == 0){
                    view1.finish()
                    print("CA_finish")
                }
                if (node==birdNode[1] || node==birdNode[2] || node == birdNode[3] || node == birdNode[4] || node == birdNode[5] || node == birdNode[6] ){
                    node?.removeFromParentNode()
                    animalCount = animalCount - 1
                    print(animalCount)
                    view1.draw(name:"Bird")
                }
                if (node==sheepNode[1] || node==sheepNode[2] ){
                    node?.removeFromParentNode()
                    animalCount = animalCount - 1
                    print(animalCount)
                    view1.draw(name:"Sheep")
                }
                if (node==chickNode[1] || node==chickNode[2] || node == chickNode[3] ){
                    node?.removeFromParentNode()
                    animalCount = animalCount - 1
                    print(animalCount)
                    view1.draw(name:"Chick")
                }
                if (node==duckNode[1] || node==duckNode[2] || node == duckNode[3] || node == duckNode[4] ){
                    node?.removeFromParentNode()
                    animalCount = animalCount - 1
                    print(animalCount)
                    view1.draw(name:"Duck")
                }
                if (node==dogNode[1] || node==dogNode[2] ){
                    node?.removeFromParentNode()
                    animalCount = animalCount - 1
                    print(animalCount)
                    view1.draw(name:"Dog")
                }
            case 2:
                handleTap_Sunflower()
            case 3:
                if (node == baseballNode) {
                    print(1)
                    view3.draw(name:"Baseball")
                }
                else if (node == badmintonNode) {
                    print(2)
                    view3.draw(name:"Badminton")
                }
                else if (node == tabletennisNode) {
                    print(3)
                    view3.draw(name:"Tabletennis")
                }
                else if (node == chessNode) {
                    print(4)
                    view3.draw(name:"Chess")
                }
                else {
                    print(5)
                    view3.finish()
                }
            case 4:
                if (node == asiaNode) { handleTap_Map(MapID:1) }
                if (node == africaNode) { handleTap_Map(MapID:2) }
                if (node == euNode) { handleTap_Map(MapID:3) }
                if (node == ocNode) { handleTap_Map(MapID:4) }
                if (node == naNode) { handleTap_Map(MapID:5) }
                if (node == saNode) { handleTap_Map(MapID:6) }
            default:
                print("")
            }
        }
        
    }
    
    //Sunflower_Tap
    var height:[Int:CGFloat] = [0:0, 1:0.01, 2:0.02, 3:0.05, 4:0.14, 5:0.21, 6:0.23, 7:0.24, 8:0.25]
    var growing:Float = 1;
    func handleTap_Sunflower(){
        if (dayCount<8) {
            dayCount=dayCount+1;
            flowerNode.removeFromParentNode()
            let img = "SF-" + String(dayCount+1)+".png"
            flowerNode = createNode(width: 0.07, height: 0.3, image: img, xx: x+0.02, yy: y+0.15, zz: z+0.03)
            sceneView.scene.rootNode.addChildNode(flowerNode)
            view2.draw(dayCount+1)
            print(dayCount)
        } else {
            view2.finish()
        }
    }
    
    //Map_Tap
    func handleTap_Map(MapID:Int){
        removeShowPage()
        switch MapID { //asia-afr-eu-oc-na-sa
        case 1:
            show_asiaNode = createNode(width: 0.18, height: 0.18, image: "show-asia.png", xx: x, yy: y+0.18, zz: z)
            sceneView.scene.rootNode.addChildNode(show_asiaNode)
            view4.draw(name:"AS")
        case 2:
            show_africaNode = createNode(width: 0.18, height: 0.18, image: "show-africa.png", xx: x, yy: y+0.18, zz: z)
            sceneView.scene.rootNode.addChildNode(show_africaNode)
            view4.draw(name:"AF")
        case 3:
            show_euNode =  createNode(width: 0.18, height: 0.18, image: "show-eu.png", xx: x, yy: y+0.18, zz: z)
            sceneView.scene.rootNode.addChildNode(show_euNode)
            view4.draw(name:"EU")
        case 4:
            show_ocNode =  createNode(width: 0.18, height: 0.18, image: "show-oce.png", xx: x, yy: y+0.18, zz: z)
            sceneView.scene.rootNode.addChildNode(show_ocNode)
            view4.draw(name:"OC")
        case 5:
            show_naNode =  createNode(width: 0.18, height: 0.18, image: "show-na.png", xx: x, yy: y+0.18, zz: z)
            sceneView.scene.rootNode.addChildNode(show_naNode)
            view4.draw(name:"NA")
        case 6:
            show_saNode =  createNode(width: 0.18, height: 0.18, image: "show-sa.png", xx: x, yy: y+0.18, zz: z)
            sceneView.scene.rootNode.addChildNode(show_saNode)
            view4.draw(name:"SA")
        default:
            print("")
        }
        
    }
    
}

extension  float4x4  {
    var  translation: float3  {
        let  translation  =  self.columns.3
        return  float3(translation.x,  translation.y,  translation.z)
    }
}
