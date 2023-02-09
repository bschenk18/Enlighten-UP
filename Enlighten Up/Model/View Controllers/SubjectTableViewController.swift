//
//  SubjectTableViewController.swift
//  Quiz Game
//
//  Created by Benjamin Prentiss on 1/29/23.
//

import UIKit
import CoreData

class SubjectTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Outlets
    @IBOutlet var subjectTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    // MARK: - Actions
    @IBAction func plusButtonTapped(_ sender: UIBarButtonItem) {
        let subjectViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "SubjectViewController" )
        navigationController?.pushViewController(subjectViewController, animated: true)
    }
    
    // MARK: - Properties
    var subjects: [Subject] {
        NSPersistentContainer.shared.viewContext.subjects
            .filter {
                if searchString == "" { return true }
                return $0.title?.contains(searchString) == true
            }
    }
    var searchString = "" {
        didSet {
            DispatchQueue.main.async {
                self.subjectTableView.reloadData()
            }
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subjectTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(NSPersistentContainer.shared.viewContext.subjects)
        subjectTableView.delegate = self
        subjectTableView.dataSource = self
        searchBar.delegate = self
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let questionTableViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "QuestionTableViewController") as? QuestionTableViewController else { return }
        questionTableViewController.subject = subjects[indexPath.row]
        navigationController?.pushViewController(questionTableViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell", for: indexPath)
        let subject = subjects[indexPath.row]
        cell.textLabel?.text = subject.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subjects.count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            let subject = self.subjects[indexPath.row]
            
            NSPersistentContainer.shared.viewContext.delete(subject)
            NSPersistentContainer.shared.viewContext.saveState()
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

// MARK: - Extension
extension SubjectTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchString = searchText
    }
}
