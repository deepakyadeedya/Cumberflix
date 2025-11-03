//
//  Movie.swift
//  Cumberflix
//
//  Created by Deepak on 31/10/25.
//

struct Movie: Decodable, Identifiable, Hashable {
    let id: Int
    let title: String
    let overview: String?
    let posterPath: String?
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
    }
}
