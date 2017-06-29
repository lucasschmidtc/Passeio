//
//  SettingsTableViewController.swift
//  Passeio
//
//  Created by Lucas Cavalcante on 27/06/17.
//  Copyright © 2017 Lucas Cavalcante. All rights reserved.
//

import UIKit
import CoreLocation

struct Settings {
    struct Rate {
        static let Key: String = "Rate"
        static let Default: CLLocationDistance = 100.0
    }
    
    struct Accuracy {
        static let Key: String = "Accuracy"
        static let Default: CLLocationAccuracy = kCLLocationAccuracyBest
    }
}

class SettingsTableViewController: UITableViewController {
    
    private enum Section: Int {
        case Rate = 0
        case Accuracy
    }
    
    private let rates = [50.0, 100.0, 200.0, 500.0]
    
    private let accuracies = [kCLLocationAccuracyBest,
                              kCLLocationAccuracyNearestTenMeters,
                              kCLLocationAccuracyHundredMeters]
    
    private var indexRate: Int {
        get {
            return rates.index(of: UserDefaults.standard.double(forKey: Settings.Rate.Key))!
        }
    }
    
    private var indexAccuracy: Int {
        get {
            return accuracies.index(of: UserDefaults.standard.double(forKey: Settings.Accuracy.Key))!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // makes sure the settings are always valid
        if rates.index(of: UserDefaults.standard.double(forKey: Settings.Rate.Key)) == nil {
            UserDefaults.standard.set(Settings.Rate.Default, forKey: Settings.Rate.Key)
        }
        if accuracies.index(of: UserDefaults.standard.double(forKey: Settings.Accuracy.Key)) == nil {
            UserDefaults.standard.set(Settings.Accuracy.Default, forKey: Settings.Accuracy.Key)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkCell(at: NSIndexPath(row: indexRate, section: Section.Rate.rawValue) as IndexPath)
        checkCell(at: NSIndexPath(row: indexAccuracy, section: Section.Accuracy.rawValue) as IndexPath)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section <= 1 {
            if indexPath.section == Section.Rate.rawValue {
                uncheckCell(at: NSIndexPath(row: indexRate, section: Section.Rate.rawValue) as IndexPath)
                UserDefaults.standard.set(rates[indexPath.row], forKey: Settings.Rate.Key)
            }
            else {
                uncheckCell(at: NSIndexPath(row: indexAccuracy, section: Section.Accuracy.rawValue) as IndexPath)
                UserDefaults.standard.set(accuracies[indexPath.row], forKey: Settings.Accuracy.Key)
            }
            checkCell(at: indexPath)
        }
        
        return indexPath
    }
    
    private func checkCell(at indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            tableView.reloadRows(at: [indexPath], with: .none)
            
            NotificationCenter.default.post(name: .onSettingsChange, object: nil)
        }
    }
    
    private func uncheckCell(at indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    @IBAction func resetSettings(_ sender: UIButton) {
        uncheckCell(at: NSIndexPath(row: indexRate, section: Section.Rate.rawValue) as IndexPath)
        uncheckCell(at: NSIndexPath(row: indexAccuracy, section: Section.Accuracy.rawValue) as IndexPath)
        
        UserDefaults.standard.set(Settings.Rate.Default, forKey: Settings.Rate.Key)
        UserDefaults.standard.set(Settings.Accuracy.Default, forKey: Settings.Accuracy.Key)
        
        checkCell(at: NSIndexPath(row: indexRate, section: Section.Rate.rawValue) as IndexPath)
        checkCell(at: NSIndexPath(row: indexAccuracy, section: Section.Accuracy.rawValue) as IndexPath)
    }
}
