//
//  MovieListViewModel.swift
//  Cumberflix
//
//  Created by Deepak on 31/10/25.
//

import Foundation

@MainActor
final class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service: MovieService
    private var currentPage = 1

    init(service: MovieService = LiveMovieService()) {
        self.service = service
    }

    func loadMovies(fromStart: Bool) async {
        if fromStart {
            movies.removeAll()
            currentPage = 1
        }

        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil

        do {
            let response = try await service.fetchMovies(page: currentPage)
            movies.append(contentsOf: response.results)
            currentPage += 1
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func loadMoreIfNeeded(current movie: Movie) async {
        guard let last = movies.last, last.id == movie.id else { return }
        await loadMovies(fromStart: false)
    }
}
