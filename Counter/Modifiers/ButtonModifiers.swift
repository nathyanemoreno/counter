//
//  ButtonModifiers.swift
//  Counter
//
//  Created by Nathyane Moreno on 14/02/25.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .buttonStyle(PlainButtonStyle())
            .padding()
            .background(.accent)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .foregroundStyle(.white)
    }
}

extension View {
    public func primaryButton() -> some View {
        modifier(ButtonModifier())
    }
}
