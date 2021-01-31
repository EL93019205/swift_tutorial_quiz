//
//  WithOutMP3.swift
//  swift_tutorial_quiz
//
//  Created by 早川マイケル on 2021/01/31.
//

import Foundation

class WithOutMP3: SoundFile{
    
    override func playSound(fileName: String, extensionName: String) {
        if extensionName == "mp3"{
            print("このファイルは再生できません")
        }
        player?.stop()
    }
}
