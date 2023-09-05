//
//  ViewController.swift
//  hwWeather
//
//  Created by Nurjamal Mirbaizaeva on 5/9/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var getWeather: UIButton!
    
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var currentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeather.addTarget(self, action: #selector(tapGetWeather), for: .touchUpInside)
    }
    @objc func tapGetWeather(){
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current_weather=true&hourly=temperature_2m,relativehumidity_2m,windspeed_10m"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, responds, error in
            
            if let data, let weather = try? JSONDecoder().decode(Weather.self, from: data) {
                DispatchQueue.main.async {
                    self.weatherLabel.text = "\(weather.currentWeather.temperature) °"
                    self.speedLabel.text = "\(weather.currentWeather.windspeed)"
                    self.currentLabel.text = "\(weather.timezoneAbbreviation)"
                }
            }else{
                print("Fail!")
            }
        }
        task.resume()
    }

}

