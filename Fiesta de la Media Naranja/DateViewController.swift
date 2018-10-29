//
//  DateViewController.swift
//  Fiesta de la Media Naranja
//
//  Created by Daniel Carlander on 16/10/2018.
//  Copyright © 2018 Daniel Carlander. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
    
    @IBOutlet weak var date: UIDatePicker!

    @IBOutlet weak var dateLabel: UILabel!
    
    var dateType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // I know its not pretty
        dateLabel.text = dateType
        if (dateType == "Introduce la fecha de inicio de la relación") { dateType = "startDate"} else { dateType = "birthDate"}
        let defaults = UserDefaults.standard
        if let datetoset = defaults.object(forKey: dateType!) as? Date {
                date.setDate(datetoset, animated: true)
            }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let defaults = UserDefaults.standard
        
        if date.date <= Date.init(){
            if dateType=="startDate" {
                if date.date > defaults.object(forKey: "birthDate") as! Date{
                    defaults.set(date.date, forKey: dateType!)
                    defaults.synchronize()
                    return true
                }
            } else {
                if date.date < defaults.object(forKey: "startDate") as! Date {
                    defaults.set(date.date, forKey: "birthDate")
                    defaults.synchronize()
                    return true
                }
            }
            alert("No has podido enamorarte antes de nacer!")
            return false
        }
        alert("Introduce fechas del pasado!")
        return false
    }

    func alert(_ message: String){
        let alertView = UIAlertController(title: "Error", message: message,
                                          preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertView, animated: true)
    }
    
}
