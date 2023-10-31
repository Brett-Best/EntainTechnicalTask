//
//  MainTabView.swift
//  EntainTechnicalTask
//
//  Created by Brett Best on 30/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
  @StateObject private var nextToGoViewModel = NextToGoViewModel(raceDataProvider: RaceDataProvider(baseURL: kNedsAPIBaseURL))

  var body: some View {
    TabView {
      NextToGoTab(viewModel: nextToGoViewModel)
    }
  }
}
