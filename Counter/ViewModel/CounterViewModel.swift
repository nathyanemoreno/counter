//
//  CouterViewModel.swift
//  Counter
//
//  Created by Nathyane Moreno on 13/02/25.
//
import SwiftData
import SwiftUI

class CounterViewModel: ObservableObject {
    let counterRepository: CounterRepository
    @Published var counters: [Counter] = []
    
    init(counterRepository: CounterRepository ){
        self.counterRepository = counterRepository
        self.fetchCounters()
    }
    
    func addCounter(_ value: Int = 0, _ name: String = ""){
        let orderIndex: Int = (counters.last?.orderIndex ?? 0) + 1
        counterRepository.addCounter(value, name, orderIndex)
        fetchCounters()
    }
    
    func deleteCounter(_ counter: Counter){
        counterRepository.delete(counter);
    }
    
    @discardableResult
    func fetchCounters() -> [Counter]? {
        try? counterRepository.getCounters()
        self.counters = counterRepository.counters
        
        return self.counters;
    }
    
    func updateCounter(_ counter: Counter, _ value: Int){
        counter.value = value;
        
        counterRepository.update(counter, value);
        
        fetchCounters()
    }
    
    func reorderCounters(from: IndexSet, to: Int){
        counterRepository.updateCounters(from: from, to: to)
        counterRepository.getCounters()
    }
    
    func increment(_ counter: Counter){
        counterRepository.update(counter, counter.value + 1);
    }
    
    func decrement(_ counter: Counter){
        counterRepository.update(counter, max(0, counter.value - 1))
    }
}
