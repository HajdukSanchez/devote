//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Jozek Hajduk on 4/11/24.
//

import SwiftUI

// Code will run only if we import UIKit
#if canImport(UIKit)
extension View {
    // Function to dismiss the keyboard after specific action
    func hideKeyboard() {
        UIApplication.shared
            .sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
