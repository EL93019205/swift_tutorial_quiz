//
//  ImagesModel.swift
//  swift_tutorial_quiz
//
//  Created by 早川マイケル on 2021/01/30.
//

import Foundation

class ImagesModel{
    // 画像名を取得し、その画像名が人間かそうでないかをフラグによって判定するための機能
    let imageText:String
    let answer:Bool
    
    // 初期化
    init(imageName:String, correctOrNot:Bool){
        imageText = imageName
        answer = correctOrNot
    }
}
