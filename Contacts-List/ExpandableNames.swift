//
//  ExpandableNames.swift
//  Contacts-List
//
//  Created by Amaan on 2018-02-15.
//  Copyright © 2018 amaancan. All rights reserved.
//

import Foundation

struct ExpandableNames {
    var isExpanded: Bool
    var names: [Contact]
}

struct Contact {
    let name: String
    var hasFavourited: Bool
}
