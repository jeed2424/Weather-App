//
//  ViewController+alertController.swift
//  Sunny
//
//  Created by Jay Beaudoin on 2021-07-23.
//

import UIKit

extension ViewController {
    
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping (String)-> Void ) {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        
        ac.addTextField { tf in
            let cities = ["San Francisco", "Moscow", "New York", "State College", "Paris"]
            tf.placeholder = cities.randomElement()
        }
        
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                let newCity = (cityName).replacingOccurrences(of: " ", with: "+")
                print(cityName)
                print(newCity)
                completionHandler(newCity)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(search)
        ac.addAction(cancel)
        
        present(ac, animated: true, completion: nil)
    }
    
}
