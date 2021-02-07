//
//  ViewController.swift
//  marubatuApp
//
//  Created by 高橋健一郎 on 2021/02/04.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showQuestion()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
     
        questions = []
        
        let userDefalts = UserDefaults.standard
        if userDefalts.object(forKey: "questions") != nil {
            
            questions = userDefalts.object(forKey: "questions") as! [[String:Any]]
        }
        
        showQuestion()
    }
    
    
    @IBOutlet var questionLabel: UILabel!
    
    var currentQuestionNum = 0
    
    var questions : [[String:Any]] = []
//    let questions:[[String:Any]] = [    //anyはstringでもintでも何でもの意味
//        [
//            "question":"iphoneの開発環境はxcodeである",
//            "answer":true
//        ],
//        [
//            "question":"ライチは美味しい",
//            "answer":false
//        ],
//        [
//            "question":"私は世界一の開発者",
//            "answer":true
//        ]
//
//    ]

    func showQuestion(){
        
        
        
        if (questions.count > currentQuestionNum) {
            
            let question = questions[currentQuestionNum]
            
            if let que = question["question"] as? String{
                
//                問題文の表示
                questionLabel.text = que
                falseButton.isEnabled = true
                trueButton.isEnabled = true

            }
      
        }else {
            
            questionLabel.text = "問題を作ってください！"
            falseButton.isEnabled = false
            trueButton.isEnabled = false
            
        }
        
      
//        as? string はstringだったらの意味
    }
    
//    boolにはfalse or trueが入る
//    関数を使うときにcheckAnswer(userAnswer: false)で使用
    func checkAnswer(userAnswer:Bool){
        
        let question = questions[currentQuestionNum]
        if let ans = question["answer"] as? Bool {
           
            if userAnswer == ans{
//                正解
                currentQuestionNum += 1
                showAlert(message: "正解")
            } else {
//                不正解
                showAlert(message: "不正解")
            }
            
        }else{
            print("答えがありません")
            return
        }
        
        if currentQuestionNum >= questions.count {
            currentQuestionNum = 0
        }
//        問題の表示
//        正解だったら次の問題が表示される
//        不正解だったら、そのまま同じ問題が表示される
        showQuestion()
    }
    
    //tittle入れない場合はnil,入れる場合は"hoge"
    func showAlert(message : String){
        let alert = UIAlertController(title: "hoge", message: message, preferredStyle: .alert)
        
        let close = UIAlertAction(title: "閉じる", style: .cancel,handler:  nil)
        alert.addAction(close)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBOutlet var falseButton: UIButton!
    
    
    @IBOutlet var trueButton: UIButton!
    
    
    @IBAction func falseButton(_ sender: Any) {
        checkAnswer(userAnswer: false)
    }
  
    
    @IBAction func trueButton(_ sender: Any) {
        checkAnswer(userAnswer: true)
    }
    
    
    
}

