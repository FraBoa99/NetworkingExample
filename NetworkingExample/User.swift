//
//  User.swift
//  NetworkingExample
//
//  Created by Josh on 18/11/2019.
//  Copyright © 2019 Dstech. All rights reserved.
//

import Foundation

struct PageUser: Decodable {
    let page, perPage, total, totalPages: Int
    let data: [User]
    
    
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data
    }

}

struct User: Decodable {
    var id: Int
    var email: String
    var firstName: String
    var lastName: String
    var avatar: String

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}



