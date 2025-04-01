//
//  FamousQuotesParseApp.swift
//  FamousQuotesParse
//
//  Created by Cormell, David - DPC on 18/03/2025.
//

import SwiftUI
import ParseSwift

@main
struct FamousQuotesParseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(vm: FamousQuotesViewModel())
        }
    }
    
    init() {
        ParseSwift.initialize(
            applicationId: "zZkwiLPGuztr0UcE1XnTvQ7YL5mSsWA20yz4Pcn0",
            clientKey: "NHHNxWk6ASCileYI9slHoMj6IkyKBgMMqM5EU2w8",
            serverURL: URL(string: "https://parseapi.back4app.com")!
        )
    }
}
