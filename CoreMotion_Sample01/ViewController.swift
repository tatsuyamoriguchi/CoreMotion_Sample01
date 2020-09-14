//
//  ViewController.swift
//  CoreMotion_Sample01
//
//  Created by Tatsuya Moriguchi on 9/14/20.
//  Copyright © 2020 Tatsuya Moriguchi. All rights reserved.
//

import UIKit
import CoreMotion


class ViewController: UIViewController {

    @IBOutlet weak var labelX: UILabel!
    @IBOutlet weak var labelY: UILabel!
    @IBOutlet weak var labelZ: UILabel!
    @IBOutlet weak var intervalSlider: UISlider!
    @IBOutlet weak var intervalLabel: UILabel!
    
    let motion = CMMotionManager()
    var timer = Timer()
    var intervalN = 1.0
   
    @IBAction func sliderValueChange(_ sender: Any) {
        
        intervalN = Double(intervalSlider.value * 60.0)
        intervalLabel.text = "\(intervalN)"
        //intervalN = intervalN
    }
    @IBAction func updateButton(_ sender: Any) {
        
        getAccelerometerData(sliderValue: intervalN)
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        motion.stopAccelerometerUpdates()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        intervalLabel.text = "1.0"
        intervalSlider.value = 1.0/60.0
  
    }


    func getAccelerometerData(sliderValue: Double) {
        // Check to see if the accelerometer hardware is available.
        if self.motion.isAccelerometerAvailable {
            self.motion.accelerometerUpdateInterval = sliderValue/60.0 // 60 Hz update frequency
            self.motion.startAccelerometerUpdates()
            
            // Configure a timer to fetchthe data.
            self.timer = Timer(fire: Date(), interval: (1.0/60.0), repeats: true, block: {(timer) in
                // Get the accelerometer data.
                if let data = self.motion.accelerometerData {
                    let x = data.acceleration.x
                    let y = data.acceleration.y
                    let z = data.acceleration.z
                    
                    // Display the accelerometer data on UI.
                    self.labelX.text = String(x)
                    self.labelY.text = String(y)
                    self.labelZ.text = String(z)
                    
                }
            })
            
            // Add the timer to the current run loop.
            RunLoop.current.add(self.timer, forMode: .default)
        }
        
    }
    
    
}

