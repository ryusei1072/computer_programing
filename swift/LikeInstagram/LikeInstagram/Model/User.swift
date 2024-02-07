//
//  User.swift
//  LikeInstagram
//
//  Created by 加藤隆聖 on 2024/02/05.
//

import Foundation
struct User: Identifiable, Hashable{
    let id: String
    var username: String
    var profileImageUrl:String?
    var fullname: String?
    var bio: String?
    let email: String
}

extension User{
    static var MOCK_USERS:[User] = [
        .init(id: NSUUID().uuidString, username: "batman", profileImageUrl: "test", fullname: "Bruce Wayne", bio: "Gotham's Dark Knight", email: "batman@gmail.com"),
        .init(id: NSUUID().uuidString, username: "bat", profileImageUrl: "test2", fullname: "Bruce Wayne", bio: "Gotham's Dark Knight", email: "batman@gmail.com"),
        .init(id: NSUUID().uuidString, username: "man", profileImageUrl: "test3", fullname: "Bruce Wayne", bio: "Gotham's Dark Knight", email: "batman@gmail.com"),
        .init(id: NSUUID().uuidString, username: "batman", profileImageUrl: "test", fullname: "Bruce Wayne", bio: "Gotham's Dark Knight", email: "batman@gmail.com"),
        .init(id: NSUUID().uuidString, username: "batman", profileImageUrl: "test", fullname: "Bruce Wayne", bio: "Gotham's Dark Knight", email: "batman@gmail.com"),
    
    
    ]
}
