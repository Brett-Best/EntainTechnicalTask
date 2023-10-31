//
//  RaceCategoryDTO.swift
//  EntainTechnicalTask
//
//  Created by Brett Best on 30/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

import Foundation
import Tagged

enum RaceCategoryDTO: Decodable, Identifiable, CaseIterable {
  case greyhound
  case harness
  case horse

  typealias ID = Tagged<Self, UUID>

  var id: ID {
    /// We could create a macro that uses the `UUID(uuid: uuid_t)` initializer so that we don't need to deal with the optional returned by `UUID(uuidString:)` initializer
    /// E.g. `#UUID(uuidString: "9daef0d7-bf3c-4f50-921d-8e818c60fe61")` which would return `UUID` instead of `UUID?`

    let uuid = switch self {
    case .greyhound: UUID(uuidString: "9daef0d7-bf3c-4f50-921d-8e818c60fe61").unsafelyUnwrapped
    case .harness: UUID(uuidString: "161d9be2-e909-4326-8c2c-35ed71fb460b").unsafelyUnwrapped
    case .horse: UUID(uuidString: "4a2788f8-e825-4d36-9894-efd4baf1cfae").unsafelyUnwrapped
    }

    return ID(uuid)
  }

  /// Low level representation of the constantly defined identifiers, we use `uuid_t` to avoid needing to forcefully unwrap `UUID(uuidString:)`, when time permits, a macro could be written to simplify this

  var title: String {
    switch self {
    case .greyhound: return "Greyhound"
    case .harness: return "Harness"
    case .horse: return "Horse"
    }
  }

  var systemImage: String {
    switch self {
    case .greyhound: return "dog"
    case .harness: return "tortoise"
    case .horse: return "hare"
    }
  }

  init(from decoder: Decoder) throws {
    let singleValueContainer = try decoder.singleValueContainer()
    let id = try singleValueContainer.decode(ID.self)

    self = switch id {
    case Self.greyhound.id: .greyhound
    case Self.harness.id: .harness
    case Self.horse.id: .horse
    default: throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Cannot initialize \(Self.self) from invalid \(ID.self) value \(id)"))
    }
  }
}
