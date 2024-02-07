//
//  CreateUsernameView.swift
//  LikeInstagram
//
//  Created by 加藤隆聖 on 2024/02/05.
//

import SwiftUI

struct CreateUsernameView: View {
    @State private var username = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Text("ユーザー名を入れてください")
                .font(.title2)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.top)
            Text("アカウントにログインするためにメールアドレスが必要です")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal,24)
            
            TextField("メールアドレス",text: $username)
                .autocapitalization(.none)
                .modifier(IGTextFieldModifier())
            
            NavigationLink {
                CreatePasswordView()
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
    CreateUsernameView()
}
