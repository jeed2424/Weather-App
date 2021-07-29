//
//  ViewController.swift
//  Sunny
//
//  Created by Jay Beaudoin on 2021-07-23.
//

import UIKit


class ViewController: UIViewController {
    

    
    //Images
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var maxImg: UIImageView!
    @IBOutlet weak var minImg: UIImageView!
    
    
    
    //Labels
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    @IBOutlet weak var currentCondLbl: UILabel!
    @IBOutlet weak var maxMinLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var wSpeedLbl: UILabel!
    @IBOutlet weak var wGustLbl: UILabel!
    @IBOutlet weak var wDegLbl: UILabel!
    
    
    //Enter your own API key!
    private let apiKey = ""
    var networkManager = NetworkService()
    
    //Buttons
    //Returns Alert with search button found in VC+alertController
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter the city Name", message: "you can enter the city in name in textFiled", style: .alert) { [weak self] (newCity) in
            guard let self = self else { return }
            self.networkManager.fetchData(city: newCity, apiKey: self.apiKey) { weather in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.updateUI(currentWeather: weather)
                }
            }
        }
    }
    
    // Present new VC with Json Data from CurrentWeather
    @IBAction func rawDataBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "JsonDataVC") as? RawDataVC {
            vc.rawData = networkManager.stringData
            present(vc, animated:true, completion:nil)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maxImg.image = UIImage(named: "up.png")
        minImg.image = UIImage(named: "down.png")
        self.networkManager.fetchData(city: "San+Francisco", apiKey: apiKey) { weather in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.updateUI(currentWeather: weather)
            }
        }
    }
    
 
    
    // Update all UI items based on CurrentWeather
    func updateUI(currentWeather: CurrentWeather) {
        print(currentWeather.icon)
        weatherIconImageView.getIcon(img: weatherIconImageView, icon: currentWeather.icon, currentWeather: currentWeather)
        currentCondLbl.text = currentWeather.mainDes
        cityLabel.text = currentWeather.cityName
        temperatureLabel.text = currentWeather.temperatureString
        feelsLikeTemperatureLabel.text = (currentWeather.feelsLikeTemperatureString + " °F")
        maxMinLbl.text = (currentWeather.maxTempString + "°/" + currentWeather.minTempString + "°")
        wSpeedLbl.text = (currentWeather.wSpeedString + " mph")
        wGustLbl.text = (currentWeather.wGustString + " mph")
        wDegLbl.text = (currentWeather.wDegString + "°")
        humidityLbl.text = (currentWeather.humidityString + "%")
    }
    
}


// URL: http://api.openweathermap.org/data/2.5/weather?q=San+Francisco&appid=(APIKEY)&units=imperial
