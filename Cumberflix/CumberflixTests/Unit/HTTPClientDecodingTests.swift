//
//  HTTPClientDecodingTests.swift
//  Cumberflix
//
//  Created by Deepak on 03/11/25.
//

import XCTest
@testable import Cumberflix

final class HTTPClientDecodingTests: XCTestCase {
    func testDecodesMovieList() async throws {
        let client = MockHTTPClient()
        client.nextData = TestData.movieListJSON

        let service = LiveMovieService(client: client, key: "IGNORED")
        let list = try await service.fetchMovies(page: 1)

        XCTAssertEqual(list.page, 1)
        XCTAssertEqual(list.results.count, 2)
        XCTAssertEqual(list.totalPages, 5)
        XCTAssertEqual(list.results.first?.id, 101)
    }

    func testClientPropagatesError() async {
        let client = MockHTTPClient()
        client.nextError = URLError(.timedOut)

        let service = LiveMovieService(client: client, key: "IGNORED")
        do {
            _ = try await service.fetchMovies(page: 1)
            XCTFail("Expected error")
        } catch let err as URLError {
            XCTAssertEqual(err.code, .timedOut)
        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }
}
