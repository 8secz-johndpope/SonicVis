//
//  testVC.swift
//  SonicVis
//
//  Created by yryang on 2019/3/21.
//  Copyright © 2019 ZJUVIS. All rights reserved.
//

import Foundation
import UIKit

class testVC: ViewController {
//    var player : PlayAudio
//    var view11 : DrawBarView
//    var view21 : DrawSunFlower
//    var view31 : DrawPieView
//    var view41 : DrawMapView
//
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        self.player = PlayAudio()
//        view11 = DrawBarView(frame: CGRect(x: 30, y: 30, width: 300, height: 250), player: self.player)
////        var view21 = DrawSunFlower(frame: CGRect(x: 30, y: 30, width: 300, height: 250), player: player)
////        var view31 = DrawPieView(frame: CGRect(x: 30, y: 30, width: 300, height: 250), player: player)
////        var view41 = DrawMapView(frame: CGRect(x: 30, y: 30, width: 300, height: 250), player: player)
//    }
//
    var player1 : PlayAudio = PlayAudio()
    var view11 : DrawBarView =  DrawBarView(frame: CGRect(x: 30, y: 30, width: 300, height: 250))
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.view.backgroundColor = UIColor.green
        self.view.addSubview(view11)
    }
    
}
