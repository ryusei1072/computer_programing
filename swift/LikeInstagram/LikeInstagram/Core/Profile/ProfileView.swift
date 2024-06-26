//
//  ProfileView.swift
//  LikeInstagram
//
//  Created by 加藤隆聖 on 2024/01/30.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    
    
    private let gridItems:[GridItem] = [
        .init(.flexible(),spacing: 1),
        .init(.flexible(),spacing: 1),
        .init(.flexible(),spacing: 1)
    ]
    
    var body: some View {
        
            ScrollView{
                //header
                VStack(spacing: 10){
                    HStack{
                        Image(user.profileImageUrl ?? "")
                            .resizable()
                            .scaledToFill()
                            .frame(width:80,height:80)
                            .clipShape(Circle())
                        Spacer()
                        HStack(spacing:8){
                            VStack{
                                Text("3")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text("想い")
                                    .font(.footnote)
                            }
                            .frame(width:72)
                            VStack{
                                Text("3")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text("寄り添い")
                                    .font(.footnote)
                            }
                            .frame(width:72)
                            VStack{
                                Text("3")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text("フォロー")
                                    .font(.footnote)
                            }
                            .frame(width:72)
                        }
                        
                    }
                    .padding(.horizontal)
                    
                    
                    VStack(alignment: .leading,spacing: 4){
                        if let fullname = user.fullname{
                            Text(fullname)
                                .font(.footnote)
                        }
                        if let bio = user.bio{
                            Text(bio)
                                .font(.footnote)
                        }
                    }
                    .frame(maxWidth:.infinity,alignment: .leading)
                    .padding(.horizontal)
                    
                    
                    Button{
                        
                    }label: {
                        Text("プロフィールを編集")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width: 360, height: 32)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.gray,lineWidth: 1)
                            )
                    }
                    
                    Divider()
                    
                }
                
                //post grid view
                LazyVGrid(columns: gridItems ,content: {
                    ForEach(0 ... 15, id: \.self){ index in
                        Image("test")
                            .resizable()
                            .scaledToFill()
                    }
                })
            }
            .navigationTitle("プロフィール")
            .navigationBarTitleDisplayMode(.inline)
                }
}

#Preview {
    ProfileView(user: User.MOCK_USERS[0])
}
