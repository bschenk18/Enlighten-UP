//
//  SubjectViewController.swift
//  Quiz Game
//
//  Created by Benjamin Prentiss on 1/29/23.
//

import UIKit
import CoreData

class CreateSubjectViewController: UIViewController{
    
    // MARK: - OUTLETS
    @IBOutlet var titleField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var cancelButton: UIBarButtonItem!
    
    // MARK: - PROPERTIES
    var subject: String? {
        titleField.text
    }
    
    // MARK: - Actions
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if titleField.text == "" {
            return
        }
        if let subject = subject {
            NSPersistentContainer.shared.viewContext.saveSubject(title: subject)
            print(NSPersistentContainer.shared.viewContext.subjects)
            navigationController?.popViewController(animated: true)
        } else {
            assertionFailure("Subject wasn't assigned a value")
        }
    }
    
}

// MARK: - Extension
extension NSManagedObjectContext {
    
    var subjects: [Subject] {
        let request: NSFetchRequest<Subject> = Subject.fetchRequest()
        do {
            return try fetch(request)
        } catch {
            print("Could not load data: \(error.localizedDescription)")
            return []
        }
    }
    
    /// Lets user save a subject.
    /// - Parameter title: Lets user create a title name of what subject they want to create.
    func saveSubject(title: String) {
        let newSubject = Subject(context: self)
        newSubject.title = title
        saveState()
    }
    
    /// Lets you save whatever you pass though saveState.
    func saveState() {
        if hasChanges {
            do {
                try save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error: \(error.localizedDescription), \(nsError.userInfo)")
            }
        }
    }
}
