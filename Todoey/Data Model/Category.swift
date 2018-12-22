//
//  Category.swift
//  Todoey
//
//  Created by Hina Ali on 12/18/18.
//  Copyright © 2018 Hina Khalid. All rights reserved.
//

import Foundation
import RealmSwift
class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
