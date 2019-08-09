//
//  ItemTableViewController.swift
//  ShoppingList
//
//  Created by Cameron Stuart on 8/9/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit
import CoreData

class ItemTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ItemController.shared.fetchedResultsController.delegate = self
    }
    
    // Actions
    
    @IBAction func addItemButtonTapped(_ sender: Any) {
        newItem()
    }
    
    // Helper Methods
    func newItem() {
        let alert = UIAlertController(title: "Add New Item", message: "What would you like to add?", preferredStyle: .alert)
        alert.addTextField { (UITextField) in
        }
            
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            guard let newItem = alert.textFields?[0].text else { return }
            ItemController.shared.createItem(name: newItem, isComplete: false)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemController.shared.fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemTableViewCell else { return UITableViewCell() }
     
        let item = ItemController.shared.fetchedResultsController.object(at: indexPath)
        cell.itemNameLabel.text = item.name
        cell.updateCheckBox(item: item)
        cell.delegate = self
     return cell
     }
    
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
        guard let cellToDelete = ItemController.shared.fetchedResultsController.fetchedObjects?[indexPath.row] else { return }
        ItemController.shared.remove(item: cellToDelete)
     }
    }
}

extension ItemTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
            
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }
}

extension ItemTableViewController: ItemTableViewCellDelegate {
    func itemIsCompleteButtonTapped(_ sender: ItemTableViewCell) {
        guard let index = tableView.indexPath(for: sender) else { return }
        let item = ItemController.shared.fetchedResultsController.object(at: index)
        ItemController.shared.updateItem(item: item, isComplete: item.isComplete)
        sender.updateCheckBox(item: item)
    }
}
