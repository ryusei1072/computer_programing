//
//  Feedcell.swift
//  LikeInstagram
//
//  Created by 加藤隆聖 on 2024/01/30.
//

import SwiftUI

struct Feedcell: View {
    var body: some View {
        VStack{
            HStack{
                Image("test")
                    .resizable()
                    .scaledToFill()
                    .frame(width:40,height: 40)
                    .clipShape(Circle())
                Text("test")
                    .font(.footnote)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.leading)
            
            //post image
            Image("test")
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipShape(Rectangle())
            
            HStack(spacing:16){
                Button{
                    print("いいね")
                }label: {
                    Image(systemName: "heart")
                }
                
                Button{
                    print("コメント")
                }label: {
                    Image(systemName:"bubble.right")
                }
                Button{
                    print("共有")
                }label: {
                    Image(systemName: "paperplane")
                }
                Spacer()
            }
            .padding(.leading,8)
            .padding(.top, 4)
            .foregroundColor(.black)
            
            Text("23like")
                .font(.footnote)
                .fontWeight(.semibold)
                .frame(maxWidth:.infinity,alignment: .leading)
                .padding(.leading,10)
                .padding(.top,1)
            
            HStack{
                Text("焚き火") +
                Text("this is some test caption")
            }
            .font(.footnote)
            .frame(maxWidth:.infinity,alignment: .leading)
            .padding(.leading,10)
            .padding(.top,1)
            
            Text("６時間前")
                .font(.footnote)
                .fontWeight(.semibold)
                .frame(maxWidth:.infinity,alignment: .leading)
                .padding(.leading,10)
                .padding(.top,1)
                .foregroundColor(.gray)
            
            
            
        }
    }
}

#Preview {
    Feedcell()
}
