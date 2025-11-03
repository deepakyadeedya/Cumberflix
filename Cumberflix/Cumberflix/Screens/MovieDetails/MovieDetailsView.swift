//
//  MovieDetailsView.swift
//  Cumberflix
//
//  Created by Deepak on 31/10/25.
//
import SwiftUI

struct MovieDetailView: View {
    @StateObject private var vm: MovieDetailViewModel
    @Environment(\.dismiss) private var dismiss

    init(movie: Movie) {
        _vm = StateObject(wrappedValue: MovieDetailViewModel(movie: movie))
    }

    var body: some View {
        GeometryReader { geo in
            let maxContentWidth = min(geo.size.width * 0.9, 600)

            VStack(spacing: 0) {
                Text(vm.movie.title)
                    .font(.title.bold())
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .shadow(color: .black.opacity(0.05), radius: 2, y: 1)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        PosterView(path: vm.movie.posterPath)
                            .scaledToFit()
                            .frame(maxWidth: maxContentWidth)
                            .cornerRadius(10)
                            .shadow(radius: 4)
                            .padding(.top, 10)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Movie Synopsis")
                                .font(.headline)
                                .accessibilityIdentifier("OverviewSection")
                            if let overview = vm.movie.overview, !overview.isEmpty {
                                Text(overview)
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.leading)
                                    .accessibilityIdentifier("overviewText")
                            } else {
                                Text("No synopsis available.")
                                    .foregroundColor(.secondary)
                                    .italic()
                            }
                        }
                        .frame(maxWidth: maxContentWidth, alignment: .leading)
                        .padding(.horizontal, 16)

                        if !vm.similar.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Similar Movies")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                    .padding(.horizontal, 16)

                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(alignment: .top, spacing: 12) {
                                        ForEach(vm.similar) { movie in
                                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                                VStack(spacing: 6) {
                                                    PosterView(path: movie.posterPath)
                                                        .scaledToFit()
                                                        .frame(width: adaptiveCardWidth(for: geo.size.width),
                                                               height: adaptiveCardWidth(for: geo.size.width) * 1.5)
                                                        .cornerRadius(8)
                                                        .shadow(radius: 2)

                                                    Text(movie.title)
                                                        .font(.caption)
                                                        .foregroundColor(.primary)
                                                        .multilineTextAlignment(.center)
                                                        .frame(width: adaptiveCardWidth(for: geo.size.width),
                                                               height: 30)
                                                        .lineLimit(2)
                                                }
                                            }
                                            .buttonStyle(.plain)
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                }
                                .accessibilityIdentifier("SimilarScroll")
                            }
                            .frame(maxWidth: maxContentWidth)
                            .padding(.top, 8)
                        }
                    }
                    .padding(.bottom, 24)
                    .frame(maxWidth: .infinity)
                }
                .background(Color(.systemGroupedBackground))
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .gesture(DragGesture().onChanged { value in
            if value.translation.width > 100 { dismiss() }
        })
        .task { await vm.loadSimilar() }
    }

    private func adaptiveCardWidth(for screenWidth: CGFloat) -> CGFloat {
        if screenWidth < 600 {
            return 120
        } else if screenWidth < 900 {
            return 160
        } else {
            return 200 
        }
    }
}


