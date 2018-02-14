//
//  ViewController.swift
//  Contacts-List
//
//  Created by Amaan on 2018-02-12.
//  Copyright © 2018 amaancan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    //let names = ["Nayela", "Vera", "Mel", "Bleu", "April", "Leah"]
    //let namesTwo = ["Wuda", "Fat Girl", "Wuu", "Uoo", "Uda", "Shont"]
    let listOfNames = [
        ["Nayela", "Vera", "Mel", "Bleu", "April", "Leah"],
        ["Wuda", "Fat Girl", "Wuu", "Uoo", "Uda", "Shont"],
        ["Na", "Ve", "Mel", "Blu", "Ap", "Meah"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellID.rawValue) // Registers a class for use in creating new table cells, to tell the table view how to create new cells.
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Header"
        label.backgroundColor = UIColor.lightGray
        return label
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return listOfNames.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfNames[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID.rawValue, for: indexPath) //dequeues an existing cell if one is available - cell’s prepareForReuse() - or creates a new one based on the class or nib file you previously registered - cell's init(style:reuseIdentifier:) - and adds it to the table
        let name = listOfNames[indexPath.section][indexPath.row]
        //let name = indexPath.section == 0 ? names[indexPath.row] : namesTwo[indexPath.row]
        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row) - \(name)"
        
        return cell
    }


}

