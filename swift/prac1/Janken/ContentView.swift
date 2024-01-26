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
            Spacer()
            if jankenNumber == 0{
                Text("これからじゃんけんをします！")
                    .padding(.bottom)
            } else if jankenNumber == 1{
                Image(.gu)
                    .resizable()
                    .scaledToFit()
                Spacer()
                Text("グー")
                    .padding(.bottom)
            } else if jankenNumber == 2{
                Image(.choki)
                    .resizable()
                    .scaledToFit()
                Spacer()
                Text("チョキ")
                    .padding(.bottom)
            } else{
                Image(.pa)
                    .resizable()
                    .scaledToFit()
                Spacer()
                Text("パー")
                    .padding(.bottom)
            }
            
            
            Button(action: {
                var newjankenNumber = 0
                
                repeat{
                    newjankenNumber = Int.random(in: 1...3)
                }while jankenNumber == newjankenNumber
                jankenNumber = newjankenNumber
                
            }, label: {
                Text("じゃんけんポイ")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    .font(.title)
                    .background(.pink)
                    .foregroundColor(.white)
                
            })
        }
        
        
    }
}

#Preview {
    ContentView()
}
