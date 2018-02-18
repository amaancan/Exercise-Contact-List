//
//  ViewController.swift
//  Contacts-List
//
//  Created by Amaan on 2018-02-12.
//  Copyright © 2018 amaancan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    // NOTE: Model shouldn't be in VC
    var listOfNames = [
        ExpandableNames(isExpanded: true, names: ["Ayela", "Aera", "Amel", "Aleu", "April", "Aleah"].map { Contact(name: $0, hasFavourited: false)}),
        ExpandableNames(isExpanded: true, names:  ["Wuda", "Wat", "Wuu", "Woo", "WaUda"].map { Contact(name: $0, hasFavourited: false)}),
        ExpandableNames(isExpanded: true, names: ["Ma", "Me", "Mel", "Mlu", "Map", "Meah"].map { Contact(name: $0, hasFavourited: false)})
    ]
    
    var isShowingIndexPaths = false { // flag
        didSet {
            navigationItem.rightBarButtonItem?.title = isShowingIndexPaths ? "Hide IndexPath" : "Show IndexPath"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: refactor tableView setUp
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(ContactCell.self, forCellReuseIdentifier: Constants.cellID.rawValue) // Registers a class for use in creating new table cells, to tell the table view how to create new cells.
    }
    
    @objc func handleShowIndexPath() {
        var indexPathsToReload = [IndexPath]() // build this array with all indexPaths
        
        for section in listOfNames.indices {
            // if section = collapsed, don't incl. it's rows in array to be reloaded to avoid crash
            if listOfNames[section].isExpanded {
                for row in listOfNames[section].names.indices {
                    let indexPath = IndexPath(row: row, section: section)
                    indexPathsToReload.append(indexPath)
                }
            }
        }
        
        isShowingIndexPaths.toggle()
        let animationOfReload = isShowingIndexPaths ? UITableViewRowAnimation.right : .left
        tableView.reloadRows(at: indexPathsToReload, with: animationOfReload)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.tag = section
        
        button.addTarget(self, action: #selector(handleExpandSection), for: .touchUpInside)
        
        return button
    }
    
    @objc func handleExpandSection(button: UIButton) {
        let section = button.tag // which sectin to close? pressed button's tag = section #
        
        let indexPathsToDelete =  listOfNames[section].names.indices.map { row in
            IndexPath(row: row, section: section)
        }
        
        listOfNames[section].isExpanded.toggle() // tapping 'Close' -> 1) isExpanded = false 2) deleteRows triggers numberOfRowsInSection to evaulate to return 0
        
        let isExpanded = listOfNames[section].isExpanded
        button.setTitle(isExpanded ? "Close" : "Open", for: .normal)
        
        if isExpanded {
            tableView.insertRows(at: indexPathsToDelete, with: .fade)
        } else {
            tableView.deleteRows(at: indexPathsToDelete, with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return listOfNames.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfNames[section].isExpanded ? listOfNames[section].names.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        //dequeues an existing cell if one is available - cell’s prepareForReuse() - or creates a new one based on the class or nib file you previously registered - cell's init(style:reuseIdentifier:) - and adds it to the table
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID.rawValue, for: indexPath) as! ContactCell // Favouriting: step 4 of 5
        
        //Favouriting: step 5 of 5
        cell.delegate = self // each cell's delegate is this VC; to send fav message
        
        let contact = listOfNames[indexPath.section].names[indexPath.row] // IndexPath is used as a vector for referencing arrays within arrays. For example you can represent a path to array[a][b][c] using an IndexPath. e.g. countryList > regionList > cityList The indexpath to the city you selected would include the path to it through the country and region. --- A list of indexes that together represent the path to a specific location in a tree of nested arrays.
        
        
        if isShowingIndexPaths {
            cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row) - \(contact.name)"
        } else {
            cell.textLabel?.text = contact.name
        }
        
        // star gets colour based on model's bool value WHEN IT RENDERS... need to render WHEN star is tapped by reloading data for this indexPath
        cell.accessoryView?.tintColor = contact.hasFavourited ? UIColor.red : .lightGray

        return cell
    }
    
    // Favouriting: step 3 of 5
    func markFavourite(cell: UITableViewCell) {
        // figure out which cell's star is being tapped
        guard let indexPathTapped = tableView.indexPath(for: cell) else { return }
        
        // change model: toggle bool
        listOfNames[indexPathTapped.section].names[indexPathTapped.row].hasFavourited =
            !listOfNames[indexPathTapped.section].names[indexPathTapped.row].hasFavourited
        
        // grab contact from model based on location provided by cell's position in tableView since it's organized same heirarchy as model
        var contact = listOfNames[indexPathTapped.section].names[indexPathTapped.row]
        cell.accessoryView?.tintColor = contact.hasFavourited ? UIColor.red : .lightGray // update view to match model
        //tableView.reloadRows(at: [indexPathTapped], with: .automatic) // another way to update view
    }
}

