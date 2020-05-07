//
//  ViewController.swift
//  FunWithFlag
//
//  Created by Mahesh Prasad on 03/05/20.
//  Copyright © 2020 CreatesApp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK:- Outlet
    
    @IBOutlet weak var questionCounter: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var flagView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!

    let allQuestions = QuestionBank()
    var questionNumber: Int = 0
    var score: Int = 0
    var selectedAnswer: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateQuestion()
        updateUI()
    }


    @IBAction func answerPressed(_ sender: UIButton) {
        if sender.tag == selectedAnswer {
            print("correct")
            score += 1
        } else {
            print("wrong")
        }
        
        questionNumber += 1
        updateQuestion()
    }
    
    func updateQuestion() {
        
        
        if questionNumber <= allQuestions.list.count - 1 {
            
            flagView.image = UIImage(named: allQuestions.list[questionNumber].questionImage)
            questionLabel.text = allQuestions.list[questionNumber].question
            optionA.setTitle(allQuestions.list[questionNumber].optionA, for: .normal)
            optionB.setTitle(allQuestions.list[questionNumber].optionB, for: .normal)
            optionC.setTitle(allQuestions.list[questionNumber].optionC, for: .normal)
            optionD.setTitle(allQuestions.list[questionNumber].optionD, for: .normal)
            selectedAnswer = allQuestions.list[questionNumber].correctAnswer
            
        } else {
            let alert = UIAlertController(title: "Awesome", message: "End of Quiz. Do you want to start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (action) in
                self.restartQuiz()
            }
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
        
        updateUI()
    }
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        questionCounter.text = "\(questionNumber + 1)/ \(allQuestions.list.count)"
        progressView.frame.size.width = (view.frame.size.width / CGFloat(allQuestions.list.count))
        * CGFloat(questionNumber + 1)
    }
    
    func restartQuiz() {
        score = 0
        questionNumber = 0
        updateQuestion()
    }
}

