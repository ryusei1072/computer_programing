//
//  ContentView.swift
//  Music
//
//  Created by 加藤隆聖 on 2024/01/26.
//

import SwiftUI

struct ContentView: View {
    
    let soundPlayer = SoundPlayer()
    
    var body: some View {
        ZStack{
            Image(.background)
                .backgroundModifier()
            
            
            HStack{
                Button{
                    soundPlayer.cymbalPlay()
                }label: {
                    Image(.cymbal)
                }
                
                Button{
                    soundPlayer.guitarPlay()
                }label: {
                    Image(.guitar)
                }
            }
            
            
            
        }
        
        
        
        
    }
}

#Preview {
    ContentView()
}
