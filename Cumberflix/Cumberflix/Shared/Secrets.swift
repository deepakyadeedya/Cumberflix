//
//  Secrets.swift
//  Cumberflix
//
//  Created by Deepak on 31/10/25.
//

import Foundation

enum Secrets {
    static var tmdbKey: String {
       
        if let key = Bundle.main.object(forInfoDictionaryKey: "TMDB_API_KEY") as? String {
            return key
        }
        return ProcessInfo.processInfo.environment["TMDB_API_KEY"] ?? "MISSING_TMDB_KEY"
    }
}
