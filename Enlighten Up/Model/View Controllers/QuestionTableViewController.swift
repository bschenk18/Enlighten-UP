//
//  QuestionTableViewController.swift
//  Quiz Game
//
//  Created by Benjamin Prentiss on 1/30/23.
//

import UIKit
import CoreData

class QuestionTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    @IBOutlet var subjectsButton: UIBarButtonItem!
    @IBOutlet var questionTableView: UITableView!
    @IBOutlet var addQuestionButton: UIButton!
    
    // MARK: - Actions
    @IBAction func subjectsButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func playGameButtonTapped(_ sender: UIBarButtonItem) {
        guard let gameViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "GameViewController" ) as? GameViewController,
        let subject = subject,
        subject.theQuestions.count != 0 else { return }
        gameViewController.game = Game(subject: subject)
        navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    @IBAction func addQuestionButtonTap(_ sender: UIButton) {
        guard let editQuestionViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "EditQuestionViewController" ) as? EditQuestionViewController else { return }
        editQuestionViewController.subject = subject
        navigationController?.pushViewController(editQuestionViewController, animated: true)
    }
    
    // MARK: - Properties
    var subject: Subject?
    
    // MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        questionTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(NSPersistentContainer.shared.viewContext.questions)
        questionTableView.delegate = self
        questionTableView.dataSource = self
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let editQuestionViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "EditQuestionViewController") as? EditQuestionViewController else { return }
        editQuestionViewController.question = subject?.theQuestions[indexPath.row]
        editQuestionViewController.subject = subject
        navigationController?.pushViewController(editQuestionViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath)
        cell.textLabel?.text = "Q\(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subject?.theQuestions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            guard let question = self.subject?.theQuestions[indexPath.row] else { return }
            
            NSPersistentContainer.shared.viewContext.delete(question)
            NSPersistentContainer.shared.viewContext.saveState()
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
