//
//  ExpandableNames.swift
//  Contacts-List
//
//  Created by Amaan on 2018-02-15.
//  Copyright © 2018 amaancan. All rights reserved.
//

import Foundation
import Contacts

struct ExpandableNames {
    var isExpanded: Bool
    var names: [FavouritableContact]
}

struct FavouritableContact {
    let contact: CNContact
    var hasFavourited: Bool
}
