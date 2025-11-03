//
//  MovieListViewModelBehaviorTests.swift
//  Cumberflix
//
//  Created by Deepak on 03/11/25.
//
import XCTest
@testable import Cumberflix

@MainActor
final class MovieListViewModelBehaviorTests: XCTestCase {

    func testLoadMoreIfNeededAppends() async throws {
        let stub = StubMovieService()
        let first = try JSONDecoder().decode(MovieListResponse.self, from: TestData.movieListJSON)
        let second = MovieListResponse(
            page: 2,
            results: first.results.map {
                Movie(id: $0.id + 2000,
                      title: "\($0.title) 2",
                      overview: $0.overview,
                      posterPath: $0.posterPath)
            },
            totalPages: 5
        )

        stub.movieList = first
        let vm = MovieListViewModel(service: stub)

        await vm.loadMovies(fromStart: true)

        guard let last = vm.movies.last else {
            XCTFail("Expected movies to be loaded, but got empty list")
            return
        }

        stub.movieList = second
        await vm.loadMoreIfNeeded(current: last)

        XCTAssertEqual(vm.movies.count, 4)
    }
}




