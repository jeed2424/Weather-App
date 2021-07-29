//
//  RawDataVC.swift
//  Sunny
//
//  Created by Jay Beaudoin on 2021-07-24.
//

import Foundation
import UIKit



class RawDataVC: UIViewController, UITextViewDelegate {
    var rawData = ("")

    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var rawTxt: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      updateUI()
    }
    
    func updateUI(){
        nameLbl.text = "Json Raw Data:"
        rawTxt!.text = rawData
        print("This is RawDataVC's raw data: " + rawData)
    }
}
