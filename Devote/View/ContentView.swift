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
    @AppStorage(isDarkModeKey) private var isDarkMode: Bool = false
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
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack(spacing: 10) {
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        Spacer()
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule()
                                    .stroke(.white, lineWidth: 2)
                            )
                        Button {
                            isDarkMode.toggle()
                            playSound(sound: AudioSoundsEnum.soundTap)
                            hapticFeedback.notificationOccurred(.success)
                        } label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        }
                    }
                    .padding()
                    .foregroundStyle(.white)
                    Spacer(minLength: 80)
                    Button {
                        withAnimation {
                            showNewtaskItem.toggle()
                        }
                        playSound(sound: AudioSoundsEnum.soundDing)
                        hapticFeedback.notificationOccurred(.success)
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
                            ListRowItemView(item: item)
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
                // This is for the blur effect when user opens the new task creation modal
                .blur(radius: showNewtaskItem ? 8 : 0, opaque: false)
                .transition(.move(edge: .bottom))
                
                if showNewtaskItem {
                    BlankView(
                        backgroundColor: isDarkMode ? .black : .gray,
                        backgroundOpacity: isDarkMode ? 0.3 : 0.5
                    )
                    .onTapGesture {
                        withAnimation {
                            showNewtaskItem.toggle()
                        }
                    }
                    NewTaskItemView(isShowing: $showNewtaskItem)
                }
            }
            .background(
                BackgroundImageView()
                    .blur(radius: showNewtaskItem ? 8 : 0, opaque: false)
            )
            .background(backgroundGradient)
            .navigationTitle("Daily Tasks")
            .navigationBarTitleDisplayMode(.large)
            .toolbar(.hidden)
        }
    }
}

#Preview {
    @Previewable @AppStorage(isDarkModeKey) var isDarkMode: Bool = false
    let persistenceController = PersistenceController.preview
    
    ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
        .preferredColorScheme(isDarkMode ? .dark : .light)
}
