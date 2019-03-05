//
//  ChangeCityInterfaceController.swift
//  APIDemo WatchKit Extension
//
//  Created by MacStudent on 2019-03-05.
//  Copyright © 2019 Parrot. All rights reserved.
//

import WatchKit
import Foundation


class ChangeCityInterfaceController: WKInterfaceController {
    
    @IBOutlet var currentCityLabel: WKInterfaceLabel!
    var selectedCity = ""
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    // SELECT CITY
    @IBAction func buttonSelectCity() {
        
        let suggestions = ["Vancouver", "Toronto", "Montreal", "New York"]
        
        presentTextInputController(withSuggestions: suggestions, allowedInputMode: .plain){ (results) in
            
            self.selectedCity = results?.first as! String
            self.currentCityLabel.setText(self.selectedCity)
            
        }
        
    }

    @IBAction func buttonSaveCity() {
    
        let sharedPreferences = UserDefaults.standard
        
        sharedPreferences.set(self.selectedCity, forKey: "currentCity")
        
        self.popToRootController()
    }
}
