//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ildar Usmanov on 30.03.2020.
//  Copyright © 2020 Ildar Usmanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var apparentTemperatureLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
    }
    
    let myApiKey = "147b1adf15a13dc63d253adb4ff5cc11"
    lazy var weatherManager = APIWeatherManager(apiKey: myApiKey)
    let coordinates = Coordinates(latitude: 55.794092, longitude: 37.508220)
    
    override func viewDidLoad() {
       super.viewDidLoad()

       weatherManager.fetchCurrentWeatherWith(coordinates: coordinates) { (result) in
         switch result {
         case .Success(let currentWeather):
           self.updateUIWith(currentWeather: currentWeather)
         case .Failure(let error as NSError):
           
           let alertController = UIAlertController(title: "Unable to get data ", message: "\(error.localizedDescription)", preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(okAction)
           
           self.present(alertController, animated: true, completion: nil)
         default: break
         }
       }
     }
    
    func updateUIWith(currentWeather: CurrentWeather) {
        self.imageView.image = currentWeather.icon
        self.pressureLabel.text = "\(Int(currentWeather.pressure)) mm"
        self.temperatureLabel.text = "\(Int(currentWeather.temperature))˚C"
        self.apparentTemperatureLabel.text = "Feels like \(Int(currentWeather.apparentTemperature))˚C"
        self.humidityLabel.text = "\(Int(currentWeather.humidity)) %"
    }
}

