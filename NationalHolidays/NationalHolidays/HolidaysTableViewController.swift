//
//  HolidaysTableViewController.swift
//  NationalHolidays
//
//  Created by Gor Yeghoyan on 1/18/20.
//  Copyright © 2020 Gor Yeghoyan. All rights reserved.
//

import UIKit

class HolidaysTableViewController: UITableViewController {


    @IBOutlet weak var searchBar: UISearchBar!
    
    var listOfHolidays = [HolidayDetails]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfHolidays.count) Holidays found"
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = searchBar
        searchBar.delegate = self
        tableView.backgroundView = UIImageView(image: UIImage(named: "holidays"))
       // blurEffect()
        
    }

    
    
    func blurEffect() {
        let blur = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blureView = UIVisualEffectView(effect: blur)
        blureView.frame = tableView.bounds
        
        tableView.addSubview(blureView)
    }
   
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listOfHolidays.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let holiday = listOfHolidays[indexPath.row]
        
        cell.textLabel?.text = holiday.name
        cell.detailTextLabel?.text = holiday.date.iso
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .white
        
        
       
    }
}




extension HolidaysTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         guard let searchBarText = searchBar.text else {return}
               let holidayRequest = HolidayRequest(countryCode: searchBarText)
               holidayRequest.getHolidays { [weak self] result in
                   switch result {
                   case .failure(let error):
                       print(error)
                   case .success(let holidays):
                       self?.listOfHolidays = holidays
                   }
               }
    }
}
