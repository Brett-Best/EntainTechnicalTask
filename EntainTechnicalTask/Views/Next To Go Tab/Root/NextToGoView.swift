//
//  NextToGoView.swift
//  EntainTechnicalTask
//
//  Created by Brett Best on 31/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

import SwiftUI

struct NextToGoView: View {
  @ObservedObject var viewModel: NextToGoViewModel

  var body: some View {
    List(content: listContent)
      .animation(.default, value: viewModel.selectedRaceCategories)
      .listStyle(.insetGrouped)
      .toolbar(content: toolbarContent)
      .navigationTitle("Next to Go")
  }

  @ViewBuilder
  func listContent() -> some View {
    let raceSummaries = viewModel.filteredRaceSummaries

    Section {
      ForEach(raceSummaries, content: RaceSummaryRow.init)
    }

    Section {
      switch viewModel.state {
      case .loading: if raceSummaries.isEmpty { Text("Loading races…") }
      case .failure(let error, _): Text(error.localizedDescription)
      default: EmptyView()
      }
    }
  }

  @ToolbarContentBuilder
  func toolbarContent() -> some ToolbarContent {
    ToolbarItem {
      Menu(
        content: {
          Toggle(isOn: viewModel.allRaceCategoriesToggleBinding) {
            Label("All Races", systemImage: "line.3.horizontal.decrease.circle")
          }
          Divider()
          ForEach(RaceCategoryDTO.allCases) { raceCategory in
            Toggle(isOn: viewModel.toggleBinding(raceCategory: raceCategory)) {
              Label(raceCategory.title, systemImage: raceCategory.systemImage)
            }
          }
        },
        label: {
          Label("Filter", systemImage: viewModel.raceCategoriesIsFiltered ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
        }
      )
    }
  }
}
