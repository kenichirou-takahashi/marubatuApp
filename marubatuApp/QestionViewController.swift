//
//  QestionViewController.swift
//  marubatuApp
//
//  Created by 高橋健一郎 on 2021/02/05.
//

import UIKit

class QestionViewController: UIViewController,UITextFieldDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()

        questionField.delegate = self
    }
    
//    userが保存したときにいれる配列
    var questions:[[String:Any]] = []

    @IBOutlet var questionField: UITextField!
    
    
    @IBOutlet var marubatuController: UISegmentedControl!
    
    
    @IBAction func tapSaveButton(_ sender: Any) {
    
        if questionField.text != "" {
            
            var marubatuAnswer:Bool = true
            
            if marubatuController.selectedSegmentIndex == 0 {
                marubatuAnswer = true
            }else{
                marubatuAnswer = false
            }
//            userDefaults.standardをuserdefaultsに短縮
            let userDefaults = UserDefaults.standard
//            現在保存されている配列をquestionsに格納
            if userDefaults.object(forKey: "questions") != nil {
                questions = userDefaults.object(forKey: "questions") as! [[String: Any]]
            }
//            配列にアペンド
            questions.append(
                ["question" : questionField.text!,
                 "answer":marubatuAnswer
                ])
//            保存
            userDefaults.set(questions,forKey: "questions")
//            ユーザーにアラートを表示
            showAlert(message: "問題が保存されました！")
            
//            テキストフィールドの中を空にする
            questionField.text = ""
            print(questions)
        } else{
            showAlert(message: "問題を作成してください！")
        }
    }
    @IBAction func tapAllDeleate(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.object(forKey: "questions") != nil {
            
            userDefaults.removeObject(forKey: "questions")
            
            userDefaults.set([],forKey: "questions")
            
         //   print(questions)
            
            showAlert(message: "問題を全て削除しました。")
        }
        
        
    }
    
    
    @IBAction func tapBuckButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func showAlert(message : String){
        let alert = UIAlertController(title: "hoge", message: message, preferredStyle: .alert)
        
        let close = UIAlertAction(title: "閉じる", style: .cancel,handler:  nil)
        alert.addAction(close)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
