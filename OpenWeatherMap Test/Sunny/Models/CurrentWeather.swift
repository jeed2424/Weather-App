//
//  CurrentWeather.swift
//  Sunny
//
//  Created by Jay Beaudoin on 2021-07-23.
//

import Foundation

struct CurrentWeather {
    
    let cityName: String
                
    let mainDes: String
    
    let icon: String
    
    let temperature: Double
    var temperatureString: String {
        return "\(temperature.rounded())"
    }
    
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        return "\(feelsLikeTemperature.rounded())"
    }
    
    let maxTemp: Double
    var maxTempString: String {
        return "\(maxTemp.rounded())"
    }
    
    let minTemp: Double
    var minTempString: String {
        return "\(minTemp.rounded())"
    }
    
    let wSpeed: Double
    var wSpeedString: String {
        return "\(wSpeed.rounded())"
    }
    
    let wDeg: Int
    var wDegString: String {
        return "\(wDeg)"
    }
    
    let wGust: Double
    var wGustString: String {
        return "\(wGust.rounded())"
    }
    
    let humidity: Int
    var humidityString: String {
        return "\(humidity)"
    }
    
    let conditionCode: Int
    
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.heavyrain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.show.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
            
        }
    }
    
    init?(weatherCall: WeatherCall){
        cityName = weatherCall.name
        temperature = weatherCall.main.temp
        feelsLikeTemperature = weatherCall.main.feelsLike
        icon = weatherCall.weather.first!.icon
        conditionCode = weatherCall.weather.first!.id
        maxTemp = weatherCall.main.tempMax
        minTemp = weatherCall.main.tempMin
        mainDes = weatherCall.weather.first!.weatherDescription
        wSpeed = weatherCall.wind.speed
        wDeg = weatherCall.wind.deg
        wGust = weatherCall.wind.gust
        humidity = weatherCall.main.humidity
    }
    
}
