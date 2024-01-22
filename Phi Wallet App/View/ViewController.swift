//
//  ViewController.swift
//  Phi Wallet App
//
//  Created by Aijaz Ali on 22/01/2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userCountryTextField: UITextField!
    @IBOutlet weak var userCountryLabel: UILabel!
    var userCountryHistory = [[String: String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func findCountryTapped(_ sender: UIButton) {
        if let text = userCountryTextField.text {
            self.getUserCountry(name: text)
        }
    }
    
    @IBAction func historyTapped(_ sender: UIButton) {
        guard let historyVC = storyboard?.instantiateViewController(identifier: "HistoryViewController") as? HistoryViewController else { return}
        historyVC.userCountryHistory = self.userCountryHistory
        self.navigationController?.pushViewController(historyVC, animated: true)
    }
    
    private func getUserCountry(name: String) {
       
        
        NetworkManager.shared.get(userName: name, modelType: Country.self) { result in
            switch result {
            case .success(let country):
                // Use the decoded users array/object
                print("Users:", country.country.first!.country_id)
                print("Users:", country)
                self.userCountryLabel.text = "UserCountry: \(country.country.first!.country_id)"
                self.userCountryHistory.append([name : "UserCountry: \(country.country.first!.country_id)"])
            case .failure(let error):
                print("Error:", error)
            }
        }
    }
}

