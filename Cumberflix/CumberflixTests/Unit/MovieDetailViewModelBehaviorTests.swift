//
//  MovieDetailViewModelBehaviorTests.swift
//  Cumberflix
//
//  Created by Deepak on 03/11/25.
//

import XCTest
@testable import Cumberflix

@MainActor
final class MovieDetailViewModelBehaviorTests: XCTestCase {

    func testLoadSimilarUpdatesList() async throws {
        let stub = StubMovieService()
        let base = try JSONDecoder().decode(MovieListResponse.self, from: TestData.movieListJSON)
        stub.similarList = base

        let vm = MovieDetailViewModel(movie: base.results[0], service: stub)
        await vm.loadSimilar()

        XCTAssertEqual(vm.similar.count, base.results.count)
        XCTAssertNil(vm.errorMessage)
    }

    func testErrorSetsMessage() async {
        let stub = StubMovieService()
        stub.error = URLError(.cannotFindHost)

        let vm = MovieDetailViewModel(
            movie: Movie(id: 1, title: "X", overview: nil, posterPath: nil),
            service: stub
        )

        await vm.loadSimilar() 

        XCTAssertNotNil(vm.errorMessage)
        XCTAssertTrue(vm.similar.isEmpty)
    }
}

