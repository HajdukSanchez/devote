//
//  ListRowItemView.swift
//  Devote
//
//  Created by Jozek Andrzej Hajduk Sanchez on 17/11/24.
//

import SwiftUI

struct ListRowItemView: View {
    
    // MARK: - Propeties
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var item: Item
    
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundStyle(item.completion ? .pink : .primary)
                .padding(.vertical, 12)
        }
        .onReceive(item.objectWillChange) { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        }
        .toggleStyle(CheckboxStyle())
    }
}

#Preview {
    let persistenceController = PersistenceController.preview
    
    ListRowItemView(item: persistenceController.previewItem)
        .padding()
}
