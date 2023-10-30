//
//  RaceSummaryDTOTests.swift
//  EntainTechnicalTask Tests
//
//  Created by Brett Best on 30/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

@testable import EntainTechnicalTask
import XCTest

final class RaceSummaryDTOTests: XCTestCase {
  // swiftlint:disable:next function_body_length
  func testDecodingValidData() throws {
    // swiftlint:disable line_length
    let json =
    #"""
    {
      "race_id": "0b66b24b-8e64-407a-a96f-4847b3923964",
      "race_name": "Race 2 - 1200",
      "race_number": 2,
      "meeting_id": "f5458164-e020-4e42-9e21-f23e3633c417",
      "meeting_name": "Tokyo City Keiba",
      "category_id": "4a2788f8-e825-4d36-9894-efd4baf1cfae",
      "advertised_start": {
        "seconds": 1698649200
      },
      "race_form": {
        "distance": 1200,
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
          "id": "08e5f78c-1a36-11eb-9269-cef03e67f1a3",
          "name": "FINE",
          "short_name": "fine",
          "icon_uri": "FINE"
        },
        "weather_id": "08e5f78c-1a36-11eb-9269-cef03e67f1a3",
        "race_comment": "GENERAL AIMER (9) made an encouraging debut last time out, finishing 2.25 lengths from the winner in third over 1200m at this track. Will be very hard to beat with that run under the belt. AMANCAES (10) missed the frame on debut then improved last time when 4 lengths away in third over 1200m at this track. Has the pace to take a forward position. Hard to beat. SOPHIA TOTO (1) was safely held on debut last start, finishing 33 lengths behind the winner in fifth over 1200m at this track. Will take a lot from that experience. One of the main contenders. SARAH LUNA (4) stepped out on her debut over 1400m at this track three-and-a-half weeks ago and finished fifth, beaten 35 lengths. Better for that run and can improve sharply.",
        "additional_data": "{\"revealed_race_info\":{\"track_name\":\"Tokyo City Keiba\",\"state\":\"JPN\",\"country\":\"JPN\",\"number\":2,\"race_name\":\"\",\"time\":\"1970-01-01T00:00:00Z\"}}",
        "generated": 1,
        "silk_base_url": "drr38safykj6s.cloudfront.net",
        "race_comment_alternative": "GENERAL AIMER (9) made an encouraging debut last time out, finishing 2.25 lengths from the winner in third over 1200m at this track. Will be very hard to beat with that run under the belt. AMANCAES (10) missed the frame on debut then improved last time when 4 lengths away in third over 1200m at this track. Has the pace to take a forward position. Hard to beat. SOPHIA TOTO (1) was safely held on debut last start, finishing 33 lengths behind the winner in fifth over 1200m at this track. Will take a lot from that experience. One of the main contenders. SARAH LUNA (4) stepped out on her debut over 1400m at this track three-and-a-half weeks ago and finished fifth, beaten 35 lengths. Better for that run and can improve sharply."
      },
      "venue_id": "d8e494b0-2c26-4b07-9639-fc458a893156",
      "venue_name": "Tokyo City Keiba",
      "venue_state": "JPN",
      "venue_country": "JPN"
    }
    """#
    // swiftlint:enable line_length

    let raceSummary = try JSONDecoder().decode(RaceSummaryDTO.self, from: Data(json.utf8))

    XCTAssertEqual(raceSummary.id, .init(UUID(uuidString: "0b66b24b-8e64-407a-a96f-4847b3923964").unsafelyUnwrapped))
    XCTAssertEqual(raceSummary.name, "Race 2 - 1200")
    XCTAssertEqual(raceSummary.number, 2)
    XCTAssertEqual(raceSummary.meetingId, .init(UUID(uuidString: "f5458164-e020-4e42-9e21-f23e3633c417").unsafelyUnwrapped))
    XCTAssertEqual(raceSummary.meetingName, "Tokyo City Keiba")
    XCTAssertEqual(raceSummary.category, .horse)
    XCTAssertEqual(raceSummary.advertisedStart.date, Date(timeIntervalSince1970: 1_698_649_200))
  }
}
