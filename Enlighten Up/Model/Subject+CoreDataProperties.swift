//
//  Subject+CoreDataProperties.swift
//  Enlighten Up
//
//  Created by Benjamin Prentiss on 2/6/23.
//
//

import Foundation
import CoreData


extension Subject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subject> {
        return NSFetchRequest<Subject>(entityName: "Subject")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var questions: NSSet?
    
    var theQuestions: [Question] {
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        request.predicate = NSPredicate(format: "subject = %@", self)
        do {
            return try NSPersistentContainer.shared.viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}

// MARK: Generated accessors for questions
extension Subject {

    @objc(addQuestionsObject:)
    @NSManaged public func addToQuestions(_ value: Question)

    @objc(removeQuestionsObject:)
    @NSManaged public func removeFromQuestions(_ value: Question)

    @objc(addQuestions:)
    @NSManaged public func addToQuestions(_ values: NSSet)

    @objc(removeQuestions:)
    @NSManaged public func removeFromQuestions(_ values: NSSet)

}

extension Subject : Identifiable {

}
