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
        ["Wuda", "Fat", "Wuu", "Uoo", "Uda", "Shont"],
        ["Na", "Ve", "Mel", "Blu", "Ap", "Meah"]
    ]
    
    var isShowingIndexPaths = false {
        didSet {
            navigationItem.rightBarButtonItem?.title = isShowingIndexPaths ? "Hide IndexPath" : "Show IndexPath"
        }
    } // flag
    
    @objc func handleShowIndexPath() {
        var indexPathsToReload = [IndexPath]() // build this array with all indexPaths
        
        for section in listOfNames.indices {
            for row in listOfNames[section].indices {
                let indexPath = IndexPath(row: row, section: section)
                indexPathsToReload.append(indexPath)
            }
        }
        
        isShowingIndexPaths.toggle()
        let animationOfReload = isShowingIndexPaths ? UITableViewRowAnimation.right : .left
        tableView.reloadRows(at: indexPathsToReload, with: animationOfReload)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: refactor tableView setUp
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        
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
        let name = listOfNames[indexPath.section][indexPath.row] // IndexPath is used as a vector for referencing arrays within arrays. For example you can represent a path to array[a][b][c] using an IndexPath. e.g. countryList > regionList > cityList The indexpath to the city you selected would include the path to it through the country and region. --- A list of indexes that together represent the path to a specific location in a tree of nested arrays.
        
        if isShowingIndexPaths {
            cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row) - \(name)"
        } else {
            cell.textLabel?.text = name
        }
        
        return cell
    }
}

