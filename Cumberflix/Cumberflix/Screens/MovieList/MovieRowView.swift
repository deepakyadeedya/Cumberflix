//
//  MovieRowView.swift
//  Cumberflix
//
//  Created by Deepak on 31/10/25.
//
import SwiftUI


struct MovieRowView: View {
    let movie: Movie

    var body: some View {
        HStack(spacing: 16) {

            PosterView(path: movie.posterPath)
                .frame(width: 80, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 2, y: 1)

            Text(movie.title)
                .font(.headline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(2)
                .minimumScaleFactor(0.9)
        }
        .frame(maxWidth: .infinity, minHeight: 120, alignment: .center)
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                )
        )
        .contentShape(Rectangle()) 
    }
}

