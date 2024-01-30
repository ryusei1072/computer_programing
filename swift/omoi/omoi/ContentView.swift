//
//  ContentView.swift
//  omoi
//
//  Created by 加藤隆聖 on 2024/01/27.
//

import SwiftUI
import AVFoundation
import AudioToolbox

import SwiftUI

struct Tweet: Identifiable {
    let id = UUID()
    var username: String
    var content: String
    var likes: Int = 0
}

struct ContentView: View {
    @State private var tweets: [Tweet] = []
    @State private var content: String = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("何をつぶやく?", text: $content)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("ツイート") {
                        tweet()
                    }
                }.padding()

                List(tweets) { tweet in
                    VStack(alignment: .leading) {
                        Text("@\(tweet.username)").fontWeight(.bold)
                        Text(tweet.content)
                        HStack {
                            Text("いいね: \(tweet.likes)")
                            Spacer()
                            Button("いいね") {
                                if let index = tweets.firstIndex(where: { $0.id == tweet.id }) {
                                    tweets[index].likes += 1
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("ツイート")
        }
    }

    private func tweet() {
        let newTweet = Tweet(username: "ユーザー", content: content)
        tweets.insert(newTweet, at: 0)
        content = ""
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
