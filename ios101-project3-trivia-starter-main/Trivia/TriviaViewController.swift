//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Fakiya Imangaliyeva on 3/13/24.
//

import Foundation
import UIKit

class TriviaViewController: UIViewController {
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionTypeLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!

    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    

    private var questionList = [Question]()
    private var selectedQuestionIndex = 0
    private var correctAnswerCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        questionList = setupQuestions()
        configure(with: questionList[selectedQuestionIndex])
    }

    private func configure(with question: Question) {
        questionNumberLabel.text = "Question: \(selectedQuestionIndex + 1)/3"
        questionTypeLabel.text = question.type.description
        
        questionLabel.text = question.text
        questionLabel.numberOfLines = 0
        questionLabel.lineBreakMode = .byWordWrapping

        answerButton1.setTitle(question.answers[0].text, for: .normal)
        answerButton2.setTitle(question.answers[1].text, for: .normal)
        answerButton3.setTitle(question.answers[2].text, for: .normal)
        answerButton4.setTitle(question.answers[3].text, for: .normal)

        resetButtonColors()
    }

    private func checkAndUpdateUI(selectedAnswerIndex: Int) {
        guard selectedQuestionIndex < questionList.count else {
            showResult()
            return
        }

        let currentQuestion = questionList[selectedQuestionIndex]
        guard selectedAnswerIndex < currentQuestion.answers.count else {
            print("Invalid selected answer index.")
            return
        }

        let selectedAnswer = currentQuestion.answers[selectedAnswerIndex]

        let answerButtons: [UIButton] = [answerButton1, answerButton2, answerButton3, answerButton4]

        for (index, answerButton) in answerButtons.enumerated() {

            if index == selectedAnswerIndex {
                correctAnswerCount += selectedAnswer.correct ? 1 : 0
            }
        }

        selectedQuestionIndex += 1
        if selectedQuestionIndex < questionList.count {
            configure(with: questionList[selectedQuestionIndex])
        } else {
            showResult()
        }
    }


    @IBAction func answerSelected(_ sender: UIButton) {
        let selectedAnswerIndex: Int
        switch sender {
        case answerButton1: selectedAnswerIndex = 0
        case answerButton2: selectedAnswerIndex = 1
        case answerButton3: selectedAnswerIndex = 2
        case answerButton4: selectedAnswerIndex = 3
        default: return
        }

        checkAndUpdateUI(selectedAnswerIndex: selectedAnswerIndex)
    }

    private func showResult() {
        let message = "Number of correct answers: \(correctAnswerCount)/3"
        let alertController = UIAlertController(title: "Results", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    private func resetButtonColors() {
        [answerButton1, answerButton2, answerButton3, answerButton4].forEach { $0?.backgroundColor = UIColor.darkGray }
    }

    private func setupQuestions() -> [Question] {
        let mockData1 = Question(type: .Minerva, text: "When was Kazakh 10:01?", answers: [
            Answer(text: "21 february", correct: false),
            Answer(text: "1 march", correct: false),
            Answer(text: "21 january", correct: true),
            Answer(text: "21 december", correct: false)
        ])
        let mockData2 = Question(type: .Kazakhstan, text: "The most handsome guy", answers: [
            Answer(text: "Madiyar", correct: false),
            Answer(text: "Aldiyar", correct: true),
            Answer(text: "Batyrkhanchik", correct: false),
            Answer(text: "Islam", correct: false)
        ])
        let
        mockData3 = Question(type: .VIPKazakhstan, text: "Vip Kazakh", answers: [
                    Answer(text: "Batyrkhanchik", correct: true),
                    Answer(text: "Madiyar", correct: false),
                    Answer(text: "Aldiyar", correct: false),
                    Answer(text: "Atai", correct: false)
                ])
                return [mockData1, mockData2, mockData3]
            }
        }

        struct Question {
            let type: QuestionType
            let text: String
            let answers: [Answer]
        }

        enum QuestionType {
            case Minerva
            case Kazakhstan
            case VIPKazakhstan

            var description: String {
                switch self {
                case .Minerva:
                    return "Minerva"
                case .Kazakhstan:
                    return "Kazakhstan"
                case .VIPKazakhstan:
                    return "VIP Kazakhstan"
                }
            }
        }

        struct Answer {
            let text: String
            let correct: Bool
        }

        
