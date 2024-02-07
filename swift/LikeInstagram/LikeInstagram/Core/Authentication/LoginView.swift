//
//  LoginView.swift
//  LikeInstagram
//
//  Created by 加藤隆聖 on 2024/01/30.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                
                Image("test")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 220,height: 100)
                VStack{
                    TextField("メールアドレスを入れてください",text:$email)
                        .autocapitalization(.none)
                        .modifier(IGTextFieldModifier())
                    
                    SecureField("パスワードを入れてください",text:$email)
                        .modifier(IGTextFieldModifier())
                }
                
                Button{
                    print("パスワードを表示")
                } label: {
                    Text("パスワードを忘れた方")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing,28)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Button{
                    print("ログイン")
                } label: {
                    Text("ログイン")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 360,height: 44)
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                }
                .padding(.vertical)
                
                HStack{
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40 ,height: 0.5)
                    Text("または")
                        .font(.footnote)
                        .fontWeight(.semibold)

                    
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40 ,height: 0.5)
                }
                .foregroundColor(.gray)
                
                HStack{
                    Image("test")
                        .resizable()
                        .frame(width:20,height: 20)
                    Text("facebookで続ける")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                }
                .padding(.top,8)
                
                Spacer()
                Divider()
                
                NavigationLink{
                    AddEmailView()
                        .navigationBarBackButtonHidden(true)
                }label: {
                    HStack{
                        Text("アカウントを持っていないですか")
                        
                        Text("サインアップ")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                }
                .padding(.vertical,16)
            }
        }
    }
}

#Preview {
    LoginView()
}
