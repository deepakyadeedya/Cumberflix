//
//  MovieEndpoints.swift
//  Cumberflix
//
//  Created by Deepak on 31/10/25.
//
import Foundation

enum MovieEndpoints {
    private static let base = URL(string: "https://api.themoviedb.org/3")!

    static func getMovieList(page: Int, apiKey: String) -> URL {
        var comps = URLComponents(url: base.appendingPathComponent("discover/movie"), resolvingAgainstBaseURL: false)!
        comps.queryItems = [
            .init(name: "api_key", value: apiKey),
            .init(name: "with_people", value: "71580"),
            .init(name: "sort_by", value: "popularity.desc"),
            .init(name: "page", value: String(page))
        ]
        return comps.url!
    }

    static func movieDetail(id: Int, apiKey: String) -> URL {
        var comps = URLComponents(url: base.appendingPathComponent("movie/\(id)"), resolvingAgainstBaseURL: false)!
        comps.queryItems = [.init(name: "api_key", value: apiKey)]
        return comps.url!
    }

    static func similarMovies(id: Int, page: Int = 1, apiKey: String) -> URL {
        var comps = URLComponents(url: base.appendingPathComponent("movie/\(id)/similar"), resolvingAgainstBaseURL: false)!
        comps.queryItems = [
            .init(name: "api_key", value: apiKey),
            .init(name: "page", value: String(page))
        ]
        return comps.url!
    }
}
