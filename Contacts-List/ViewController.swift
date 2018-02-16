//
//  ViewController.swift
//  Contacts-List
//
//  Created by Amaan on 2018-02-12.
//  Copyright © 2018 amaancan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var listOfNames = [
        ExpandableNames(isExpanded: true, names: ["Ayela", "Aera", "Amel", "Aleu", "April", "Aleah"]),
        ExpandableNames(isExpanded: true, names:  ["Wuda", "Wat", "Wuu", "Woo", "WaUda"]),
        ExpandableNames(isExpanded: true, names: ["Ma", "Me", "Mel", "Mlu", "Map", "Meah"])
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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellID.rawValue) // Registers a class for use in creating new table cells, to tell the table view how to create new cells.
    }
    
    @objc func handleShowIndexPath() {
        //var indexPathsToReload = [IndexPath]() // build this array with all indexPaths
        
        let indexPathsToReload = listOfNames.indices.map { section in
            listOfNames[section].names.indices.map { row in
                IndexPath(row: row, section: section)
            }
            }.flatMap { $0 }
        
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
        
        
        //listOfNames[section].isExpanded ?
             //:
        //    tableView.insertRows(at: indexPathsToDelete, with: .fade)
        //listOfNames[section].removeAll() // keep data model updated with view otw crash
        

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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID.rawValue, for: indexPath) //dequeues an existing cell if one is available - cell’s prepareForReuse() - or creates a new one based on the class or nib file you previously registered - cell's init(style:reuseIdentifier:) - and adds it to the table
        let name = listOfNames[indexPath.section].names[indexPath.row] // IndexPath is used as a vector for referencing arrays within arrays. For example you can represent a path to array[a][b][c] using an IndexPath. e.g. countryList > regionList > cityList The indexpath to the city you selected would include the path to it through the country and region. --- A list of indexes that together represent the path to a specific location in a tree of nested arrays.
        
        if isShowingIndexPaths {
            cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row) - \(name)"
        } else {
            cell.textLabel?.text = name
        }
        
        return cell
    }
}

