//
//  ContentView.swift
//  omoi
//
//  Created by 加藤隆聖 on 2024/01/27.
//

import SwiftUI
import AVFoundation

struct Post {
    let message: String
    var bouquets: Int = 0
    var comments: [String] = []
}

struct ContentView: View {
    @State private var posts: [Post] = []
    @State private var newPost: String = ""
    @State private var bouquetCount: Int = 0
    @State private var activePostIndex: Int? = nil
    @State private var newComment: String = ""

    var body: some View {
        ZStack {
            Image("test")
                .resizable()
                .scaledToFill()
                .frame(width:100 ,height: 500)

            VStack {
                ScrollView {
                    ForEach(posts.indices, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(posts[index].message)
                                .padding()
                                .background(Color.white.opacity(0.5))
                                .cornerRadius(10)
                                .onTapGesture {
                                    activePostIndex = activePostIndex == index ? nil : index
                                }

                            if activePostIndex == index {
                                VStack(alignment: .leading, spacing: 5) {
                                    ForEach(posts[index].comments, id: \.self) { comment in
                                        Text(comment)
                                            .padding(.all, 10)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(8)
                                    }
                                    .padding(.leading, 20)

                                    HStack {
                                        TextField("コメントを入力", text: $newComment)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())

                                        Button("送信") {
                                            addComment(to: index)
                                        }
                                    }

                                    Button("花束を投げる") {
                                        throwBouquet(to: index)
                                    }
                                }
                                .padding(.top, 10)
                                .background(Color.white.opacity(0.3))
                                .cornerRadius(10)
                            }
                        }
                        .padding(.bottom, 10)
                    }
                }

                HStack {
                    TextField("悩みを入力", text: $newPost)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(action: postNew) {
                        Text("投稿")
                    }
                }.padding()

                HStack {
                    Text("花束: \(bouquetCount)")
                }
            }
        }
    }

    private func postNew() {
        if !newPost.isEmpty {
            posts.insert(Post(message: newPost), at: 0)
            newPost = ""
            playSoundAndVibrate()
        }
    }

    private func addComment(to index: Int) {
        if !newComment.isEmpty {
            posts[index].comments.append(newComment)
            newComment = ""
        }
    }

    private func throwBouquet(to index: Int) {
        if bouquetCount > 0 {
            posts[index].bouquets += 1
            bouquetCount -= 1
        }
    }

    private func playSoundAndVibrate() {
        // バイブレーションを発生させる
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}
