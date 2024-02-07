//
//  CreatePasswordView.swift
//  LikeInstagram
//
//  Created by 加藤隆聖 on 2024/02/05.
//

import SwiftUI

struct CreatePasswordView: View {
    @State private var password = ""
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Text("パスワードを作成")
                .font(.title2)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.top)
            Text("パスワードは6文字以上にしてください")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal,24)
            
            SecureField("パスワード",text: $password)
                .autocapitalization(.none)
                .modifier(IGTextFieldModifier())
                .padding(.top)
            
            NavigationLink {
                CompleteSignUpView()
                                    .navigationBarBackButtonHidden(true)
            } label: {
                Text("次へ")
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
    CreatePasswordView()
}
