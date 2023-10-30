//
//  RaceSummaryDTO.swift
//  EntainTechnicalTask
//
//  Created by Brett Best on 30/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

import Foundation
import Tagged

struct RaceSummaryDTO: Decodable, Identifiable {
  typealias ID = Tagged<Self, UUID>
  typealias MeetingId = Tagged<(Self, meeting: ()), UUID>

  enum CodingKeys: String, CodingKey {
    case id = "race_id"
    case name = "race_name"
    case number = "race_number"
    case meetingId = "meeting_id"
    case meetingName = "meeting_name"
    case category = "category_id"
    case advertisedStart = "advertised_start"
  }

  let id: ID
  let name: String
  let number: UInt
  let meetingId: MeetingId
  let meetingName: String
  let category: RaceCategoryDTO
  let advertisedStart: AdvertisedStartDTO
}
