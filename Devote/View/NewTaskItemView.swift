//
//  NewTaskItemView.swift
//  Devote
//
//  Created by Jozek Andrzej Hajduk Sanchez on 5/11/24.
//

import SwiftUI

struct NewTaskItemView: View {
    
    // MARK: - Properties
    @AppStorage(isDarkModeKey) private var isDarkMode: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @State private var taskText: String = ""
    private var isButtonDisabled: Bool {
        taskText.isEmpty
    }
    @Binding var isShowing: Bool
    
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
            isShowing = false
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                TextField("New Task", text: $taskText)
                    .foregroundStyle(.pink)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Button {
                    addItem()
                } label: {
                    Spacer()
                    Text("SAVE")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Spacer()
                }
                .disabled(isButtonDisabled)
                .padding()
                .foregroundStyle(.white)
                .background(isButtonDisabled ? .blue: .pink)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(
                isDarkMode ? Color(UIColor.secondarySystemBackground) : Color.white
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
            .frame(maxWidth: 640)
        }
        .padding()
    }
}

#Preview {
    NewTaskItemView(isShowing: .constant(true))
        .background(
            Color.gray
        )
}
