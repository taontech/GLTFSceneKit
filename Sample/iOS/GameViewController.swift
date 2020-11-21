//
//  GameViewController.swift
//  GLTFSceneKitSampler
//
//  Created by magicien on 2017/08/26.
//  Copyright © 2017年 DarkHorse. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import GLTFSceneKit

class GameViewController: UIViewController {
    var btn:UIButton = UIButton(frame: CGRect(x: 50,y: 50,width: 100,height: 40))
    var gameView: SCNView? {
        get { return self.view as? SCNView }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var scene: SCNScene
        do {
            let sceneSource = try GLTFSceneSource(url:
                                                    URL(string:"http://10.33.196.185:8080/outputs/models/2.glb")! )
            // URL(string:"http://10.33.196.182:8081/examples/models/gltf/DamagedHelmet/glTF/DamagedHelmet.gltf")! )
//            let sceneSource = try GLTFSceneSource(named: "art.scnassets/GlassVase/Wayfair-GlassVase-BCHH2364.glb")
            scene = try sceneSource.scene()
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {[self]
//                self.btnDown()
//            }
        } catch {
            print("\(error.localizedDescription)")
            return
        }
        
        self.setScene(scene)
        
        self.gameView!.autoenablesDefaultLighting = true
        
        // allows the user to manipulate the camera
        self.gameView!.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        self.gameView!.showsStatistics = true
        
        // configure the view
        self.gameView!.backgroundColor = UIColor.gray
        self.view.addSubview(self.btn)
        self.btn.addTarget(self, action: #selector(btnDown), for: .touchUpInside)
    }
    @objc func btnDown(){
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        var path = paths[0] + "/test.usdz"
        self.gameView!.scene!.write(to: URL(fileURLWithPath: path), options: nil, delegate: nil, progressHandler: nil)
    }
    func setScene(_ scene: SCNScene) {
        // set the scene to the view
        self.gameView!.scene = scene
        //to give nice reflections :)
        scene.lightingEnvironment.contents = "art.scnassets/shinyRoom.jpg"
        scene.lightingEnvironment.intensity = 2;
//        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//        var path = paths[0] + "/test.usdz"
//        scene.write(to: URL(fileURLWithPath: path), options: nil, delegate: nil, progressHandler: nil)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
