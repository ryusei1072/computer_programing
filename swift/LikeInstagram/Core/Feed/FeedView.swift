//
//  FeedView.swift
//  LikeInstagram
//
//  Created by 加藤隆聖 on 2024/01/30.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVStack{
                    ForEach(0 ... 10, id: \.self){ post in
                        Feedcell()
                    }
                }
            }
            .navigationTitle("投稿")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(palacement: .navigationBarLeading) {
                    Image("test")
                        .resizable()
                        .frame(width:100,height: 32)
                }
            }
        }
    }
}

#Preview {
    FeedView()
}
