//
//  PersistencyController.swift
//  to-do-list
//
//  Created by Maks Niagolov on 01/04/2019.
//  Copyright © 2019 Maksim Niagolov. All rights reserved.
//

import Foundation
import RealmSwift

class PersistencyController {
    
    private init() { }
    
    static let sharedInstance = PersistencyController()
    
    static func all(in realm: Realm = try! Realm()) -> Results<ToDoItem> {
        return realm.objects(ToDoItem.self)
            .sorted(byKeyPath: ToDoItem.Property.isCompleted.rawValue)
    }
}