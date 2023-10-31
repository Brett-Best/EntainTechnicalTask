//
//  AdvertisedStartDTO.swift
//  EntainTechnicalTask
//
//  Created by Brett Best on 30/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

import Foundation

struct AdvertisedStartDTO: Decodable {
  enum CodingKeys: String, CodingKey {
    case seconds
  }

  let date: Date
}

extension AdvertisedStartDTO {
  init(from decoder: Decoder) throws {
    let singleValueContainer = try decoder.container(keyedBy: CodingKeys.self)

    date = Date(timeIntervalSince1970: try singleValueContainer.decode(TimeInterval.self, forKey: .seconds))
  }
}
