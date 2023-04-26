//
//  User.swift
//  UseSkeleton
//
//  Created by JeongminKim on 2023/04/26.
//

import Foundation

struct User {
    let name: String
    let email: String
    let avatarUrl: String
    
    static var mock: User {
        .init(name: "JM Kim", email: "JmKim@jjmail.com", avatarUrl: "https://images.unsplash.com/photo-1517849845537-4d257902454a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZG9nfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60")
    }
}
