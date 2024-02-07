//
//  IGTextFieldModifier.swift
//  LikeInstagram
//
//  Created by 加藤隆聖 on 2024/02/05.
//

import SwiftUI

struct IGTextFieldModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal,24)
    }
}
