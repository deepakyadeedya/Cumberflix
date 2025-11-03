//
//  CumberflixMainFlowUITests.swift
//  CumberflixUITests
//
//  Created by Deepak on 31/10/25.
//

import XCTest

final class CumberflixMainFlowUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }


    func testMainFlow_ListToDetailAndBack() {
        let app = XCUIApplication()
        app.launch()

        let nav = app.navigationBars["Cumberflix"]
        XCTAssertTrue(nav.waitForExistence(timeout: 10))

        let scroll = app.scrollViews.firstMatch
        XCTAssertTrue(scroll.waitForExistence(timeout: 10))

        let firstImage = scroll.images.firstMatch
        XCTAssertTrue(firstImage.waitForExistence(timeout: 10))
        firstImage.tap()


        let overview = app.staticTexts["OverviewSection"]
        XCTAssertTrue(overview.waitForExistence(timeout: 10), "Expected Overview section on detail screen")

        let similarScroll = app.scrollViews["SimilarScroll"]
        XCTAssertTrue(similarScroll.waitForExistence(timeout: 10), "Expected similar-movies scroll")


        if app.navigationBars.buttons.firstMatch.exists {
            app.navigationBars.buttons.firstMatch.tap()
        } else {
            app.swipeRight()
        }

        XCTAssertTrue(nav.waitForExistence(timeout: 5))
    }




    func testLaunchPerformance() throws {

        guard #available(iOS 17.0, *) else { return }

        measure(metrics: [XCTApplicationLaunchMetric()]) {
            let app = XCUIApplication()
            app.launch()
        }
    }
}
