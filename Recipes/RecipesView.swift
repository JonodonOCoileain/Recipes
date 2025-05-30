//
//  ContentView.swift
//  Recipes
//
//  Created by Jonathan Lavallee Collins on 5/29/25.
//

import SwiftUI

struct RecipesView: View {
    private let model = RecipesDataModel()
    @State private var selectedRecipe: Recipe?
    @State private var recipes: [Recipe] = []
    
    var body: some View {
        if recipes.count == 0 {
            VStack {
                Spacer()
                Text("No recipes available")
                Spacer()
            }
        }
        ScrollView {
            VStack {
                ForEach(recipes) { recipe in
                    HStack {
                        if let urlString = recipe.photo_url_small, let url = URL(string: urlString) {
                            AsyncImage(url: url){ result in
                                result.image?
                                    .resizable()
                                    .scaledToFill()
                            }
                            .frame(width: 150, height: 150)
                        }
                        VStack(alignment: .leading) {
                            Text(recipe.name)
                            Text(recipe.cuisine).font(.caption)
                        }
                        Spacer()
                    }
                    .onTapGesture {
                        selectedRecipe = recipe
                    }
                }
            }
            .padding()
        }
        .task {
            do {
                recipes = try await model.requestRecipes()
            } catch {
                print(error.localizedDescription)
            }
        }
        .sheet(item: $selectedRecipe, content: { recipe in
            RecipeDetailView(recipe: recipe)
        })
    }
}

#Preview {
    RecipesView()
}
