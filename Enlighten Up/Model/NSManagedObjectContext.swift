//
//  NSManagedObjectContext.swift
//  Enlighten Up
//
//  Created by Benjamin Prentiss on 2/6/23.
//

import CoreData


// MARK: - Extension
extension NSManagedObjectContext {
    
    var questions: [Question] {
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        do {
            return try fetch(request)
        } catch {
            print("Could not load data: \(error.localizedDescription)")
            return []
        }
    }
    
    /// Lets user save a new question that they created.
    /// - Parameters:
    ///   - text: Lets user save text to new question that they created.
    ///   - isTrueFalse: Lets user save true or false answer to new question that they created.
    ///   - subject: Lets you save a new question from a one to many relationship with that specidic subject.
    func saveQuestion(text: String, isTrueFalse: Bool, subject: Subject, question: Question? = nil) {
        let newQuestion = question ?? Question(context: self)
        newQuestion.text = text
        newQuestion.isTrueFalse = isTrueFalse
        newQuestion.id = UUID()
        newQuestion.timestamp = Date()
        subject.addToQuestions(newQuestion)
        saveState()
    }
}
