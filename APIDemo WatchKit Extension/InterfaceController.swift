//
//  InterfaceController.swift
//  APIDemo WatchKit Extension
//
//  Created by Parrot on 2019-03-03.
//  Copyright © 2019 Parrot. All rights reserved.
//

import WatchKit
import Foundation
import Alamofire
import SwiftyJSON

class InterfaceController: WKInterfaceController {
    
    @IBOutlet var cityLabel: WKInterfaceLabel!
    @IBOutlet var sunriseLabel: WKInterfaceLabel!
    @IBOutlet var sunsetLabel: WKInterfaceLabel!
    @IBOutlet var loadingImage: WKInterfaceImage!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        
        
        // Update the label
        let sharedPreferences = UserDefaults.standard
        
        let currenCity = sharedPreferences.string(forKey: "currentCity")
        cityLabel.setText(currenCity)
        
        
        
        // PROGRESS ANIMATION UNTIL DATA COMES FROM API
        self.loadingImage.setImageNamed("Progress")
        self.loadingImage.startAnimatingWithImages(in: NSMakeRange(0, 10), duration: 1, repeatCount: 0)
        
        self.sunriseLabel.setText("Updating...")
        self.sunsetLabel.setText("Updating...")
        
        let URL = "https://api.sunrise-sunset.org/json?lat=49.2827&lng=-123.1207&date=today"
        
        Alamofire.request(URL).responseJSON {
            // 1. store the data from the internet in the
            // response variable
            response in
            
            // 2. get the data out of the variable
            guard let apiData = response.result.value else {
                print("Error getting data from the URL")
                return
            }
            
            // OUTPUT the json response to the terminal
            print(apiData)
            
            
            // GET something out of the JSON response
            let jsonResponse = JSON(apiData)
            let sunriseTime = jsonResponse["results"]["sunrise"].string
            let sunsetTime = jsonResponse["results"]["sunset"].string

            // show the sunrise and sunset in the IPhone App
            self.sunriseLabel.setText("\(sunriseTime!)")
            self.sunsetLabel.setText("\(sunsetTime!)")
            
            self.loadingImage.stopAnimating()
            self.loadingImage.setImageNamed(nil)
            
        }
    }
   
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
