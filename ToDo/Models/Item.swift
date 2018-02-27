//
//  Item.swift
//  ToDo

//  Created by Krzysztof Lema on 27.02.2018.
//  Copyright © 2018 Krzysztof Lema. All rights reserved.
//

import Foundation
import RealmSwift
class Item: Object {
    @objc dynamic var title:String = ""
    @objc dynamic var done:Bool = false
    @objc dynamic var dateCreated:Date?
    var paretCategory=LinkingObjects(fromType: Category.self, property: "items")
}

