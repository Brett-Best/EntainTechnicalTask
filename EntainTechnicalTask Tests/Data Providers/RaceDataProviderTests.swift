//
//  RaceDataProviderTests.swift
//  EntainTechnicalTask Tests
//
//  Created by Brett Best on 30/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

@testable import EntainTechnicalTask
import XCTest

final class RaceDataProviderTests: XCTestCase {
  func testFetchNextRacesURL() {
    let dataProvider = RaceDataProvider(baseURL: URL(string: "https://entain.api/").unsafelyUnwrapped)

    XCTAssertEqual(dataProvider.fetchNextRacesURL(count: 10).absoluteString, "https://entain.api/racing/?method=nextraces&count=10")
    XCTAssertEqual(dataProvider.fetchNextRacesURL(count: 5).absoluteString, "https://entain.api/racing/?method=nextraces&count=5")
  }
}
