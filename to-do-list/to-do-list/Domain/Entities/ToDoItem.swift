//
//  ToDoItem.swift
//  to-do-list
//
//  Created by Maks Niagolov on 31/03/2019.
//  Copyright © 2019 Maksim Niagolov. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class ToDoItem: Object {
    enum Property: String {
        case id, text, isCompleted
    }
    
    dynamic var id = UUID().uuidString
    dynamic var text = ""
    dynamic var isCompleted = false
    
    override static func primaryKey() -> String? {
        return ToDoItem.Property.id.rawValue
    }
    
    convenience init(_ text: String) {
        self.init()
        self.text = text
    }
}
