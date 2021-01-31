//
//  NextViewController.swift
//  swift_tutorial_quiz
//
//  Created by 早川マイケル on 2021/01/30.
//

import UIKit

// maxScoreを返すデリゲート
protocol MaxScoreDelegate{
    func maxScore(maxScore:Int)
}

class NextViewController: UIViewController {

    // 正解数表示用ラベル
    @IBOutlet weak var correctLabel: UILabel!
    
    // 誤答数表示用ラベル
    @IBOutlet weak var wrongLabel: UILabel!

    // 正解数
    var correctedCount = Int()
    
    // 誤答数
    var wrongCount = Int()
    
    // 最高得点
    var maxCorrectedCount = Int()
    
    // 最高得点を返すデリゲート
    var delegate:MaxScoreDelegate?
    
    // 画面読み込み
    override func viewDidLoad() {
        super.viewDidLoad()

        // 正解数を更新
        correctLabel.text = String(correctedCount)
        
        // 誤答数を更新
        wrongLabel.text = String(wrongCount)

    }
    
    // 家ボタンが押された
    @IBAction func home(_ sender: Any) {
        // 最高得点更新
        if correctedCount > maxCorrectedCount{
            
            // 最高得点を保存
            UserDefaults.standard.set(correctedCount, forKey: "maxCount")
            
            // 最高得点を返す
            delegate?.maxScore(maxScore: correctedCount)
        }

        // 戻る
        dismiss(animated: true, completion: nil)
    }
}
