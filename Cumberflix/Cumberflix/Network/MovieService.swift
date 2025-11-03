//
//  MovieService.swift
//  Cumberflix
//
//  Created by Deepak on 31/10/25.
//

import Foundation

protocol MovieService {
    func fetchMovies(page: Int) async throws -> MovieListResponse
    func fetchMovieDetail(id: Int) async throws -> Movie
    func fetchSimilarMovies(id: Int, page: Int) async throws -> MovieListResponse
}

final class LiveMovieService: MovieService {
    private let client: HTTPClient
    private let key: String

    init(client: HTTPClient = URLSessionHTTPClient(), key: String = Secrets.tmdbKey) {
        self.client = client
        self.key = key
    }

    func fetchMovies(page: Int = 3) async throws -> MovieListResponse {
        let url = MovieEndpoints.getMovieList(page: page, apiKey: key)
        return try await client.get(url)
    }

    func fetchMovieDetail(id: Int) async throws -> Movie {
        let url = MovieEndpoints.movieDetail(id: id, apiKey: key)
        return try await client.get(url)
    }

    func fetchSimilarMovies(id: Int, page: Int) async throws -> MovieListResponse {
        let url = MovieEndpoints.similarMovies(id: id, page: page, apiKey: key)
        return try await client.get(url)
    }
}
