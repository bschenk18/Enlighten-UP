//
//  Question+CoreDataProperties.swift
//  Enlighten Up
//
//  Created by Benjamin Prentiss on 2/6/23.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isTrueFalse: Bool
    @NSManaged public var text: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var subject: Subject?

}

extension Question : Identifiable {

}
