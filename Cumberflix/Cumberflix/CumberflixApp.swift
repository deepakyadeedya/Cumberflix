//
//  CumberflixApp.swift
//  Cumberflix
//
//  Created by Deepak on 31/10/25.
//
import SwiftUI

@main
struct CumberflixApp: App {
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashView()
                        .transition(.opacity)
                } else {
                    MovieListView()
                }
            }
            .onAppear {
                withAnimation(.easeOut(duration: 1.0)) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        showSplash = false
                    }
                }
            }
        }
    }
}
struct SplashView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
                Text("Cumberflix")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.primary)
        }
    }
}
