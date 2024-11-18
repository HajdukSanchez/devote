//
//  ContentView.swift
//  Devote
//
//  Created by Jozek Andrzej Hajduk Sanchez on 28/10/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - Properties
    
    // Property to handle CRUD behavior with the entities
    @Environment(\.managedObjectContext) private var viewContext
    // Property to get the data that match the specific criterias we define
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State private var showNewtaskItem : Bool = false

    // MARK: - Functions
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer(minLength: 80)
                    Button {
                        withAnimation {
                            showNewtaskItem.toggle()
                        }
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.pink, .blue]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .clipShape(Capsule())
                    )
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0, y: 4)
                    List {
                        ForEach(items) { item in
                            NavigationLink {
                                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(item.task ?? "No task")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    Text(item.timestamp!, formatter: itemFormatter)
                                        .font(.footnote)
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .scrollContentBackground(.hidden) // Delete default Bg color on list
                    .shadow(
                        color: Color(red: 0, green: 0, blue: 0, opacity: 0.3),
                        radius: 12
                    )
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                }
                
                if showNewtaskItem {
                    BlankView()
                        .onTapGesture {
                            withAnimation {
                                showNewtaskItem.toggle()
                            }
                        }
                    NewTaskItemView(isShowing: $showNewtaskItem)
                }
            }
            .background(BackgroundImageView())
            .background(backgroundGradient)
            .navigationTitle("Daily Tasks")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
