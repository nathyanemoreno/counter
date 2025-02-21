//
//  CoreDataManager.swift
//  Counter
//
//  Created by Nathyane Moreno on 13/02/25.
//

import SwiftData
import SwiftUI

@Observable
class CounterRepository {
    let modelContext: ModelContext
    var counters: [Counter] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        getCounters()
    }
    
    func addCounter(_ value: Int = 0, _ name: String, _ index: Int = 0){
        let counter = Counter(value, name, index);
        
        if !Counter.isUnique(counter: counter, in: counters) {
            print("Error: OrderIndex must be unique!")
            return
        }
        modelContext.insert(counter)
        try? modelContext.save()
    }
    
    func delete(_ counter: Counter){
        modelContext.delete(counter)
        try? modelContext.save()
    }
    
    func getCounters() {
        let descriptor = FetchDescriptor<Counter>()
        
        do{
            let counters = try modelContext.fetch(descriptor)
            self.counters = counters.sorted(by: {$0.orderIndex < $1.orderIndex})
        } catch {
            print("Erro fetching counters: \(error)")
        }
    }
    
    func update(_ counter: Counter, _ value: Int){
        counter.value = value;
        
        do{
            try modelContext.save()
            getCounters()
        }catch{
            print("Error updating counter: \(error)")
        }
    }
    
    func updateCounters(from: IndexSet, to: Int) {
        DispatchQueue.main.async {
            guard !self.counters.isEmpty else { return } // Prevent crashes
            
            var reorderedCounters = self.counters
            reorderedCounters.move(fromOffsets: from, toOffset: to)
            
            // Update order index
            for (index, counter) in reorderedCounters.enumerated() {
                counter.orderIndex = index + 1
            }
            
            self.counters = reorderedCounters
            
            do {
                if(self.modelContext.hasChanges){
                    try self.modelContext.save()
                }
                self.getCounters()
            } catch {
                print("Error saving context after updating counters: \(error)")
            }
        }
    }
    
}
