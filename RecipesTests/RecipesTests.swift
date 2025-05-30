//
//  RecipesTests.swift
//  RecipesTests
//
//  Created by Jonathan Lavallee Collins on 5/29/25.
//

import Testing
import XCTest
@testable import Recipes

struct RecipesTests {

    @Test func example() async throws {
        let dataModel = RecipesDataModel()
        do {
            let data = try await dataModel.requestRecipes()
            XCTAssertTrue(data.count > 0)
        } catch {
            print(error)
        }
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

}
