//
//  StubMovieService.swift
//  Cumberflix
//
//  Created by Deepak on 03/11/25.
//

import Foundation
@testable import Cumberflix

final class StubMovieService: MovieService {
    var movieList: MovieListResponse?
    var movieDetail: Movie?
    var similarList: MovieListResponse?
    var error: Error?

    func fetchMovies(page: Int) async throws -> MovieListResponse {
        if let error { throw error }
        guard let movieList else { throw URLError(.badServerResponse) }
        return movieList
    }

    func fetchMovieDetail(id: Int) async throws -> Movie {
        if let error { throw error }
        guard let movieDetail else { throw URLError(.badServerResponse) }
        return movieDetail
    }

    func fetchSimilarMovies(id: Int, page: Int) async throws -> MovieListResponse {
        if let error { throw error }
        guard let similarList else { throw URLError(.badServerResponse) }
        return similarList
    }
}

