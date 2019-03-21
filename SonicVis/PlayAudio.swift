//
//  PlayAudio.swift
//  DrawPopUpBooks
//
//  Created by yryang on 2019/3/16.
//  Copyright © 2019 yryang. All rights reserved.
//

import AVFoundation

class PlayAudio {
    var player: AVAudioPlayer?
    init() {
        
    }
    func playAudio(audioName: String){
      
        let path = Bundle.main.path(forResource: audioName, ofType: "wav")
        let url = URL(fileURLWithPath: path ?? "")
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
