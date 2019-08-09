//
//  ItemController.swift
//  ShoppingList
//
//  Created by Cameron Stuart on 8/9/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import Foundation
import CoreData

class ItemController {
    
    // Singleton
    static let shared = ItemController()
    
    // Local Variable
    var fetchedResultsController: NSFetchedResultsController<Item>
    
    init() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        let resultsController: NSFetchedResultsController<Item> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController = resultsController
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error performing fetch")
        }
    }
    
    //MARK: - CRUD Functions
    
    // Create
    func createItem(name: String, isComplete: Bool) {
        Item(name: name, isComplete: isComplete)
        saveToPersistentStore()
    }
    
    // Update
    func updateItem(item: Item, isComplete: Bool) {
        item.isComplete.toggle()
        saveToPersistentStore()
    }
    
    // Delete
    func remove(item: Item) {
        if let itemToRemove = item.managedObjectContext {
            itemToRemove.delete(item)
            saveToPersistentStore()
        }
    }
    
    //MARK: - Persistence
    private func saveToPersistentStore() {
        if CoreDataStack.context.hasChanges {
            try? CoreDataStack.context.save()
        }
    }
}
