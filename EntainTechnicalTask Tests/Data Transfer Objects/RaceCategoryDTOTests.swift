//
//  RaceCategoryDTOTests.swift
//  EntainTechnicalTask Tests
//
//  Created by Brett Best on 30/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

@testable import EntainTechnicalTask
import XCTest

final class RaceCategoryDTOTests: XCTestCase {
  func testDecodingValidData() throws {
    /// Greyhound, Harness, Horse per API specification in task document
    let json = #"["9daef0d7-bf3c-4f50-921d-8e818c60fe61","161d9be2-e909-4326-8c2c-35ed71fb460b","4a2788f8-e825-4d36-9894-efd4baf1cfae"]"#

    let raceCategories = try JSONDecoder().decode([RaceCategoryDTO].self, from: Data(json.utf8))

    XCTAssertEqual(raceCategories, RaceCategoryDTO.allCases)
  }

  func testDecodingInvalidData() throws {
    let json = #"["9daef0d7-bf3c-4f50-921d-8e818c60fe61","13c56854-259e-47c3-b4fe-62d7fbbccb58"]"#

    XCTAssertThrowsError(try JSONDecoder().decode([RaceCategoryDTO].self, from: Data(json.utf8))) { error in
      guard case let DecodingError.dataCorrupted(context) = error else {
        XCTFail("Error unexpected type: \(type(of: error))")
        return
      }

      XCTAssertEqual(context.codingPath.map(\.intValue), [1])
      XCTAssertEqual(context.debugDescription, "Cannot initialize RaceCategoryDTO from invalid Tagged<RaceCategoryDTO, UUID> value 13C56854-259E-47C3-B4FE-62D7FBBCCB58")
    }
  }
}
