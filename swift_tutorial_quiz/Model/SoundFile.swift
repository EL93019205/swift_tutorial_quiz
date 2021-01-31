//
//  SoundFile.swift
//  swift_tutorial_quiz
//
//  Created by 早川マイケル on 2021/01/31.
//

import Foundation
import AVFoundation

class SoundFile{
    
    var player:AVAudioPlayer?
    
    func playSound(fileName:String, extensionName:String){
        
        let soundURL = Bundle.main.url(forResource: fileName, withExtension: extensionName)
        
        do{
            // 効果音を鳴らす
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player?.play()
            
            
        }catch{
            print("can't play sound...")
            
        }
        
    }
    
    
}
