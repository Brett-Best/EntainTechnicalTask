//
//  UUID+CodingKeyRepresentable.swift
//  EntainTechnicalTask
//
//  Created by Brett Best on 30/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

import Foundation

extension UUID: CodingKeyRepresentable {
  public var codingKey: CodingKey {
    uuidString.codingKey
  }

  public init?(codingKey: some CodingKey) {
    self.init(uuidString: codingKey.stringValue)
  }
}
