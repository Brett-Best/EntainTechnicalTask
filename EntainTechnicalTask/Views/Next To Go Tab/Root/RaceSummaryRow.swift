//
//  RaceSummaryRow.swift
//  EntainTechnicalTask
//
//  Created by Brett Best on 31/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

import SwiftUI

struct RaceSummaryRow: View {
  static let dateComponentsFormatter: DateComponentsFormatter = {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .abbreviated
    return formatter
  }()

  static let accessibilityDateComponentsFormatter: DateComponentsFormatter = {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .full
    return formatter
  }()

  let raceSummary: RaceSummaryDTO

  var body: some View {
    let detailsLabel = Label("\(raceSummary.meetingName) • R\(raceSummary.number)", systemImage: raceSummary.category.systemImage)
      .foregroundStyle(Color(.label))
      .multilineTextAlignment(.leading)
      .frame(maxWidth: .infinity, alignment: .leading)

    let counterTimelineView = TimelineView(.periodic(from: Date(), by: 1)) { _ in
      Text(Self.dateComponentsFormatter.string(from: Date(), to: raceSummary.advertisedStart.date) ?? "")
        .monospacedDigit()
        .foregroundStyle(Color(.secondaryLabel))
    }

    ViewThatFits {
      HStack(spacing: 16) {
        detailsLabel
        counterTimelineView
      }
      .frame(maxWidth: .infinity)

      VStack(spacing: 16) {
        detailsLabel
        counterTimelineView
          .multilineTextAlignment(.trailing)
          .frame(maxWidth: .infinity, alignment: .trailing)
      }
      .frame(maxWidth: .infinity)
    }
    .alignmentGuide(.listRowSeparatorLeading) { _ in
      0
    }
    .accessibilityRepresentation {
      // Increasing the interval from 1 to something higher would probably be a better user experience
      TimelineView(.periodic(from: Date(), by: 1)) { _ in
        Text("\(raceSummary.meetingName) round \(raceSummary.number) racing at \(Self.accessibilityDateComponentsFormatter.string(from: Date(), to: raceSummary.advertisedStart.date) ?? "")")
      }
    }
  }
}
