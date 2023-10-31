# Entain Technical Task

This repository contains an application developed using Xcode.
The purpose is to demonstrate a core set of skills.

## Next steps
- Work with backend team on preferred way of ensuring that 5 races of each category type can be shown at all times, while it would be possible to implement with the current API, it would be a bit messy.
- Work with design team to create assets (e.g. custom symbols) for the race categories and app icon
- Implement nicer empty, loading and error states
- Implement localisation if needed
- Configure CI/CD, e.g. using GitHub Actions
- Assess whether implementing the ability for UI Tests to load mock data for reproducible tests is a priority
- Assess whether using snapshot testing for views is worthwhile
- Create a wrapper type for `UUID` as conforming types you don't own to protocols you also don't own isn't recommended

## Technical Specifications
### App
#### Supported Platforms
**iOS:** 17.0+

**iPadOS:** 17.0+

### Development Tooling
**Xcode:** 15.0.1 (15A507)

**macOS:** 14.2 (23C5030f)

## Building

1. Open `EntainTechnicalTask.xcworkspace` in Xcode.
2. Wait for Swift Package Manager to resolve dependencies.
3. Select the `EntainTechnicalTask` scheme and choose a device such as the `iPhone 15 Pro Max (17.0.1)` or `iPad Pro (12.9 inch) (6th Generation) (17.0.1)`.
4. Run the scheme `EntainTechnicalTask`, you may be presented with a dialog. This is because `SwiftLint` is added via Swift Packagae Manager Build Tool Plug-ins. Select the `Trust & Enable All` option. 
5. The app should launch in the selected Simulator fairly quickly depending on your build machine. I used the `16” MacBook Pro (2023), M2 Pro, 16GB RAM` running `macOS 14.2b1`.
6. I would suggest increasing/decreasing the Preferred Text Size `⌥⌘+ / ⌥⌘-` and changing the appearance (light/dark) `⇧⌘A`.

## Libraries
- SwiftLint: included as a build tool to enforce a set of rules around the formatting of code
- Tagged: micro-library used to create typesafe identifiers

## Testing
Unit tests were written to cover the majority of the important parts.
UI tests were written to cover launching the app and testing the successful path.

## Issues
I discovered that the API endpoint was buggy especially when using a count of 10, I believe this started happening around Monday afternoon (30th October 2023, Australia/Melbourne time). See `curl-output.txt` in the root directory of this repository.

## Task (from Word document)

Thank you for your application for the iOS engineer position at Entain. As part of our interview process, we have prepared the following technical task to get a better understanding of your skills, thought process and methodology.

There is no fixed time limit on this task, what matters is that you demonstrate your knowledge and skills to the best of your ability. Please upload your solution to a private repository and send us a link, include any testing instructions. 

Task
Create an iOS app that displays ‘Next to Go’ races using our API.
A user should always see 5 races, and they should be sorted by time ascending. Race should disappear from the list after 1 min past the start time, if you are looking for inspiration look at https://www.neds.com.au/next-to-go 

Requirements
1.  As a user, I should be able to see a time ordered list of races ordered by advertised start ascending
2.  As a user, I should not see races that are one minute past the advertised start 
3.  As a user, I should be able to filter my list of races by the following categories: Horse, Harness & Greyhound racing
4.  As a user, I can deselect all filters to show the next 5 from of all racing categories
5.  As a user I should see the meeting name, race number and advertised start as a countdown for each race.
6.  As a user, I should always see 5 races and data should automatically refresh 

Technical Requirements 
-  Use SwiftUI or UIKit
-  Has some level of testing. Full coverage is not necessary, but there should be at least some testing for key files. 
-  Documentation
-  Use scalable layouts so your app can respond to font scale changes
-  (Optional) Use of custom Decodable
-  (Optional) Use of SF Symbols for any icons
-  (Optional) add accessibility labels such that you can navigate via voiceover
  
  Categories are defined by IDs and are the following: 
    - Greyhound racing: category_id: 9daef0d7-bf3c-4f50-921d-8e818c60fe61
    - Harness racing: category_id: 161d9be2-e909-4326-8c2c-35ed71fb460b
    - Horse racing: category_id: 4a2788f8-e825-4d36-9894-efd4baf1cfae

  GET https://api.neds.com.au/rest/v1/racing/?method=nextraces&count=10
  Content-type: application/json
