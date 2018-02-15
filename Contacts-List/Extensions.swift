//
//  Extensions.swift
//  Contacts-List
//
//  Created by Amaan on 2018-02-14.
//  Copyright © 2018 amaancan. All rights reserved.
//

import Foundation

extension Bool {
    mutating func toggle() -> Bool {
        self = !self
        return self
    }
}
