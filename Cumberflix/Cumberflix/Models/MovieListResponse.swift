//
//  MovieListResponse.swift
//  Cumberflix
//
//  Created by Deepak on 31/10/25.
//
import Foundation

struct MovieListResponse: Decodable {
    var page: Int
    var results: [Movie]
    var totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}
