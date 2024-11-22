//
//  PreviewConstants.swift
//  Devote
//
//  Created by Jozek Andrzej Hajduk Sanchez on 17/11/24.
//

import Foundation

extension PersistenceController {
    var previewItem: Item {
        let context = self.container.viewContext
        
        // Creating item for preview
        let newItem = Item(context: context)
        newItem.timestamp = Date()
        newItem.task = "New Task preview"
        newItem.completion = false
        newItem.id = UUID()
        
        return newItem
    }
}
