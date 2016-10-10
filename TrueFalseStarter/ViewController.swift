//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 5
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var questionDictionary: [String: String] = [:]
    
    var gameSound = Sound(actualSound: 0, name: "GameSound")
    
    var trivia = Quiz()
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var Answer1: UIButton!
    @IBOutlet weak var Answer2: UIButton!
    @IBOutlet weak var Answer3: UIButton!
    @IBOutlet weak var Answer4: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        gameSound.loadSound()
        // Start game
        gameSound.playSound()
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {

        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.questions.count)
        //let questionDictionary = trivia.questions[indexOfSelectedQuestion]
        //var questionDictionary = trivia.questions.remove(at: indexOfSelectedQuestion)
        questionDictionary = trivia.questions.remove(at: indexOfSelectedQuestion)
        questionField.text = questionDictionary["question"]
        Answer1.setTitle(questionDictionary["1"], for: UIControlState())
        Answer2.setTitle(questionDictionary["2"], for: UIControlState())
        Answer3.setTitle(questionDictionary["3"], for: UIControlState())
        Answer4.setTitle(questionDictionary["4"], for: UIControlState())
        Answer1.isHidden = false
        Answer2.isHidden = false
        Answer3.isHidden = false
        Answer4.isHidden = false
        playAgainButton.isHidden = true
    }
    
    func displayScore() {
        // Hide the answer buttons
        Answer1.isHidden = true
        Answer2.isHidden = true
        Answer3.isHidden = true
        Answer4.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        //let selectedQuestionDict = trivia.questions[indexOfSelectedQuestion]
        //let correctAnswer = selectedQuestionDict["answer"]
        let correctAnswer = questionDictionary["answer"]
        
        if (sender === Answer1 &&  correctAnswer == "1" ) || (sender === Answer2 && correctAnswer == "2" ) || (sender === Answer3 && correctAnswer == "3" ) || (sender === Answer4 && correctAnswer == "4" ) {
            correctQuestions += 1
            questionField.text = "Correct!"
        } else {
            questionField.text = "Sorry, wrong answer!"
        }
        
        
        
        
        
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        Answer1.isHidden = false
        Answer2.isHidden = false
        Answer3.isHidden = false
        Answer4.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        trivia = Quiz()
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    
}

