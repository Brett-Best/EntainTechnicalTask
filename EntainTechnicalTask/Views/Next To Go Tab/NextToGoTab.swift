//
//  NextToGoTab.swift
//  EntainTechnicalTask
//
//  Created by Brett Best on 30/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

import SwiftUI

struct NextToGoTab: View {
  let viewModel: NextToGoViewModel

  var body: some View {
    NavigationStack {
      NextToGoView(viewModel: viewModel)
    }
    .tabItem {
      Label("Next to Go", systemImage: "goforward.5")
    }
  }
}
