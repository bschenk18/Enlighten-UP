//
//  QuestionEditViewController.swift
//  Quiz Game
//
//  Created by Benjamin Prentiss on 1/30/23.
//

import UIKit
import CoreData

class EditQuestionViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var questionsButton: UIBarButtonItem!
    @IBOutlet var questionTextView: UITextView!
    @IBOutlet var isTrueFalseSegmentedControl: UISegmentedControl!
    @IBOutlet var deleteQuestionButton: UIButton!
    
    // MARK: - Properties
    var question: Question?
    var subject: Subject?
    var questionTextViewText: String? {
        questionTextView.text
    }
    
    // MARK: - Actions
    @IBAction func isTrueFalseSegmentedControlSwithced(_ sender: UISegmentedControl) {
        question?.isTrueFalse = sender.selectedSegmentIndex == 0
    }
    
    @IBAction func questionsButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteQuestionButtonTapped(_ sender: UIBarButtonItem) {
        guard let question = question else { return }
        NSPersistentContainer.shared.viewContext.delete(question)
        NSPersistentContainer.shared.viewContext.saveState()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let subject = subject else { return }
        if let question = question {
            if let text = questionTextView.text {
                // edit question there is text
                NSPersistentContainer.shared.viewContext.saveQuestion(
                    text: text,
                    isTrueFalse: isTrueFalseSegmentedControl.selectedSegmentIndex == 0,
                    subject: subject,
                    question: question
                )
            } else {
                // delete question there is no text
                NSPersistentContainer.shared.viewContext.delete(question)
            }
            
        } else {
            
            if let text = questionTextViewText {
                NSPersistentContainer.shared.viewContext.saveQuestion(
                    text: text,
                    isTrueFalse: isTrueFalseSegmentedControl.selectedSegmentIndex == 0,
                    subject: subject
                )
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextView.text = question?.text
        isTrueFalseSegmentedControl.selectedSegmentIndex = question?.isTrueFalse != false ? 0 : 1
        print(NSPersistentContainer.shared.viewContext.questions)
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isTrueFalseSegmentedControl.selectedSegmentIndex = question?.isTrueFalse != false ? 0 : 1
        print(NSPersistentContainer.shared.viewContext.questions)
    }

}
