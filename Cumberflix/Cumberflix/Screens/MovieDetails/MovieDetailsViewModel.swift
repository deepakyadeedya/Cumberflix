//
//  MovieDetailsViewModel.swift
//  Cumberflix
//
//  Created by Deepak on 31/10/25.
//
import Foundation

@MainActor
final class MovieDetailViewModel: ObservableObject {
    @Published var movie: Movie
    @Published var similar: [Movie] = []
    @Published var errorMessage: String?

    private let service: MovieService

    init(movie: Movie, service: MovieService = LiveMovieService()) {
        self.movie = movie
        self.service = service
    }

    func loadSimilar() async { 
           do {
               let response = try await service.fetchSimilarMovies(id: movie.id, page: 1)
               similar = response.results
               errorMessage = nil
           } catch {
               errorMessage = error.localizedDescription
               similar = []
           }
       }
}

