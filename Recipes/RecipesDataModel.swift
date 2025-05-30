//
//  RecipesDataModel.swift
//  Recipes
//
//  Created by Jonathan Lavallee Collins on 5/29/25.
//

import Foundation

struct RequestData: Codable {
    let recipes: [Recipe]
}

class RecipesDataModel {
    
    let endpoint1 = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"//https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    
    func requestRecipes() async throws -> [Recipe] {
        let urlRequest: URLRequest = URLRequest(url: URL(string: endpoint1)!)
        do {
            let data = try await URLSession(configuration: .ephemeral).data(for: urlRequest).0
            let decodedRecipes = try JSONDecoder().decode(RequestData.self, from: data)
            return decodedRecipes.recipes
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
