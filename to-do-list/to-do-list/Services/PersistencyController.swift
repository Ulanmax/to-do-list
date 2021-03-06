//
//  PersistencyController.swift
//  to-do-list
//
//  Created by Maks Niagolov on 01/04/2019.
//  Copyright © 2019 Maksim Niagolov. All rights reserved.
//

import Foundation
import RealmSwift
import RxRealm
import RxSwift

class PersistencyController {
    
    private init() { }
    
    static let sharedInstance = PersistencyController()
    
    func all(in realm: Realm = try! Realm()) -> Results<ToDoItem> {
        return realm.objects(ToDoItem.self)
            .sorted(byKeyPath: ToDoItem.Property.isCompleted.rawValue)
    }
    
    @discardableResult
    func add(text: String, in realm: Realm = try! Realm())
        -> ToDoItem {
            let item = ToDoItem(text)
            try! realm.write {
                realm.add(item)
            }
            return item
    }
    
    func update(item: ToDoItem, text: String) {
        guard let realm = item.realm else { return }
        try! realm.write {
            item.text = text
        }
    }
    
    func delete(item: ToDoItem) {
        guard let realm = item.realm else { return }
        try! realm.write {
            realm.delete(item)
        }
    }
    
    func toggleCompleted(item: ToDoItem) {
        guard let realm = item.realm else { return }
        try! realm.write {
            item.isCompleted = !item.isCompleted
        }
    }

}
