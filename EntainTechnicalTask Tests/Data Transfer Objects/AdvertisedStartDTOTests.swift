//
//  AdvertisedStartDTOTests.swift
//  EntainTechnicalTask Tests
//
//  Created by Brett Best on 30/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

@testable import EntainTechnicalTask
import XCTest

final class AdvertisedStartDTOTests: XCTestCase {
  func testDecodingValidData() throws {
    let json = #"{"seconds":1698649200}"#

    let advertisedStartDTO = try JSONDecoder().decode(AdvertisedStartDTO.self, from: Data(json.utf8))

    XCTAssertEqual(advertisedStartDTO.date.timeIntervalSince1970, 1_698_649_200)
  }
}
