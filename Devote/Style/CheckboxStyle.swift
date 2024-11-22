//
//  CheckboxStyle.swift
//  Devote
//
//  Created by Jozek Andrzej Hajduk Sanchez on 22/11/24.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
                .strikethrough(configuration.isOn)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        Toggle("Placehodler label On", isOn: .constant(true))
            .toggleStyle(CheckboxStyle())
        Toggle("Placehodler label Off", isOn: .constant(false))
            .toggleStyle(CheckboxStyle())
    }
}
