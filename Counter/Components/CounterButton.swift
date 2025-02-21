//
//  CounterButton.swift
//  Counter
//
//  Created by Nathyane Moreno on 13/02/25.
//

import SwiftUI

struct CounterButton: View {
    var icon: String? = nil
    var title: String? = nil
    var backgroundColor: Color = .accent
    var foregroundColor: Color = .white
    var size: CGFloat = 50
    var action: () -> Void
    
    @State var timer: Timer?;
    @State var timerAcceleratorFactor: CGFloat = 1.0;
    
    @State private var isPressed = false
    
    let timerRepeatInterval = 0.17;
    
    var body: some View {
        Button(action: {
            withAnimation(.easeOut(duration: 0.2)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isPressed = false
            }
            action()
        }) {
            ZStack {
                Circle() // Button shape
                    .fill(backgroundColor)
                    .frame(width: size, height: size)

                Circle()
                    .fill(Color.white.opacity(isPressed ? 0.3 : 0))
                    .frame(width: size, height: size)
                    .animation(.easeOut(duration: 0.3), value: isPressed)
                
                // Icon or Text
                if let icon = icon {
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: size * 0.4, height: size * 0.4)
                        .foregroundColor(foregroundColor)
                } else if let title = title {
                    Text(title)
                        .font(.system(size: size * 0.3, weight: .bold))
                        .foregroundColor(foregroundColor)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    startCounter();
                    adjustAcceleration(distance: value.time.timeIntervalSinceNow)
                }
                .onEnded { _ in stopCounter() }
        )
    }
    
    func adjustAcceleration(distance: CGFloat) {
       /// Increase acceleration factor based on drag distance
        timerAcceleratorFactor = max(1.0, min(5.0, abs(distance) / 20))
   }
    
    func startCounter() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            withTimeInterval: self.timerRepeatInterval / timerAcceleratorFactor, repeats: true)
        { _ in action() }
    }

    func stopCounter() {
        timer?.invalidate()
        timer = nil
        timerAcceleratorFactor = 1.0
    }
}
