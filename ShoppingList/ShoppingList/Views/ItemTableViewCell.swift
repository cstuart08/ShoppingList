//
//  ItemTableViewCell.swift
//  ShoppingList
//
//  Created by Cameron Stuart on 8/9/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

protocol ItemTableViewCellDelegate {
    func itemIsCompleteButtonTapped(_ sender: ItemTableViewCell)
}

class ItemTableViewCell: UITableViewCell {

    var delegate: ItemTableViewCellDelegate?
    
    // Outlets
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemCompletionButton: UIButton!

    func updateCheckBox(item: Item) {
        if item.isComplete {
            itemCompletionButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        } else {
            itemCompletionButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        }
    }

    // Actions
    @IBAction func itemCompletionButtonTapped(_ sender: UIButton) {
        delegate?.itemIsCompleteButtonTapped(self)
    }
}
