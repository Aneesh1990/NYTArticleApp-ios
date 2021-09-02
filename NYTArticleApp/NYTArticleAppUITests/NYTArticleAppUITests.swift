//
//  NYTArticleAppUITests.swift
//  NYTArticleAppUITests
//
//  Created by Aneesh on 01/09/2021.
//

import XCTest

class NYTArticleAppUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    func testPeriodChange() {
        XCUIApplication().buttons["Period"].tap()
        let app = XCUIApplication()
        app.sheets.buttons["30"].tap()
    }
    func testDetailScreen() {
        let app = XCUIApplication()
        let cell = app.cells.element(matching: .cell, identifier: "Cell_0")
        cell.tap()
    }

}
