//
//  EntainTechnicalTaskApp.swift
//  EntainTechnicalTask
//
//  Created by Brett Best on 30/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

import SwiftUI

@main
enum EntainTechnicalTaskApp {
  static func main() throws {
    guard !kIsRunningUnitTests else {
      TestApp.main()
      return
    }

    App.main()
  }
}

extension EntainTechnicalTaskApp {
  struct App: SwiftUI.App {
    let racesDataProvider = RaceDataProvider(baseURL: URL(string: "https://api.neds.com.au/rest/v1/").unsafelyUnwrapped)

    var body: some Scene {
      WindowGroup {
        ContentView()
          .task {
            do {
              print(try await racesDataProvider.fetchNextRaces(count: 5))
            } catch {
              dump(error)
            }
          }
      }
    }
  }
}

extension EntainTechnicalTaskApp {
  struct TestApp: SwiftUI.App {
    var body: some Scene {
      WindowGroup {
        Text("Running unit tests…")
          .font(.largeTitle)
      }
    }
  }
}
