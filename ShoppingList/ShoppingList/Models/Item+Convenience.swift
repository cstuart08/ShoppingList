//
//  Item+Convenience.swift
//  ShoppingList
//
//  Created by Cameron Stuart on 8/9/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    
    @discardableResult
    convenience init(name: String, isComplete: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        
        self.name = name
        self.isComplete = isComplete
    }
}
