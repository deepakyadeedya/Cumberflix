//
//  TestData.swift
//  Cumberflix
//
//  Created by Deepak on 01/11/25.
//
import Foundation
@testable import Cumberflix

enum TestData {
    static let movieListJSON = """
    {
        "page": 1,
        "results": [
            {
                "id": 101,
                "title": "Mock Movie",
                "overview": "A test movie for unit testing.",
                "poster_path": "/poster.jpg"
            },
            {
                "id": 102,
                "title": "Another Mock",
                "overview": "Another example.",
                "poster_path": "/poster2.jpg"
            }
        ],
        "total_pages": 5
    }
    """.data(using: .utf8)!
}
