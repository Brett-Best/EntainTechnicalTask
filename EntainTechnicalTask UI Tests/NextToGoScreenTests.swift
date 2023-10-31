//
//  NextToGoScreenTests.swift
//  EntainTechnicalTask UI Tests
//
//  Created by Brett Best on 31/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

import XCTest

final class NextToGoScreenTests: XCTestCase {
  override func setUpWithError() throws {
    continueAfterFailure = false
  }

  @MainActor
  func testNextToGoScreenSuccessState() async throws {
    let app = XCUIApplication()
    app.launch()

    try await Task.sleep(for: .seconds(5))

    XCTAssertEqual(app.cells.count, 5) // Check that 5 races display
    XCTAssertEqual(app.navigationBars.count, 1) // Check we have a navigation bar
    XCTAssertEqual(app.tabBars.count, 1) // Check we have a tab bar
    XCTAssertEqual(app.navigationBars.toolbarButtons.count, 1) // Check the filter button is present
  }
}
