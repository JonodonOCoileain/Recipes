//
//  RecipeDetailView.swift
//  Recipes
//
//  Created by Jonathan Lavallee Collins on 5/29/25.
//


import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if let photo_url_large = recipe.photo_url_large, let imageURL = URL(string: photo_url_large) {
                    AsyncImage(url: imageURL){ result in
                        result.image?
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.width)
                }
                Text(recipe.name)
                    .padding(.top)
                    .font(.title)
                Text(recipe.cuisine)
                if let urlString = recipe.source_url, let url = URL(string: urlString) {
                    Link("Source", destination: url)
                }
                if let urlString = recipe.youtube_url, let url = URL(string: urlString) {
                    Link("YouTube Video", destination: url)
                }
            }
        }
    }
}
