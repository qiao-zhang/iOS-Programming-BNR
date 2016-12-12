//
//  ViewController.swift
//  Quiz
//
//  Created by Qiao Zhang on 12/12/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var answerLabel: UILabel!
  
  @IBAction func showNextQuestion(_ sender: UIButton) {
    currentQuestionIndex += 1
    if currentQuestionIndex == questions.count { currentQuestionIndex = 0 }
    showQuestion()
  }
  
  @IBAction func showAnswer(_ sender: UIButton) {
    let answer = answers[currentQuestionIndex]
    answerLabel.text = answer
  }
  
  let questions = [
    NSLocalizedString("What is 7 + 7?", comment: "7+7"),
    NSLocalizedString("What is the capital of Vermont?",
                      comment: "capital of Vermont"),
    NSLocalizedString("What is cognac made from?", comment: "cognac")
  ]
  
  let answers = [
    NSLocalizedString("14", comment: "answer to 7+7"),
    NSLocalizedString("Montpelier", comment: "answer to captital of Vermont"),
    NSLocalizedString("Grapes", comment: "answer to cognac")
  ]
  
  var currentQuestionIndex = 0
}


// MARK: - private methods
private extension ViewController {
  func showQuestion() {
    questionLabel.text = questions[currentQuestionIndex]
    answerLabel.text = "???"
  }
}


// MARK: - View Life Cycle
extension ViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    showQuestion()
  }
}
