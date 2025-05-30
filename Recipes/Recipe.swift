//
//  Recipe.swift
//  Recipes
//
//  Created by Jonathan Lavallee Collins on 5/29/25.
//

struct Recipe: Codable, Identifiable {
    var id: String { uuid }
    let uuid: String
    let cuisine: String
    let name: String
    let photo_url_large: String?
    let photo_url_small: String?
    let source_url: String?
    let youtube_url: String?
}
