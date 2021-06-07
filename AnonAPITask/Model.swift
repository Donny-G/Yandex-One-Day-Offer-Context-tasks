//
//  Model.swift
//  AnonAPITask
//
//  Created by DeNNiO   G on 07.06.2021.
//

import Foundation

struct AnonStruct: Codable {
    let data: Data
}

struct Data: Codable {
    let items: [Item]
    let cursor: String?
}

struct Item: Codable, Identifiable {
    let id: String
    let type: ItemType.RawValue
    let isCommentable, hasAdultContent: Bool
    let language: Language.RawValue
    let createdAt: Int
    let isSecret: Bool
    let isMyFavorite: Bool
    let contents: [Content]
    let author: Author
    
    enum CodingKeys: String, CodingKey {
        case id, type, isCommentable, hasAdultContent, contents, language, createdAt, isSecret, author, isMyFavorite
    }
}

enum Language: String, Codable {
    case en = "en"
    case ru = "ru"
}

enum ItemType: String, Codable {
    case audioCover = "AUDIO_COVER"
    case plain = "PLAIN"
    case video = "VIDEO"
}


struct Author: Codable {
    let id: String
    let name: String
    let gender: Gender.RawValue
    let statistics: Statistics
}

enum Gender: String, Codable {
    case male = "MALE"
    case unset = "UNSET"
    case other = "OTHER"
}

struct Statistics: Codable {
    let likes: Int
    let thanks: Double
}

struct Content: Codable, Identifiable {
    let data: ContentData
    let id: String?
    let type:MMType.RawValue
}

struct ContentData: Codable {
    let value: String?
    let extraSmall, small, original, medium, large, extraLarge: MMContent?
    let url: String?
    
}

struct MMContent: Codable {
    let url: String
   
}

enum MMType: String, Codable {
    case image = "IMAGE"
    case imageGIF = "IMAGE_GIF"
    case tags = "TAGS"
    case text = "TEXT"
    case video = "VIDEO"
    case audio = "AUDIO"
}

