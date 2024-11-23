//
//  BlankView.swift
//  Devote
//
//  Created by Jozek Andrzej Hajduk Sanchez on 17/11/24.
//

import SwiftUI

struct BlankView: View {
    
    // MARK: - Properties
    var backgroundColor: Color
    var backgroundOpacity: Double
    
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(backgroundColor)
        .opacity(backgroundOpacity)
        .blendMode(.overlay)
        .ignoresSafeArea()
    }
}

#Preview {
    BlankView(backgroundColor: .black, backgroundOpacity: 0.3)
        .background(
            BackgroundImageView()
                .blur(radius: 8, opaque: false)
        )
        .background(backgroundGradient.ignoresSafeArea())
}
