//
//  NextRacesDTOTests.swift
//  EntainTechnicalTask Tests
//
//  Created by Brett Best on 30/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

@testable import EntainTechnicalTask
import XCTest

final class NextRacesDTOTests: XCTestCase {
  // swiftlint:disable:next function_body_length
  func testDecodingValidData() throws {
    // swiftlint:disable line_length
    let json =
    #"""
    {
      "next_to_go_ids": [
        "58054f84-a9f5-4110-b2c6-4458e4322c68"
      ],
      "race_summaries": {
        "58054f84-a9f5-4110-b2c6-4458e4322c68": {
          "race_id": "58054f84-a9f5-4110-b2c6-4458e4322c68",
          "race_name": "Face Racing & Supplies Division1",
          "race_number": 2,
          "meeting_id": "2a60f6ff-f3aa-41cb-b8f8-e8ea38ad38c0",
          "meeting_name": "Launceston",
          "category_id": "9daef0d7-bf3c-4f50-921d-8e818c60fe61",
          "advertised_start": {
            "seconds": 1698655800
          },
          "race_form": {
            "distance": 515,
            "distance_type": {
              "id": "570775ae-09ec-42d5-989d-7c8f06366aa7",
              "name": "Metres",
              "short_name": "m"
            },
            "distance_type_id": "570775ae-09ec-42d5-989d-7c8f06366aa7",
            "track_condition": {
              "id": "10a14653-a33d-11e7-810d-0a1a4ae29bd2",
              "name": "Good",
              "short_name": "good"
            },
            "track_condition_id": "10a14653-a33d-11e7-810d-0a1a4ae29bd2",
            "weather": {
              "id": "06ee9afc-025e-11ec-a4cc-4a1fbbf2f065",
              "name": "SHWRY",
              "short_name": "shwry",
              "icon_uri": "SHWRY"
            },
            "weather_id": "06ee9afc-025e-11ec-a4cc-4a1fbbf2f065",
            "race_comment": "VINTAGE CLASS (5) placed in a Grade 6 when a 5 length second this course and distance last time in a personal Best Time (30.06) and also clocked one of the quickest times on the card. Happy to have her on top here. MISS ISABEL (2) turned in a moderate run last time when fifth at Hobart over 461m behind Ruby And Rice (26.71) in a Grade 6. Better than last start and can bounce back. WHISKEY TURBO (7) had a tricky draw and ran into the minors beaten 4.5 lengths (19.67) at Hobart in Grade 6. Has been out the placings in all two runs here. The form out of last race has been strong. Leading chance. MISS EVEREST (4) hit the frame here last time and looks a chance again.",
            "additional_data": "{\"revealed_race_info\":{\"track_name\":\"Launceston\",\"state\":\"TAS\",\"country\":\"AUS\",\"number\":2,\"race_name\":\"Face Racing \\u0026 Supplies Division1\",\"time\":\"2023-10-30T08:50:00Z\"}}",
            "generated": 1,
            "silk_base_url": "drr38safykj6s.cloudfront.net",
            "race_comment_alternative": "VINTAGE CLASS (5) placed in a Grade 6 when a 5 length second this course and distance last time in a personal Best Time (30.06) and also clocked one of the quickest times on the card. Happy to have her on top here. MISS ISABEL (2) turned in a moderate run last time when fifth at Hobart over 461m behind Ruby And Rice (26.71) in a Grade 6. Better than last start and can bounce back. WHISKEY TURBO (7) had a tricky draw and ran into the minors beaten 4.5 lengths (19.67) at Hobart in Grade 6. Has been out the placings in all two runs here. The form out of last race has been strong. Leading chance. MISS EVEREST (4) hit the frame here last time and looks a chance again."
          },
          "venue_id": "0eb684d3-8701-4458-b88e-a6b6a15582cb",
          "venue_name": "Launceston",
          "venue_state": "TAS",
          "venue_country": "AUS"
        }
      }
    }
    """#
    // swiftlint:enable line_length

    let nextRaces = try JSONDecoder().decode(NextRacesDTO.self, from: Data(json.utf8))
    XCTAssertEqual(nextRaces.nextToGoIds.first, nextRaces.raceSummaries.first?.key)
    XCTAssertEqual(nextRaces.nextToGoIds.first, nextRaces.raceSummaries.first?.value.id)
    XCTAssertEqual(nextRaces.nextToGoIds.count, 1)
    XCTAssertEqual(nextRaces.raceSummaries.count, 1)
  }
}
