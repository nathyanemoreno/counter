//
//  CounterRow.swift
//  Counter
//
//  Created by Nathyane Moreno on 14/02/25.
//
import SwiftUI

struct CounterRow: View {
    @Binding var counter: Counter
    @ObservedObject var viewModel: CounterViewModel;
    
    var body: some View {
        VStack{
            
            HStack {
                CounterButton(
                    icon: "minus",
                    title: "-",
                    backgroundColor: Color.accent,
                    action: { viewModel.decrement(counter); }
                )
                
                Spacer()
                
                Text(String(counter.value)).font(.title).scaledToFill()
                
                Spacer()
                
                CounterButton(
                    icon: "plus",
                    title: "+",
                    action: { viewModel.increment(counter) }
                )
            }
            .swipeActions(edge: .trailing) {
                Button(role: .destructive) {
                    viewModel.deleteCounter(counter)
                } label: {
                    Label("Deletar", systemImage: "trash").labelStyle(.iconOnly)
                }
            }
            .padding()
        }
    }
}

//#Preview{
////    @ObservedObject var viewModel: CounterViewModel
//    CounterRow(counter: $viewModel.counters.first!)
//}
