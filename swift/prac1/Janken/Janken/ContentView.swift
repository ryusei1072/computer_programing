//
//  ContentView.swift
//  Janken
//
//  Created by 加藤隆聖 on 2024/01/26.
//

import SwiftUI

struct ContentView: View {
    
    @State var jankenNumber = 0
    
    var body: some View {
        VStack {
            
            if jankenNumber == 0{
                    Text("これからじゃんけんをします")
            } else if jankenNumber == 1{
                Image(.gu)
                    .resizable()
                    .scaledToFit()
                Text("グー")
            } else if jankenNumber == 2{
                Image(.choki)
                    .resizable()
                    .scaledToFit()
                Text("チョキ")
            } else{
                Image(.pa)
                    .resizable()
                    .scaledToFit()
                Text("パー")
            }
            
            
            Button(action: {
                jankenNumber = Int.random(in: 1...3)
            }, label: {
                Text("じゃんけんをする")
            })
        }
        
        
    }
}

#Preview {
    ContentView()
}
