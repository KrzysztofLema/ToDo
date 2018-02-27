//
//  Category.swift
//  ToDo
//
//  Created by Krzysztof Lema on 27.02.2018.
//  Copyright © 2018 Krzysztof Lema. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name:String = ""
    let items = List<Item>()
    
}
