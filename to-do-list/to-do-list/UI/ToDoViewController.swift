//
//  ToDoViewController.swift
//  to-do-list
//
//  Created by Maks Niagolov on 01/04/2019.
//  Copyright © 2019 Maksim Niagolov. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoViewController: UITableViewController {
    
    private var items: Results<ToDoItem>?
    
    private var itemsToken: NotificationToken?
    
    // MARK: - ViewController life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemsToken = items?.observe { [weak tableView] changes in
            guard let tableView = tableView else { return }
            
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let updates):
                tableView.applyChanges(deletions: deletions, insertions: insertions, updates: updates)
            case .error: break
            }
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        itemsToken?.invalidate()
    }
    
    // MARK: - Private Methods
    
    func configureView() {
        items = PersistencyController.sharedInstance.all()
    }
    
    func bindViewModel() {
        
    }
    
    func toggleItem(_ item: ToDoItem) {
        PersistencyController.sharedInstance.toggleCompleted(item: item)
    }
    
    func deleteItem(_ item: ToDoItem) {
        PersistencyController.sharedInstance.delete(item: item)
    }
    
    // MARK: - Actions
    
    @IBAction func addItem() {
        
        userInputAlert("Add Todo Item") { text in
            PersistencyController.sharedInstance.add(text: text)
        }
        
    }
}

// MARK: - Table View Data Source

extension ToDoViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ToDoTableViewCell,
            let item = items?[indexPath.row] else {
                return ToDoTableViewCell(frame: .zero)
        }
        
        cell.configureWith(item) { [weak self] item in
            self?.toggleItem(item)
        }
        
        return cell
    }
}

// MARK: - Table View Delegate

extension ToDoViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = items?[indexPath.row] else { return }
        userInputAlert("Edit Todo Item", text: item.text) { text in
            PersistencyController.sharedInstance.update(item: item, text: text)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let item = items?[indexPath.row],
            editingStyle == .delete else { return }
        deleteItem(item)
    }
}
