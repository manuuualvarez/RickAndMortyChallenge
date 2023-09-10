//
//  RickAndMortyUITests.swift
//  RickAndMortyUITests
//
//  Created by Manny Alvarez on 07/09/2023.
//

import XCTest

final class RickAndMortyUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }
    func testWhenAppLauncPresentTheHomeScreenWithCorrectNavigationTitle() throws {
        setUp()
        let navigationTitle = app.staticTexts["Rick & Morty"]
        XCTAssert(navigationTitle.waitForExistence(timeout: 0.2))
    }
    
    func testExample() {
        setUp()

    }
    
}
