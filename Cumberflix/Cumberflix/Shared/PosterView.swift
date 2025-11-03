//
//  PosterView.swift
//  Cumberflix
//
//  Created by Deepak on 31/10/25.
//

import SwiftUI

struct PosterView: View {
    let path: String?

    var body: some View {
        Group {
            if let path,
               let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)") {

                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .transition(.opacity)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 0.3)) { }
                            }

                    case .failure:
                        placeholder

                    case .empty:
                        ProgressView()

                    @unknown default:
                        placeholder
                    }
                }

            } else {
                placeholder
            }
        }
        .background(Color.gray.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 3, y: 2)
    }

    private var placeholder: some View {
        ZStack {
            Color.gray.opacity(0.12)
            Image(systemName: "film")
                .imageScale(.large)
                .opacity(0.5)
        }
    }
}
