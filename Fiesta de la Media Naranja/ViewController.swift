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
    
    @IBInspectable
    var startDate: Date = Date.distantPast {
        didSet {
            computeOrange()
        }
    }
    
    @IBInspectable
    var birthDate: Date = Date.distantFuture{
        didSet {
            computeOrange()
        }
    }
    
    var alertView: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        defaults.set(Date.init(), forKey: "startDate")
        defaults.set(Date.init(), forKey: "birthDate")
        defaults.synchronize()
        
    }

    @IBAction
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let rcv = segue.destination as? DateViewController {
            if segue.identifier == "start"{
                rcv.dateType = "Start Date"
            } else {
                rcv.dateType = "Birth Date"
            }
            
        }
    }
    
    @IBAction
    func getDate(_ segue: UIStoryboardSegue) {
        if let rcv = segue.source as? DateViewController {
            let components = Calendar.current.dateComponents([.year, .month, .day], from: rcv.date.date)
            if let day = components.day, let month = components.month, let year = components.year {
                
                if rcv.dateLabel.text == "Start Date" {
                    startDateButton.setTitle("\(day)/\(month)/\(year)", for: .normal)
                    startDate = rcv.date.date
                } else {
                    birthDateButton.setTitle("\(day)/\(month)/\(year)", for: .normal)
                    birthDate = rcv.date.date
                }
            }
        }
    }
    
    @IBAction
    func computeOrange() {
        
        if birthDate < startDate {
            let difference = startDate.timeIntervalSince(birthDate)
            let orangeDate = startDate + difference
            let components = Calendar.current.dateComponents([.year, .month, .day], from: orangeDate)
            
            if let day = components.day, let month = components.month, let year = components.year {
            orangeLabel.text = "Tu fiesta de la naranja es el \(day)/\(month)/\(year)"
            }
        } else {
            orangeLabel.text = "Introduce todas las fechas"
            
        }
            
    }
    
}

