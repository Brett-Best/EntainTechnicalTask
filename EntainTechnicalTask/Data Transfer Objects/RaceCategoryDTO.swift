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
    ID(UUID(uuid: uuid))
  }

  /// Low level representation of the constantly defined identifiers, we use `uuid_t` to avoid needing to forcefully unwrap `UUID(uuidString:)`, when time permits, a macro could be written to simplify this
  private var uuid: uuid_t {
    switch self {
    case .greyhound: return (0x9d, 0xae, 0xf0, 0xd7, 0xbf, 0x3c, 0x4f, 0x50, 0x92, 0x1d, 0x8e, 0x81, 0x8c, 0x60, 0xfe, 0x61) /// Greyhound UUID: `9daef0d7-bf3c-4f50-921d-8e818c60fe61`
    case .harness: return (0x16, 0x1d, 0x9b, 0xe2, 0xe9, 0x09, 0x43, 0x26, 0x8c, 0x2c, 0x35, 0xed, 0x71, 0xfb, 0x46, 0x0b) /// Harness UUID: `161d9be2-e909-4326-8c2c-35ed71fb460b`
    case .horse: return (0x4a, 0x27, 0x88, 0xf8, 0xe8, 0x25, 0x4d, 0x36, 0x98, 0x94, 0xef, 0xd4, 0xba, 0xf1, 0xcf, 0xae) /// Horse UUID: `4a2788f8-e825-4d36-9894-efd4baf1cfae`
    }
  }

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
