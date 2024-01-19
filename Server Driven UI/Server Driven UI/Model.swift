//
//  Model.swift
//  Server Driven UI
//
//  Created by Chionia Kotsalidou on 30/05/2023.
//

import Foundation

struct Screen: Codable {
    var screenTitle: String
    var screenElements: [ScreenElement]
}

struct ScreenElement: Codable {
    var type: ElementType
    var textData: TextData?
    var backgroundColor: String?
    var collectionData: [CollectionData]?
    var isSmall: Bool?
}

struct CollectionData: Codable {
    var imageURL: String?
    var textData: TextData?
}

struct TextData: Codable {
    var text: String?
    var textSize: Int?
    var textColor: String?
}

enum ElementType: String, Codable {
    case label
    case image
    case collection
}
