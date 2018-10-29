//
//  ViewController.swift
//  Fiesta de la Media Naranja
//
//  Created by Daniel Carlander on 11/10/2018.
//  Copyright © 2018 Daniel Carlander. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var birthDateButton: UIButton!
    @IBOutlet weak var startDateButton: UIButton!
    @IBOutlet weak var orangeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var alertView: UIAlertController?
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let startDate = defaults.object(forKey: "startDate") as? Date {
            startDateButton.setTitle(displayDate(startDate), for: .normal)
        } else {
            defaults.set(Date.init(), forKey: "startDate")
        }
        
        if let birthDate = defaults.object(forKey: "birthDate") as? Date {
            birthDateButton.setTitle(displayDate(birthDate), for: .normal)
        } else {
            defaults.set(Date.init(), forKey: "birthDate")
        }
        
        computeOrange()
    }

    @IBAction
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let rcv = segue.destination as? DateViewController {
            if segue.identifier == "start"{
                rcv.dateType = "Introduce la fecha de inicio de la relación"
            } else {
                rcv.dateType = "Introduce la fecha de nacimiento"
            }
            
        }
    }
    
    @IBAction
    func getDate(_ segue: UIStoryboardSegue) {
        if let rcv = segue.source as? DateViewController {
            
            if rcv.dateType == "startDate" {
                startDateButton.setTitle(displayDate(rcv.date.date), for: .normal)
            } else {
                birthDateButton.setTitle(displayDate(rcv.date.date), for: .normal)
            }
            computeOrange()
        }
    }
    
    func displayDate(_ date: Date) -> String {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        if let day = components.day, let month = components.month, let year = components.year {
            return "\(day)/\(month)/\(year)"
        }
        return ""
    }
    
    func computeOrange() {
        let birthDate = defaults.object(forKey: "birthDate") as! Date
        let startDate = defaults.object(forKey: "startDate") as! Date
        
        if birthDate < startDate && startDateButton.title(for: .normal) != "Elegir" && startDateButton.title(for: .normal) != "Elegir" {
            let difference = startDate.timeIntervalSince(birthDate)
            let orangeDate = startDate + difference
            orangeLabel.text = "Tu fiesta de la naranja es el \(displayDate(orangeDate))"
            imageView.isHidden = false
        } else {
            orangeLabel.text = "Introduce todas las fechas"
            imageView.isHidden = true        }
    }
    
}

