//
//  ViewController.swift
//  swift_tutorial_quiz
//
//  Created by 早川マイケル on 2021/01/30.
//

import UIKit

class ViewController: UIViewController, MaxScoreDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var maxScoreLabel: UILabel!
    
    var correctCount = 0
    var wrongCount = 0
    var questionCount = 0
    var maxCorrectCount = 0
    
    // 問題データ
    let imagesList = ImagesList()
    
    // 選んだ回答
    var pickedAnswer = false
    
    // サウンド
    var soundFile = SoundFile()
    
    // 色変更クラス
    var changeColor = ChangeColor()
    var gradientLayer = CAGradientLayer()
        
    // 画面読み込み時に呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        // 最高得点を読み込む
        if UserDefaults.standard.object(forKey: "maxCount") != nil{
            maxCorrectCount = UserDefaults.standard.object(forKey: "maxCount") as! Int
            // 最高得点を表示するラベルを更新
            maxScoreLabel.text = String(maxCorrectCount)
        }
        
        // 画像の角を丸くする
        imageView.layer.cornerRadius = 20.0
        
        // グラデーションをかける
        gradientLayer = changeColor.changeColor(topR: 0.07, topG: 0.13, topB: 0.26, topAlpha: 1.0, bottomR: 0.54, bottomG: 0.74, bottomB: 0.74, bottomAlpha: 1.0)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // 遷移時に呼ばれる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 正答数初期化
        correctCount = 0
        
        // 誤答数初期化
        wrongCount = 0
        
        // 問題番号初期化
        questionCount = 0

        // 問題画像初期化
        imageView.image = UIImage(named: imagesList.list[0].imageText)

    }
    
    // OK/NG
    @IBAction func answer(_ sender: Any) {
        
        // ○ボタンが押された時
        if (sender as AnyObject).tag == 1{
            
            pickedAnswer = true

            // 効果音
            soundFile.playSound(fileName: "maruSound", extensionName: "mp3")

        }
        
        // ×ボタンが押された時
        else if (sender as AnyObject).tag == 2{
            
            pickedAnswer = false

            // 効果音
            soundFile.playSound(fileName: "batsuSound", extensionName: "mp3")
        }
        
        // チェック
        check()
        
        // 次の問題へ
        nextQuestions()
        
        
    }
    
    // 正誤チェック
    func check(){
        // 正解を取得
        let correctAnswer = imagesList.list[questionCount].answer
        
        // 正解
        if( pickedAnswer == correctAnswer )
        {
            correctCount += 1
        }
        // 不正解
        else
        {
            wrongCount += 1
        }
    }
    
    // 次の問題へ行く時
    func nextQuestions(){
        // 問題がまだ残っている
        if questionCount < imagesList.list.count - 1{
            // 問題番号を次のにする
            questionCount += 1
            
            // 次の問題の画像を表示
            imageView.image = UIImage(named: imagesList.list[questionCount].imageText)
        }
        
        // 終了
        else
        {
            // 画面遷移
            performSegue(withIdentifier: "next", sender: nil)
            
        }
    }
    
    // 次の画面へ
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            // 遷移先のデータ取得
            let nextVC = segue.destination as! NextViewController
            
            // 遷移先のデリゲートをセット
            nextVC.delegate = self
            
            // 正解数を渡す
            nextVC.correctedCount = correctCount

            // 最高得点を渡す
            nextVC.maxCorrectedCount = maxCorrectCount

            // 誤答数を渡す
            nextVC.wrongCount = wrongCount
        }
    }

    // 最高得点更新(デリゲートメソッド)
    func maxScore(maxScore: Int) {
        // 最高得点更新
        maxCorrectCount = maxScore
        
        // 最高得点を表示するラベルを更新
        maxScoreLabel.text = String(maxCorrectCount)

        // 効果音
        soundFile.playSound(fileName: "sound", extensionName: "mp3")
    }

}

