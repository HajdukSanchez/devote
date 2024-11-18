//
//  Constants.swift
//  Devote
//
//  Created by Jozek Hajduk on 4/11/24.
//

import SwiftUI

// MARK: - Formatter
let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// MARK: - UI
var backgroundGradient: LinearGradient {
    return LinearGradient(
        gradient: Gradient(colors: [Color.pink, Color.blue]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

// MARK: - UX

// MARK: - App Storage constants
let isDarkModeKey: String = "isDarkMode"
