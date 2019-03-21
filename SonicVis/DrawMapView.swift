//
//  DrawMapView.swift
//  DrawPopUpBooks
//
//  Created by yryang on 2019/3/17.
//  Copyright © 2019 yryang. All rights reserved.
//

import UIKit
import Charts
import AVFoundation

class DrawMapView: UIView {
    override init(frame: CGRect) {
        let fr = CGRect(x: 30, y: 30, width: 100, height: 100)
        super.init(frame: fr)
        
    }
    var player = PlayAudio()
    
    func setPlayer(play: PlayAudio) {
        self.player = play
    }
    
    func draw(name: String) {
        switch name {
        case "AS":
            player.playAudio(audioName: "AS")
        case "EU":
            player.playAudio(audioName: "EU")
        case "AF":
            player.playAudio(audioName: "AF")
        case "NA":
            player.playAudio(audioName: "NA")
        case "SA":
            player.playAudio(audioName: "SA")
        case "OC":
            player.playAudio(audioName: "OC")
        default:
            print("no")
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
