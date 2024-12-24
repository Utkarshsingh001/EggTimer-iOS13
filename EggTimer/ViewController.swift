//
//  AppDelegate.swift
//  EggTimer
//
//  Created by Utkarsh Singh on 24/12/2024.
//  Copyright © 2024. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    var timer = Timer()
    var player: AVAudioPlayer?
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")!

        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }

            player.prepareToPlay()
            player.play()

        } catch let error as NSError {
            print(error.description)
        }
    }
    let eggDict = [ "Soft":5, "Medium":7, "Hard":12]
    var totalTime = 0
    var secondsPassed = 0
    
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        progressBar.progress = 0
        secondsPassed = 0
        timer.invalidate()
        let hardness = sender.currentTitle!
        titleLabel.text = hardness
        
        totalTime = eggDict[hardness]!
        
        timer=Timer.scheduledTimer(timeInterval:1.0,target:self,selector:#selector(updateTimer), userInfo: nil, repeats: true)
    }
       @objc func updateTimer() {
           if secondsPassed <= totalTime{
              let percentageProgress = Float(secondsPassed)/Float(totalTime)
               progressBar.progress = percentageProgress
                secondsPassed += 1
            }
           else {
               timer.invalidate()
               titleLabel.text = "Done!"
               playSound()
           }
        }
       
    

}
