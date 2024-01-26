//
//  SoundPlayer.swift
//  Music
//
//  Created by 加藤隆聖 on 2024/01/27.
//

import UIKit
import AVFoundation

class SoundPlayer: NSObject {
    
    let cymbalData = NSDataAsset(name: "cymbalSound")!.data
    var cymbalPlayer: AVAudioPlayer!
    
    
    func cymbalPlay(){
        do{
            cymbalPlayer = try AVAudioPlayer(data: cymbalData)
            cymbalPlayer.play()
        }catch{
            print("シンバルで、エラーが発生しました")
        }
    }
    
    let guitarData = NSDataAsset(name: "guitarSound")!.data
    var guitarPlayer: AVAudioPlayer!
    
    func guitarPlay(){
        do{
            guitarPlayer = try AVAudioPlayer(data: guitarData)
            guitarPlayer.play()
        }catch{
            print("シンバルで、エラーが発生しました")
        }
    }
}
