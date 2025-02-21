//
//  ContentView.swift
//  Counter
//
//  Created by Nathyane Moreno on 12/02/25.
//

import SwiftUI
import SwiftData
import CoreData
import CoreHaptics
import AVFoundation

struct ContentView: View {
    @ObservedObject var viewModel: CounterViewModel
    @State var isPressed: Bool = false;
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        NavigationStack {
            VStack{
                List{
                    ForEach($viewModel.counters, id: \.id) { $counter in
                        CounterRow(counter: $counter, viewModel: viewModel)
                    }
                    .onMove{ indices, newOffset in
                        print("Moving counters from \(indices) to \(newOffset)")
                        viewModel.reorderCounters(from: indices, to: newOffset)
                    }
                }.task {
                    viewModel.fetchCounters()
                }
                
                Button(
                    "Adicionar contador",
                    action: { viewModel.addCounter() }
                ).primaryButton()
            }
            .listRowSpacing(10)
            .navigationTitle("Coutadores")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
}

#Preview {
    let sharedModelContainer = try! ModelContainer(for: Schema([Counter.self]), configurations: .init(isStoredInMemoryOnly: true))
    
    let counterRepository = CounterRepository(modelContext: sharedModelContainer.mainContext)
    let viewModel = CounterViewModel(counterRepository: counterRepository)
    
    return ContentView(viewModel: viewModel)
        .modelContainer(sharedModelContainer)
}
