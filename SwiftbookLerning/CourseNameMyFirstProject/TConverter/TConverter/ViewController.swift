//
//  ViewController.swift
//  TConverter
//
//  Created by Ildar Usmanov on 28.02.2020.
//  Copyright © 2020 Ildar Usmanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var fahrenheitLabel: UILabel!
    @IBOutlet weak var slider: UISlider! {
        didSet {
            slider.maximumValue = 100
            slider.minimumValue = 0
            slider.value = 0
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let temperaturCelsius = Int(round(sender.value))
        celsiusLabel.text = "\(temperaturCelsius)ºC"
        
        let TemperatureFahrenheit = Int(round(sender.value * 9 / 5 + 32))
        fahrenheitLabel.text = "\(TemperatureFahrenheit)ºF"
    }

}

