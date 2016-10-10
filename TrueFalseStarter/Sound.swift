//
//  Sound.swift
//  TrueFalseStarter
//
//  Created by Chris David on 10/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import AudioToolbox

struct Sound {
    var actualSound: SystemSoundID
    var name: String
    
    init(actualSound: SystemSoundID, name: String) {
        self.actualSound = actualSound
        self.name = name
    }
    
    mutating func loadSound() -> SystemSoundID {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource(self.name, ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &actualSound)
        return actualSound
    }
    
    func playSound() {
        AudioServicesPlaySystemSound(actualSound)
    }

}
