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
    
    // Declare/Set the variables
    let questionsPerRound = 5
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var questionDictionary = Question()
    
    var gameSound = Sound(actualSound: 0, name: "GameSound")
    var correctSound = Sound(actualSound: 0, name: "Correct")
    var wrongSound = Sound(actualSound: 0, name: "Wrong")

    var timer = Timer()
    
    var trivia = Quiz()
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var Answer1: UIButton!
    @IBOutlet weak var Answer2: UIButton!
    @IBOutlet weak var Answer3: UIButton!
    @IBOutlet weak var Answer4: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Start game
        gameSound.loadSound()
        correctSound.loadSound()
        wrongSound.loadSound()
        gameSound.playSound()
        displayQuestion()

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {

        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.questions.count)
        //Remove the question from the quiz so that it is not repeated during a round
        questionDictionary = trivia.questions.remove(at: indexOfSelectedQuestion)
        questionField.text = questionDictionary.name
        Answer1.setTitle(questionDictionary.options[0], for: UIControlState())
        Answer2.setTitle(questionDictionary.options[1], for: UIControlState())
        Answer3.setTitle(questionDictionary.options[2], for: UIControlState())
        Answer4.setTitle(questionDictionary.options[3], for: UIControlState())
        Answer1.isHidden = false
        Answer2.isHidden = false
        Answer3.isHidden = false
        Answer4.isHidden = false
        playAgainButton.isHidden = true
        
        //Clear the timer in case it is set
        timer.invalidate();
        //Set timer for lighting round here
        timer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(ViewController.throwTimeout), userInfo: nil, repeats: false)

        
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
        
        // Pull the text from the correct answer
        let correctAnswer = questionDictionary.answer
        let correctAnswerText = questionDictionary.options[correctAnswer]
        
        //Clear the timer here in case the second to last question timed out but not the last one
        timer.invalidate();
        
        if (sender === Answer1 &&  correctAnswer == 0 ) || (sender === Answer2 && correctAnswer == 1 ) || (sender === Answer3 && correctAnswer == 2 ) || (sender === Answer4 && correctAnswer == 3 ) {
            correctQuestions += 1
            questionField.text = "Correct!"
            correctSound.playSound();
        } else {
            questionField.text = "Sorry, correct answer is: \n" + correctAnswerText
            wrongSound.playSound();
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if questionsAsked >= questionsPerRound {
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
        
        //Reset variables for new round
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

    func throwTimeout() {
        // Mark a question incorrect if time exceed 15 seconds
        self.questionField.text = "Sorry, time is up!"
        self.wrongSound.playSound();
        questionsAsked += 1
        self.loadNextRoundWithDelay(seconds: 2)
    }

    
    
}

