//
//  ContactCell.swift
//  Contacts-List
//
//  Created by Amaan on 2018-02-15.
//  Copyright © 2018 amaancan. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
   
    // Favouriting: step 1 of 5
    var delegate: ViewController? // reference VC to mark as favourite
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //make a custom button and set it as the accessoryView - it's a hacky shortcut
        let starbutton = UIButton(type: .system)
        starbutton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        starbutton.setImage(#imageLiteral(resourceName: "star-grey") , for: .normal)
        starbutton.tintColor = .red
        
        starbutton.addTarget(self, action: #selector(handleMakeFavourite), for: .touchUpInside)
        
        accessoryView = starbutton
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleMakeFavourite() {
       delegate?.markFavourite(cell: self) // Favouriting: step 2 of 5
    }
    
}
