//
//  ConstantsTests.swift
//  EntainTechnicalTask Tests
//
//  Created by Brett Best on 30/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

@testable import EntainTechnicalTask
import XCTest

final class ConstantsTests: XCTestCase {
  func testRunningUnitTestsDetection() throws {
    XCTAssertTrue(kIsRunningUnitTests)
  }

  func testAccessingNedsAPIBaseURLDoesntCrash() {
    XCTAssertEqual(kNedsAPIBaseURL.absoluteString, "https://api.neds.com.au/rest/v1/")
  }
}
