//
//  ViewController.swift
//  TimerApp
//
//  Created by Zarzecki, Matthias on 15.06.18.
//  Copyright © 2018 Zarzecki, Matthias. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var secondsElapsed = 0
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    @IBOutlet weak var timerDisplay: UILabel!
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        pauseButton.isEnabled = false
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        pauseButton.isEnabled = true
    }
    
    @objc func updateTimer() {
        if secondsElapsed < 1 {
            timer.invalidate()
        } else {
            secondsElapsed += 1
            updateDisplay()
        }
    }
    
    @IBAction func pauseButtonClicked(_ sender: Any) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            self.pauseButton.setTitle("Resume", for: .normal)
        } else {
            runTimer()
            self.resumeTapped = false
            self.pauseButton.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func startButtonClicked(_ sender: Any) {
        if isTimerRunning == false {
            runTimer()
            isTimerRunning = true
            self.startButton.isEnabled = false
        }
    }
    
    @IBAction func resetButtonClicked(_ sender: Any) {
        timer.invalidate()
        secondsElapsed = 0
        updateDisplay()
        isTimerRunning = false
        pauseButton.isEnabled = false
        startButton.isEnabled = true
    }
    
    private func updateDisplay() {
        timerDisplay.text = timeString(time: TimeInterval(secondsElapsed))
    }
    
    private func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}
