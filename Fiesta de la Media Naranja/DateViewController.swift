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
        dateLabel.text = dateType
        if dateType == "Start Date" { dateType = "startDate"} else { dateType = "birthDate"}
        let defaults = UserDefaults.standard
        if let datetoset = defaults.object(forKey: dateType!) as? Date {
                date.setDate(datetoset, animated: true)
            }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let defaults = UserDefaults.standard
        
        if dateType=="startDate" {
            if date.date > defaults.object(forKey: "birthDate") as! Date{
                defaults.set(date.date, forKey: dateType!)
                defaults.synchronize()
                return true
            } else{
                alert()
                return false
            }
        } else {
            if date.date < defaults.object(forKey: "startDate") as! Date {
                defaults.set(date.date, forKey: "birthDate")
                defaults.synchronize()
                return true
            } else {
                alert()
                return false
            }
        }
        
    }

    func alert(){
        let alertView = UIAlertController(title: "Fechas incoherentes", message: "La cagaste",
                                          preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertView, animated: true)
    }
    
}
