//
//  MainTabView.swift
//  LikeInstagram
//
//  Created by 加藤隆聖 on 2024/01/30.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView{
            Text("ホーム")
                .tabItem {
                    Image(systemName:"house")
                }
            Text("検索")
                .tabItem {
                    Image(systemName:"magnifyingglass")
                }
            Text("投稿")
                .tabItem {
                    Image(systemName:"plus.square")
                }
            Text("通知")
                .tabItem {
                    Image(systemName:"heart")
                }
            Text("プロファイル")
                .tabItem {
                    Image(systemName:"person")
                }
        }
        .accentColor(.black)
    }
}

#Preview {
    MainTabView()
}
