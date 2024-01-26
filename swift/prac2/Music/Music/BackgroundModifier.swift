//
//  BackgroundModifier.swift
//  Music
//
//  Created by 加藤隆聖 on 2024/01/27.
//

import SwiftUI

extension Image{
    func backgroundModifier() -> some View{
        self
            .resizable()
            .ignoresSafeArea()
            .scaledToFill()
    }
}
