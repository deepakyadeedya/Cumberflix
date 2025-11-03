//
//  MovieListView.swift
//  Cumberflix
//
//  Created by Deepak on 31/10/25.
//
import SwiftUI

struct MovieListView: View {
    @StateObject private var vm = MovieListViewModel()

    private var gridColumns: [GridItem] {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return [GridItem(.adaptive(minimum: 300), spacing: 20)]
        } else {
            return [GridItem(.flexible())]
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridColumns, spacing: 16) {
                    ForEach(vm.movies, id: \.id) { movie in
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            VStack {
                                MovieRowView(movie: movie)
                                    .frame(maxWidth: .infinity)
                                    .onAppear {
                                        Task {
                                            await vm.loadMoreIfNeeded(current: movie)
                                        }
                                    }
                            }
                            .accessibilityIdentifier("MovieCell_\(movie.id)")
                        }
                        .buttonStyle(.plain)
                    }

                    if vm.isLoading {
                        ProgressView("Loading…")
                            .padding(.top, 20)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(16)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Cumberflix")
            .navigationBarTitleDisplayMode(.large)
            .task {
                await vm.loadMovies(fromStart: true)
            }
            .accessibilityIdentifier("MovieGrid")
        }
    }
}


