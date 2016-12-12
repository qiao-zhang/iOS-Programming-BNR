//
//  ViewController.swift
//  Quiz
//
//  Created by Qiao Zhang on 12/12/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var questionLabelInUse: UILabel!
  @IBOutlet weak var questionLabelInWaiting: UILabel!
  @IBOutlet weak var answerLabel: UILabel!
  @IBOutlet weak var questionLabelInUseCenterXConstraint: NSLayoutConstraint!
  @IBOutlet weak var questionLabelInWaitingCenterXConstraint: NSLayoutConstraint!
  
  @IBAction func nextQuestionButtonTapped(_ sender: UIButton) {
    showQuestion()
  }
  
  @IBAction func showAnswerButtonTapped(_ sender: UIButton) {
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
  
  var currentQuestionIndex = -1 {
    didSet {
      answerLabel.isEnabled =
        0 <= currentQuestionIndex && currentQuestionIndex < answers.count
    }
  }
}


// MARK: - private methods
private extension ViewController {
  func showQuestion() {
    currentQuestionIndex += 1
    if currentQuestionIndex >= questions.count {
      currentQuestionIndex = 0
    }
    
    questionLabelInWaiting.text = questions[currentQuestionIndex]
    questionLabelInWaiting.alpha = 0
    answerLabel.text = "???"

    animateLabelTransitions()
  }
  
  func animateLabelTransitions() {
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: 0.7,
      initialSpringVelocity: 1,
      options: [.curveLinear],
      animations: {
        
        // animate alpha
        self.questionLabelInUse.alpha = 0
        self.questionLabelInWaiting.alpha = 1
        
        // animate position
        let screenWidth = self.view.frame.width
        self.questionLabelInWaitingCenterXConstraint.constant += screenWidth
        self.questionLabelInUseCenterXConstraint.constant += screenWidth
        self.view.layoutIfNeeded()
    }) { _ in
      swap(&self.questionLabelInUse, &self.questionLabelInWaiting)
      swap(&self.questionLabelInUseCenterXConstraint,
           &self.questionLabelInWaitingCenterXConstraint)
      self.relayout()
    }
  }
  
  func relayout() {
    let screenWidth = view.frame.width
    questionLabelInWaitingCenterXConstraint.constant = -screenWidth
    questionLabelInUseCenterXConstraint.constant = 0
    view.layoutIfNeeded()
  }

}


// MARK: - View Life Cycle
extension ViewController {
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    relayout()
    showQuestion()
  }
}
