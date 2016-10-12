//
//  QuizModel.swift
//  TrueFalseStarter
//
//  Created by Chris David on 10/7/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

struct Quiz {

    var questions: [Question] = [
        
        Question(name: "Who is the founder of Choy Li Fut?", options: ["Bruce Lee", "Chan Heung", "Jet Li", "Jackie"], answer: 1),
        Question(name: "From what area of China is Choy Li Fut derived?", options: ["North","South","Both","Neither"], answer: 2),
        Question(name: "Who is the found of White Dragon Martial Arts?", options: ["John Doe","James Brown","Nathan Fisher","Barrack Obama"], answer: 2),
        Question(name: "Who is the grand master of White Dragon Martial Arts?", options: ["Brandon Lee","Tony Jaa","Doc Fai Wong","Jean-Claude Van Damme"], answer: 2),
        Question(name: "What is a tsop choi?", options: ["Kick","Palm Strike","Spear Hand","Leopard Fist"], answer: 3),
        Question(name: "Translate Siu Sup Ji Kuen", options: ["Small Hand Form","Small Cross Pattern Hand Form","Big Hand Form","Big Cross Chain "], answer: 1),
        Question(name: "Translate Siu Mui Fa Kuen", options: ["Pretty Flower Form","Small Plum Blossom Hand Form","Cactus Hand Form","Small Tree Form"], answer: 1),
        Question(name: "What is martial spirit?", options: ["Resolve","Weakness","Brute Strength","Skil"], answer: 0),
        Question(name: "Apart of what organization is White Dragon?", options: ["Plub Blossom Federation","International Kung Fu Federation","Federation of Martials Arts","Kung Fu Club"], answer: 0),
        Question(name: "What is a fu jow?", options: ["Uppercut","Low Kick","Dragon Claw","Tiger Claw"], answer: 3)
    ]

    
    
}

struct Question {
    var name: String = ""
    var options: [String] = []
    var answer: Int = 0
}
