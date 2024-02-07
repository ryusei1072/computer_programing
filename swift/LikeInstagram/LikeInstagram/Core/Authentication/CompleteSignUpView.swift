//
//  CompleteSignUpView.swift
//  LikeInstagram
//
//  Created by 加藤隆聖 on 2024/02/05.
//

import SwiftUI

struct CompleteSignUpView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        VStack{
            Spacer()
            Text("omoiへようこそ")
                .font(.title2)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            
            Text("下をクリックし登録を完了しomoiを始めましょう")
                .font(.footnote)
                
                .multilineTextAlignment(.center)
                .padding(.horizontal,24)
            
            
            Button {
                print("サインアップ完了")
            } label: {
                Text("サインアップ完了")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 360,height: 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
            }
            .padding(.vertical)
            
            
            
            Spacer()
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture{
                        dismiss()
                    }
            }
        }
    }
}

#Preview {
    CompleteSignUpView()
}
