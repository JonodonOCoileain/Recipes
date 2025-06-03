//
//  RecipesDataModel.swift
//  Recipes
//
//  Created by Jonathan Lavallee Collins on 5/29/25.
//

import Foundation
import Combine

struct RequestData: Codable {
    let recipes: [Recipe]
}

class RecipesAPIRequestor {
    
    let endpoint1 = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"//https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    
    func requestRecipesAsync() async throws -> [Recipe] {
        let urlRequest: URLRequest = URLRequest(url: URL(string: endpoint1)!)
        do {
            let (data, response) = try await URLSession(configuration: .ephemeral).data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            let decodedRecipes = try JSONDecoder().decode(RequestData.self, from: data)
            return decodedRecipes.recipes
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func requestRecipesCombine() -> AnyPublisher<RequestData, Error> {
        URLSession.shared.dataTaskPublisher(for: URL(string: endpoint1)!)
            .map(\.data)
            .decode(type: RequestData.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
