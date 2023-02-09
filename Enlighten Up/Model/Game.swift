//
//  Game.swift
//  Quiz Game
//
//  Created by Benjamin Prentiss on 1/31/23.
//

import CoreData

struct Game {
    
    // MARK: - PROPERTIES
    var questionNumber = 0
    var score = 0
    var subject: Subject
    var isComplete: Bool {
        print("Question number \(questionNumber) count \(subject.theQuestions.count) right: \(subject.theQuestions.count - 1) is complete: \(questionNumber >= subject.theQuestions.count - 1)")
        return questionNumber >= subject.theQuestions.count - 1
    }
    
    // MARK: - Functions
    /// Checks whether the user answers is correct, if it's correct it increments the score.
    /// - Parameter userAnswer: user answers are true or false.
    /// - Returns: whether the user answers the question or not.
    mutating func isCorrect(userAnswer: Bool) -> Bool {
        if subject.theQuestions[questionNumber].isTrueFalse == userAnswer {
            // When user put in the right answer
            score += 1
            return true
        } else {
            // When user put in the wrong answer
            return false
        }
        
    }
    
    /// Checks whether the user adds a question to the text.
    /// - Returns: whether the user adds a question to the text.
    func getQuestionText() -> String {
        return subject.theQuestions[questionNumber].text ?? ""
    }
    
    /// Shows the progress of the game from the current question they are on devided by the total count of questions made.
    /// - Returns: progress.
    func getProgress() -> Float {
        let progress = Float(questionNumber) / Float(subject.theQuestions.count)
        return progress
    }
    
    /// Makes user jump to next question in VC.
    mutating func nextQuestion() {
        questionNumber += 1
    }
}
