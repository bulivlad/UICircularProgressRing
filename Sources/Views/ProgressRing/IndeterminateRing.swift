//
//  IndeterminateRing.swift
//
//  Created by Luis Padron on 5/28/20.
//

import SwiftUI

/// An `IndeterminateRing` is a `View` which displays
/// an animated ring to represent some long running task.
public struct IndeterminateRing: View {
    @State public private(set) var isAnimating: Bool = false

    let percent: Double
    let animation: Animation

    public init(
        percent: Double = 0.0,
        animation: Animation = Animation.easeInOut.repeatForever(autoreverses: false)
    ) {
        self.percent = percent
        self.animation = animation
    }

    public var body: some View {
        ZStack {
            Ring(
                percent: percent,
                axis: .top,
                clockwise: true,
                color: .color(.blue),
                strokeStyle: .init(lineWidth: 20)
            )
            .rotationEffect(.degrees(isAnimating ? 360 : 0))
            .animation(animation)
        }
        .onAppear {
            withAnimation {
                self.isAnimating = true
            }
        }
    }
}

private extension Int {
    var axis: RingAxis {
        switch self {
        case 0:
            return .top
        case 1:
            return .trailing
        case 2:
            return .bottom
        case 3:
            return .leading
        default:
            return .top
        }
    }
}

struct IndeterminateRing_Previews: PreviewProvider {
    static var previews: some View {
        IndeterminateRing(percent: 0.76)
            .padding()
    }
}
