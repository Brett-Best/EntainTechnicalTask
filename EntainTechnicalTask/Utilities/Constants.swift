//
//  Constants.swift
//  EntainTechnicalTask
//
//  Created by Brett Best on 30/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

import Foundation

let kIsRunningUnitTests = nil != NSClassFromString("XCTestCase")
let kNedsAPIBaseURL = URL(string: "https://api.neds.com.au/rest/v1/").unsafelyUnwrapped
let kMaximumNumberOfRaceSummariesToDisplay = 5
let kMaximumIntervalToDisplayStartedRaces: TimeInterval = 60
