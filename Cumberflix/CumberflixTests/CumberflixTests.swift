//
//  CumberflixTests.swift
//  CumberflixTests
//
//  Created by Deepak on 31/10/25.
//

import XCTest
@testable import Cumberflix

final class CumberflixTests: XCTestCase {

    func testMovieListDecoding() throws {
           let response = try JSONDecoder().decode(MovieListResponse.self, from: TestData.movieListJSON)
           XCTAssertEqual(response.page, 1)
           XCTAssertEqual(response.results.count, 2)
           XCTAssertEqual(response.results.first?.title, "Mock Movie")
       }

}
