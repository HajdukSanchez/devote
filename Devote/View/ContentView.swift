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
    
    @State var taskText: String = ""
    private var isButtonDisabled: Bool {
        taskText.isEmpty
    }

    // MARK: - Functions
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = taskText
            newItem.completion = false
            newItem.id = UUID()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            taskText = ""
            hideKeyboard()
        }
    }

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
                    VStack(spacing: 16) {
                        TextField("New Task", text: $taskText)
                            .padding()
                            .background(
                                Color(UIColor.systemGray6)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        Button {
                            addItem()
                        } label: {
                            Spacer()
                            Text("SAVE")
                            Spacer()
                        }
                        .disabled(isButtonDisabled)
                        .padding()
                        .font(.headline)
                        .foregroundStyle(.white)
                        .background(isButtonDisabled ? .gray: .pink)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding()
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
