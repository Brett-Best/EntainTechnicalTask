//
//  HTTPResponseDTOTests.swift
//  EntainTechnicalTask Tests
//
//  Created by Brett Best on 30/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

@testable import EntainTechnicalTask
import XCTest

final class HTTPResponseDTOTests: XCTestCase {
  func testDecodingValidData() throws {
    let json = #"{"status":200,"data":"Some data","message":"A message"}"#

    let httpResponseDTO = try JSONDecoder().decode(HTTPResponseDTO<String>.self, from: Data(json.utf8))

    XCTAssertEqual(httpResponseDTO.status, 200)
    XCTAssertEqual(httpResponseDTO.data, "Some data")
    XCTAssertEqual(httpResponseDTO.message, "A message")
  }
}
