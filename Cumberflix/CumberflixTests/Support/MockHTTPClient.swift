//
//  MockHTTPClient.swift
//  Cumberflix
//
//  Created by Deepak on 03/11/25.
//

import Foundation
@testable import Cumberflix

final class MockHTTPClient: HTTPClient {
    enum StubError: Error { case notStubbed }

    var nextData: Data?
    var nextError: Error?

    func get<T: Decodable>(_ url: URL) async throws -> T {
        if let error = nextError { throw error }
        guard let data = nextData else { throw StubError.notStubbed }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
