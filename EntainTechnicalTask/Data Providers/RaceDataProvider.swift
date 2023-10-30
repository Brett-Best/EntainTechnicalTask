//
//  RaceDataProvider.swift
//  EntainTechnicalTask
//
//  Created by Brett Best on 30/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

import Foundation

protocol _RaceDataProvider {
  func fetchNextRaces(count: UInt) async throws -> HTTPResponseDTO<NextRacesDTO>
}

struct RaceDataProvider: _RaceDataProvider {
  let session: URLSession
  let baseURL: URL

  init(baseURL: URL, session: URLSession = .shared) {
    self.baseURL = baseURL
    self.session = session
  }

  func fetchNextRaces(count: UInt) async throws -> HTTPResponseDTO<NextRacesDTO> {
    let (data, _) = try await session.data(from: fetchNextRacesURL(count: count))
    return try JSONDecoder().decode(HTTPResponseDTO<NextRacesDTO>.self, from: data)
  }

  func fetchNextRacesURL(count: UInt) -> URL {
    baseURL
      .appending(path: "racing", directoryHint: .isDirectory)
      .appending(
        queryItems: [
          URLQueryItem(name: "method", value: "nextraces"),
          URLQueryItem(name: "count", value: String(count))
        ]
      )
  }
}
