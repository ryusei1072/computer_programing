//
//  UserStatView.swift
//  LikeInstagram
//
//  Created by 加藤隆聖 on 2024/01/30.
//

import SwiftUI

struct UserStatView: View {
    let value: Int
    let title: String
    
    var body: some View {
        VStack{
            Text("\(value)")
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(title)
                .font(.footnote)
        }
    }
}

#Preview {
    UserStatView(value: 12, title: "想い")
}
