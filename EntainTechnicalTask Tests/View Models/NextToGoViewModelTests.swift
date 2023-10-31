//
//  NextToGoViewModelTests.swift
//  EntainTechnicalTask Tests
//
//  Created by Brett Best on 31/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

@testable import EntainTechnicalTask
import XCTest

final class NextToGoViewModelTests: XCTestCase {
  struct BlockRaceDataProvider: _RaceDataProvider {
    let fetchNextRaces: (_ count: UInt) async throws -> HTTPResponseDTO<NextRacesDTO>

    func fetchNextRaces(count: UInt) async throws -> HTTPResponseDTO<NextRacesDTO> {
      try await fetchNextRaces(count)
    }
  }

  enum LoadingError: Error {
    case generic
  }

  func testRaceCategorySelection() {
    let throwingRaceDataProvider = BlockRaceDataProvider { _ in
      throw LoadingError.generic
    }

    let viewModel = NextToGoViewModel(raceDataProvider: throwingRaceDataProvider)

    // Assert categories aren't filtered initially
    XCTAssertEqual(viewModel.selectedRaceCategories.count, 3)
    XCTAssertFalse(viewModel.raceCategoriesIsFiltered)

    let greyhoundBinding = viewModel.toggleBinding(raceCategory: .greyhound)
    // Show only greyhounds
    greyhoundBinding.wrappedValue = true

    // Assert greyhound is the only selected category
    XCTAssertEqual(viewModel.selectedRaceCategories, [.greyhound])

    // Show all races by selecting greyhound again
    greyhoundBinding.wrappedValue = false

    // Assert all categories are selected again
    XCTAssertFalse(viewModel.raceCategoriesIsFiltered)

    let horseBinding = viewModel.toggleBinding(raceCategory: .horse)
    // Show only horses
    horseBinding.wrappedValue = true

    // Assert that greyhounds is off
    XCTAssertFalse(greyhoundBinding.wrappedValue)

    // Show greyhounds
    greyhoundBinding.wrappedValue = true

    // Assert horses is still selected
    XCTAssertTrue(horseBinding.wrappedValue)

    // Assert horses and greyhounds selected
    XCTAssertEqual(viewModel.selectedRaceCategories, [.greyhound, .horse])

    // Deselect horses
    horseBinding.wrappedValue = false

    // Assert only greyhounds selected
    XCTAssertEqual(viewModel.selectedRaceCategories, [.greyhound])

    let allRaceCategoriesToggleBinding = viewModel.allRaceCategoriesToggleBinding

    // Assert all races is unselected
    XCTAssertFalse(allRaceCategoriesToggleBinding.wrappedValue)

    // Show all races
    allRaceCategoriesToggleBinding.wrappedValue = true

    // Assert all categories are selected again
    XCTAssertFalse(viewModel.raceCategoriesIsFiltered)
  }

  func testViewModelHandlesErrorWhenLoadingRaces() async {
    let loadingExpectation = XCTestExpectation(description: "To load and transition to error state")

    let raceDataProvider = BlockRaceDataProvider { _ in
      try await Task.sleep(for: .milliseconds(100))
      loadingExpectation.fulfill()
      throw LoadingError.generic
    }

    let viewModel = NextToGoViewModel(raceDataProvider: raceDataProvider)

    guard case .loading(let raceSummaries) = viewModel.state else {
      XCTFail("Expected viewmodel to be in loading state")
      return
    }

    XCTAssertTrue(raceSummaries.isEmpty)

    await fulfillment(of: [loadingExpectation], timeout: 2)

    guard case .failure(let error, let raceSummaries) = viewModel.state else {
      XCTFail("Expected viewmodel to be in failure state")
      return
    }

    XCTAssertTrue(error is LoadingError)
    XCTAssertTrue(raceSummaries.isEmpty)
  }

  func testFilteredRaceSummaries() async {
    let loadingExpectation = XCTestExpectation(description: "To load and transition to loaded state")

    let raceDataProvider = BlockRaceDataProvider { _ in
      try await Task.sleep(for: .milliseconds(100))
      let data = try Data(contentsOf: try XCTUnwrap(Bundle(for: Self.self).url(forResource: "sample-nextraces-response", withExtension: "json")))
      let response = try JSONDecoder().decode(HTTPResponseDTO<NextRacesDTO>.self, from: data)
      loadingExpectation.fulfill()
      return response
    }

    let viewModel = NextToGoViewModel(raceDataProvider: raceDataProvider)
    // Only show greyhounds
    viewModel.toggleBinding(raceCategory: .greyhound).wrappedValue = true

    await fulfillment(of: [loadingExpectation], timeout: 2)

    XCTAssertEqual(viewModel.filteredRaceSummaries.count, kMaximumNumberOfRaceSummariesToDisplay)
    viewModel.filteredRaceSummaries.forEach {
      XCTAssertEqual($0.category, .greyhound)
    }
  }

  func testDiscardingRaceSummariesIfNeeded() async throws {
    let loadingExpectation = XCTestExpectation(description: "To load and transition to loaded state")

    let raceSummary = RaceSummaryDTO(
      id: .init(UUID()),
      name: "Name",
      number: 10,
      meetingId: .init(UUID()),
      meetingName: "Meeting name",
      category: .greyhound,
      advertisedStart: .init(date: Date().addingTimeInterval(-90))
    )

    let raceDataProvider = BlockRaceDataProvider { _ in
      try await Task.sleep(for: .milliseconds(100))
      loadingExpectation.fulfill()
      return .init(status: 200, data: .init(nextToGoIds: [raceSummary.id], raceSummaries: [raceSummary.id: raceSummary]), message: "")
    }

    let viewModel = NextToGoViewModel(raceDataProvider: raceDataProvider)

    await fulfillment(of: [loadingExpectation], timeout: 2)

    XCTAssertEqual(viewModel.filteredRaceSummaries.count, 1)

    // Every second races should be discarded. So wait a couple to check that the race was discarded
    try await Task.sleep(for: .seconds(2))

    XCTAssertTrue(viewModel.filteredRaceSummaries.isEmpty)
  }

  func testViewModelReloadsAutomatically() async {
    let loadingErrorExpectation = XCTestExpectation(description: "To load and transition to error state")
    let loadingSuccessExpectation = XCTestExpectation(description: "To load and transition to success state")

    var shouldThrowError = true

    let raceDataProvider = BlockRaceDataProvider { _ in
      defer {
        shouldThrowError = false
      }

      try await Task.sleep(for: .milliseconds(100))
      if shouldThrowError {
        shouldThrowError = false
        loadingErrorExpectation.fulfill()
        throw LoadingError.generic
      } else {
        loadingSuccessExpectation.fulfill()
        return .init(status: 200, data: .init(nextToGoIds: [], raceSummaries: [:]), message: "")
      }
    }

    let viewModel = NextToGoViewModel(raceDataProvider: raceDataProvider, reloadInterval: 1.5)

    await fulfillment(of: [loadingErrorExpectation], timeout: 2)

    guard case .failure(let error, let raceSummaries) = viewModel.state else {
      XCTFail("Expected viewmodel to be in failure state")
      return
    }

    await fulfillment(of: [loadingSuccessExpectation], timeout: 2)

    guard case .success = viewModel.state else {
      XCTFail("Expected viewmodel to be in success state")
      return
    }
  }
}
