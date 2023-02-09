//
//  NSPersistentContainer.swift
//  Enlighten Up
//
//  Created by Benjamin Prentiss on 2/6/23.
//

import CoreData

// MARK: - Extension
extension NSPersistentContainer {
    static var shared: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Quiz_Game")
        container.loadPersistentStores { description, error in
            guard let error = error as? NSError else { return }
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
        return container
    }()
}
