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

    let motion = CMMotionManager()
    var timer = Timer()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Check to see if the accelerometer hardware is available.
        if self.motion.isAccelerometerAvailable {
            self.motion.accelerometerUpdateInterval = 1.0/60.0 // 60 Hz update frequency
            self.motion.startAccelerometerUpdates()

            // Configure a timer to fetchthe data.
            self.timer = Timer(fire: Date(), interval: (1.0/60.0), repeats: true, block: {(timer) in
                // Get the accelerometer data.
                if let data = self.motion.accelerometerData {
                    let x = data.acceleration.x
                    let y = data.acceleration.y
                    let z = data.acceleration.z

                    // Display the accelerometer data on UI.
                    
                    print("x: \(x)")
                    print("y: \(y)")
                    print("z: \(z)")
                
                    


                }
            })

            // Add the timer to the current run loop.
            RunLoop.current.add(self.timer, forMode: .default)
        }
        
    }


}

