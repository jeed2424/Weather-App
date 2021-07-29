//
//  Networkmanager.swift
//  Sunny
//
//  Created by Jay Beaudoin on 2021-07-23.
//

import Foundation
import UIKit


class NetworkService {
    
    var stringData: String = ""
    
    //Get data from API
    func fetchData(city: String, apiKey: String, completionHandler: @escaping (CurrentWeather)-> Void) {
          
         let urlString = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=imperial"
          guard let url = URL(string: urlString) else { return }
          
          URLSession.shared.dataTask(with: url) { (data, response, error) in
              
              if let error = error {
                  print( "Error getting URL:", error.localizedDescription)
              }
              
              guard let data = data else { return }
              
              do {
                  let json = try JSONDecoder().decode(WeatherCall.self, from: data)
                  guard let currentWeather = CurrentWeather(weatherCall: json) else { return }
                  completionHandler(currentWeather)
  //              self.delegate?.updateInterface(self, currentWeather: currentWeather)
              } catch let error as NSError {
                  print(error.localizedDescription)
              }
            self.stringData = NSString(data:data, encoding:String.Encoding.utf8.rawValue)! as String
              
          }.resume()
          
      }
         

}

extension UIImageView {
    
    //SetUp Weather Icon
    func getIcon(img: UIImageView, icon: String, currentWeather: CurrentWeather){
        guard let url = URL(string: "http://openweathermap.org/img/w/\(icon).png") else {
            print("Error getting Icon")
            return
        }
           DispatchQueue.global().async {
               // Fetch Image Data
               if let data = try? Data(contentsOf: url) {
                   DispatchQueue.main.async {
                       // Create Image and Update Image View
                       img.image = UIImage(data: data)
                   }
               } else {
                img.image = UIImage(systemName: currentWeather.systemIconNameString)
               }
           }
    }
}
