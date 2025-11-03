//
//  HTTPClient.swift
//  Cumberflix
//
//  Created by Deepak on 31/10/25.
//
import Foundation

protocol HTTPClient {
    func get<T: Decodable>(_ url: URL) async throws -> T
}

final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession = .shared
    private let decoder = JSONDecoder()

    func get<T: Decodable>(_ url: URL) async throws -> T {
        let request = URLRequest(url: url)
        let (data, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try decoder.decode(T.self, from: data)
    }
}
