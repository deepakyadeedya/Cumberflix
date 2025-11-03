//
//  MovieEndpointsTests.swift
//  Cumberflix
//
//  Created by Deepak on 03/11/25.
//

import XCTest
@testable import Cumberflix

final class MovieEndpointsTests: XCTestCase {
    func testGetMovieList_hasBasePathAndQuery() {
        let url = MovieEndpoints.getMovieList(page: 3, apiKey: "ABC")
        let comps = URLComponents(url: url, resolvingAgainstBaseURL: false)!

        XCTAssertEqual(comps.path, "/3/discover/movie")
        let qs = Dictionary(uniqueKeysWithValues: (comps.queryItems ?? []).map { ($0.name, $0.value ?? "") })
        XCTAssertEqual(qs["api_key"], "ABC")
        XCTAssertEqual(qs["page"], "3")
        XCTAssertEqual(qs["sort_by"], "popularity.desc")
    }

    func testMovieDetail_hasId() {
        let url = MovieEndpoints.movieDetail(id: 123, apiKey: "K")
        XCTAssertTrue(url.absoluteString.contains("/3/movie/123"))
        XCTAssertTrue(url.absoluteString.contains("api_key=K"))
    }

    func testSimilar_hasIdAndPage() {
        let url = MovieEndpoints.similarMovies(id: 777, page: 5, apiKey: "KEY")
        XCTAssertTrue(url.absoluteString.contains("/3/movie/777/similar"))
        XCTAssertTrue(url.absoluteString.contains("page=5"))
        XCTAssertTrue(url.absoluteString.contains("api_key=KEY"))
    }
}
