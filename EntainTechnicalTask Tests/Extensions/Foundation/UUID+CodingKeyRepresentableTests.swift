//
//  UUID+CodingKeyRepresentableTests.swift
//  EntainTechnicalTask Tests
//
//  Created by Brett Best on 30/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

@testable import EntainTechnicalTask
import XCTest

final class UUIDCodingKeyRepresentableTests: XCTestCase {
  func testCodingKeyPassthrough() {
    let uuid = UUID(uuidString: "F064FE47-D32F-477C-BF8F-04C38512B96D").unsafelyUnwrapped
    XCTAssertEqual(uuid.codingKey.stringValue, "F064FE47-D32F-477C-BF8F-04C38512B96D")
  }

  func testInitCodingKey() {
    let uuid = UUID()

    XCTAssertEqual(uuid, UUID(codingKey: uuid.codingKey))
  }
}
