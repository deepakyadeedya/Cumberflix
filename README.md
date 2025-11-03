# 🎬 Cumberflix – TELUS Health Mobile Engineering Challenge

**Author:** Deepak Yadeedya  
**Email:** [deepakyadeedya@gmail.com](mailto:deepakyadeedya@gmail.com)  
**Platform:** iOS (Swift / SwiftUI)  
**Time Spent:** ~3 hours  

---

## 🧭 Overview

Cumberflix is a native iOS app built as part of the **TELUS Health Virtual Care Mobile Engineering Challenge**.  
The app showcases **movies starring Benedict Cumberbatch**, using **The Movie Database (TMDB)** API.  

The focus was on writing clean, modular, and production-ready code — emphasizing architecture, readability, and scalability over UI polish.

---

## 🧑‍💻 User Stories Implemented

### ✅ User Story 1 – Movie List
- Displays all movies featuring **Benedict Cumberbatch**.
- Each cell shows:
  - Movie poster thumbnail  
  - Movie title  
- Data fetched using:  
  `GET /discover/movie?with_people=71580`

### ✅ User Story 2 – Movie Details
- On selecting a movie, a detail screen shows:
  - Title  
  - Poster  
  - Synopsis (overview)  
- Data fetched using:  
  `GET /movie/{id}`

### ⚙️ (Optional) User Story 3 – Similar Movies
- When available, the detail screen shows similar movies.  
- Selecting one pushes another detail view (recursive navigation).  
- Data fetched using:  
  `GET /movie/{id}/similar`

---

## 🏗️ Architecture

**Pattern:** MVVM (Model-View-ViewModel)  
**Layers:**
- **Models:** Codable structs for TMDB responses.  
- **ViewModels:** Async/await network calls + data formatting.  
- **Views:** SwiftUI components for list and details.  
- **Networking:** Reusable `NetworkManager` with generic decoding.  

---

## 🧩 Tech Stack

| Component | Library / Framework | Why Used |
|------------|--------------------|-----------|
| Networking | `URLSession` + `async/await` | Native, lightweight, async-safe |
| Image Loading | `AsyncImage` (SwiftUI) | Simple image loading from TMDB |
| Architecture | `MVVM` | Testable, modular, and scalable |
| Unit Testing | `XCTest` | For validating ViewModel logic and decoding |

---

## 🔑 TMDB API Setup

1. Create a TMDB account  
2. Get an API key from: [TMDB Developer Portal](https://developers.themoviedb.org/3/getting-started/introduction)  
3. Add your key in `NetworkManager.swift`:

```swift
let apiKey = "YOUR_API_KEY"
let baseURL = "https://api.themoviedb.org/3"
