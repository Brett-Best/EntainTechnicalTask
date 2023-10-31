//
//  NextToGoViewModel.swift
//  EntainTechnicalTask
//
//  Created by Brett Best on 31/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

import Combine
import SwiftUI

class NextToGoViewModel: ObservableObject {
  enum State {
    case loading([RaceSummaryDTO])
    case success([RaceSummaryDTO])
    case failure(Error, [RaceSummaryDTO])

    var raceSummaries: [RaceSummaryDTO] {
      switch self {
      case .loading(let raceSummaries): return raceSummaries
      case .success(let raceSummaries): return raceSummaries
      case .failure(_, let raceSummaries): return raceSummaries
      }
    }

    func filteredRaceSummaries(selectedRaceCategories: Set<RaceCategoryDTO>) -> [RaceSummaryDTO] {
      Array(
        raceSummaries
          .filter { selectedRaceCategories.contains($0.category) }
          .sorted(by: { $0.advertisedStart.date < $1.advertisedStart.date })
          .prefix(kMaximumNumberOfRaceSummariesToDisplay)
      )
    }
  }

  let raceDataProvider: _RaceDataProvider

  @Published private(set) var state: State = .loading([])
  @Published private(set) var selectedRaceCategories = Set(RaceCategoryDTO.allCases)

  private var cancellables: Set<AnyCancellable> = []

  var filteredRaceSummaries: [RaceSummaryDTO] {
    state.filteredRaceSummaries(selectedRaceCategories: selectedRaceCategories)
  }

  init(raceDataProvider: _RaceDataProvider, reloadInterval: TimeInterval = 60) {
    self.raceDataProvider = raceDataProvider

    reload()

    Timer
      .publish(every: 1, on: .main, in: .common)
      .autoconnect()
      .sink { [weak self] _ in self?.discardRaceSummariesIfNeeded() }
      .store(in: &cancellables)

    Timer
      .publish(every: reloadInterval, on: .main, in: .common)
      .autoconnect()
      .sink { [weak self] _ in self?.reload() }
      .store(in: &cancellables)
  }

  func reload() {
    state = .loading(state.raceSummaries)

    Task { @MainActor in
      do {
        // Using 12 instead of 10 because using 10 resulting in "too many redirects" response
        let raceSummaries = Array(try await raceDataProvider.fetchNextRaces(count: 12).data.raceSummaries.values)
        state = .success(raceSummaries)
      } catch {
        state = .failure(error, state.raceSummaries)
      }
    }
  }

  func discardRaceSummariesIfNeeded() {
    let now = Date()

    let activeRaceSummaries = state.raceSummaries.filter {
      $0.advertisedStart.date.timeIntervalSince(now) > -kMaximumIntervalToDisplayStartedRaces
    }

    // Don't update the state if no race summaries were discarded
    guard activeRaceSummaries.map(\.id) != state.raceSummaries.map(\.id) else {
      return
    }

    state = switch state {
    case .loading: .loading(activeRaceSummaries)
    case .success: .success(activeRaceSummaries)
    case .failure(let error, _): .failure(error, activeRaceSummaries)
    }
  }
}

extension NextToGoViewModel {
  var raceCategoriesIsFiltered: Bool {
    self.selectedRaceCategories != Set(RaceCategoryDTO.allCases)
  }

  var allRaceCategoriesToggleBinding: Binding<Bool> {
    .init(
      get: {
        !self.raceCategoriesIsFiltered
      },
      set: { isOn in
        if isOn {
          self.selectedRaceCategories = Set(RaceCategoryDTO.allCases)
        }
      }
    )
  }

  func toggleBinding(raceCategory: RaceCategoryDTO) -> Binding<Bool> {
    .init(
      get: {
        self.raceCategoriesIsFiltered && self.selectedRaceCategories.contains(raceCategory)
      },
      set: { isOn in
        if isOn {
          self.selectedRaceCategories = self.raceCategoriesIsFiltered ? self.selectedRaceCategories.union([raceCategory]) : [raceCategory]
        } else {
          self.selectedRaceCategories = 1 == self.selectedRaceCategories.count ? Set(RaceCategoryDTO.allCases) : self.selectedRaceCategories.subtracting([raceCategory])
        }
      }
    )
  }
}
