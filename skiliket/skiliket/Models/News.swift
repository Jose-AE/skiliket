//
//  News.swift
//  skiliket
//
//  Created by Rosa Palacios on 10/10/24.
//

import Foundation

struct News: Codable {
    let imageUrl: String
    let title: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case title, description
    }
}
