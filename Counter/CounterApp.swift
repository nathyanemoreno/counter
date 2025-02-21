//
//  CounterApp.swift
//  Counter
//
//  Created by Nathyane Moreno on 12/02/25.
//

import SwiftUI
import SwiftData

@main
struct CounterApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Counter.self])
        let configuration = ModelConfiguration()
        return try! ModelContainer(for: schema, configurations: [configuration])
    }()
    
    var body: some Scene {
        WindowGroup {
            let counterRepository = CounterRepository(modelContext: sharedModelContainer.mainContext)
            let viewModel = CounterViewModel(counterRepository: counterRepository)
            
            ContentView(viewModel: viewModel)
                .modelContainer(sharedModelContainer)
                .environment(\.locale, Locale(identifier: "pt_BR"))
                .environment(\.font, Font.custom("Avenir", size: 14))
        }
    }
}
