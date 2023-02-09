//
//  ResultsTableViewController.swift
//  Enlighten Up
//
//  Created by Benjamin Prentiss on 2/5/23.
//

import UIKit
import CoreData

class ResultsTableViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var subjectsHomeButton: UIBarButtonItem!
    @IBOutlet var scoreResultsLabel: UILabel!
    
    // MARK: - Actions
    @IBAction func subjectsHomeButtonTapped(_ sender: UIBarButtonItem) {
        let subjectTableViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "SubjectTableViewController" )
        navigationController?.pushViewController(subjectTableViewController, animated: true)    }
    
    // MARK: - Properties
    var questions: [Question] {
        NSPersistentContainer.shared.viewContext.questions
    }
    
    var game: Game?
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        print(NSPersistentContainer.shared.viewContext.questions)
    }
    
    // MARK: - Functions
    @objc func updateUI() {
        guard let game = game else { return }
        scoreResultsLabel.text = "\(game.score) / \(game.subject.theQuestions.count)"
    }
}
