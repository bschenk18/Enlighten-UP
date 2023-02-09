//
//  GameViewController.swift
//  Quiz Game
//
//  Created by Benjamin Prentiss on 1/31/23.
//

import UIKit
import CoreData

class GameViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var trueButton: UIButton!
    @IBOutlet var falseButton: UIButton!
    @IBOutlet var questionsGameButton: UIBarButtonItem!
    
    // MARK: - Properties
    var game: Game?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - Actions
    func goToNextQuestionOrEndGame() {
        if game?.isComplete == true {
            guard let resultsTableViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ResultsTableViewController" ) as? ResultsTableViewController else { return }
            // Assign game here
            resultsTableViewController.game = game
            navigationController?.pushViewController(resultsTableViewController, animated: true)
        } else {
            game?.nextQuestion()
        }
    }
    
    @IBAction func trueButtonTapped(_ sender: UIButton) {
        let userGotItRight = game?.isCorrect(userAnswer: true) == true
        if userGotItRight {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }
        goToNextQuestionOrEndGame()
        // Gives user moment to see if they got it right or wrong
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    @IBAction func falseButtonTapped(_ sender: UIButton) {
        let userGotItRight = game?.isCorrect(userAnswer: false) == true
        if userGotItRight {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }
        goToNextQuestionOrEndGame()
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
    }
    
    @IBAction func questionsGameButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Functions
    @objc func updateUI() {
        guard let game = game else { return }
        questionLabel.text = game.getQuestionText()
        progressBar.progress = (game.getProgress())
        scoreLabel.text = "Score: \(game.score)"
        trueButton.backgroundColor = UIColor.black
        falseButton.backgroundColor = UIColor.black
    }
}
