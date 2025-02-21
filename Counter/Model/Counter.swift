//
//  Counter.swift
//  Counter
//
//  Created by Nathyane Moreno on 16/02/25.
//
//

import Foundation
import SwiftData

@Model public class Counter {
    public var id: UUID?
    var value: Int = 0
    var name: String
    var orderIndex: Int

    public init(_ value: Int = 0, _ name: String, _ orderIndex: Int = 0) {
        self.id = UUID()
        self.value = value
        self.name = name
        self.orderIndex = orderIndex
    }

    // Static method to check uniqueness in a given list of counters
    static func isUnique(counter: Counter, in counters: [Counter]) -> Bool {
        return !counters.contains(where: { $0.orderIndex == counter.orderIndex })
    }
}
