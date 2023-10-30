//
//  NextRacesDTO.swift
//  EntainTechnicalTask
//
//  Created by Brett Best on 30/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

import Foundation

struct NextRacesDTO: Decodable {
  enum CodingKeys: String, CodingKey {
    case nextToGoIds = "next_to_go_ids"
    case raceSummaries = "race_summaries"
  }

  let nextToGoIds: [RaceSummaryDTO.ID]
  let raceSummaries: [RaceSummaryDTO.ID: RaceSummaryDTO]
}
