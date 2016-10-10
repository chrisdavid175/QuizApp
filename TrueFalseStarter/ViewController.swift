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
    
    var gameSound = Sound(actualSound: 0, name: "GameSound")
    
    let trivia = Quiz()
    
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

        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(trivia.questions.count)
        let questionDictionary = trivia.questions[indexOfSelectedQuestion]
        questionField.text = questionDictionary["question"]
        Answer1.setTitle(questionDictionary["1"], forState: .Normal)
        Answer2.setTitle(questionDictionary["2"], forState: .Normal)
        Answer3.setTitle(questionDictionary["3"], forState: .Normal)
        Answer4.setTitle(questionDictionary["4"], forState: .Normal)
        Answer1.hidden = false
        Answer2.hidden = false
        Answer3.hidden = false
        Answer4.hidden = false
        playAgainButton.hidden = true
    }
    
    func displayScore() {
        // Hide the answer buttons
        Answer1.hidden = true
        Answer2.hidden = true
        Answer3.hidden = true
        Answer4.hidden = true
        
        // Display play again button
        playAgainButton.hidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    
    @IBAction func checkAnswer(sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        let selectedQuestionDict = trivia.questions[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict["answer"]
        
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
        Answer1.hidden = false
        Answer2.hidden = false
        Answer3.hidden = false
        Answer4.hidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.nextRound()
        }
    }
    
    
}

