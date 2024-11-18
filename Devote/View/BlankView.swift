//
//  BlankView.swift
//  Devote
//
//  Created by Jozek Andrzej Hajduk Sanchez on 17/11/24.
//

import SwiftUI

struct BlankView: View {
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.black)
        .opacity(0.5)
        .ignoresSafeArea()
    }
}

#Preview {
    BlankView()
}
