//
//  HistoryViewController.swift
//  Phi Wallet App
//
//  Created by Aijaz Ali on 22/01/2024.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let cellName = "UserCountryTVCell"
    var userCountryHistory = [[String: String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        prepareView()
    }
    
    private func prepareView() {
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userCountryHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? UserCountryTVCell else { return UITableViewCell() }
        let name =  userCountryHistory[indexPath.row].first?.key
        let countryID = userCountryHistory[indexPath.row].first?.value
        cell.userCountryLabel.text = "UserName: \(name ?? "") \(countryID ?? "")"
        
        return cell
    }
    
    
}
