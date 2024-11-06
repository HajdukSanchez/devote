//
//  BackgroundImageView.swift
//  Devote
//
//  Created by Jozek Andrzej Hajduk Sanchez on 5/11/24.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
        Image("rocket")
            .antialiased(true)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundImageView()
}
