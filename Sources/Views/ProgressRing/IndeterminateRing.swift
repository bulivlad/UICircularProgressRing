//
//  IndeterminateRing.swift
//
//  Created by Luis Padron on 5/28/20.
//

import SwiftUI

/// An `IndeterminateRing` is a `View` which displays
/// an animated ring to represent some long running task.
public struct IndeterminateRing: View {
    @State private var animationAngle = 0.0

    public var body: some View {
        ZStack {
            ForEach(0..<3) { index in
                Ring(
                    percent: 0.125,
                    axis: index.axis,
                    clockwise: true,
                    lineWidth: 20,
                    color: .red
                )
                .rotationEffect(.degrees(Double(45 * index)))
                .animation(.linear)
            }
        }
        .rotationEffect(.degrees(animationAngle))
        .onAppear {
            self.animationAngle += 360
        }
    }
}

struct IndeterminateRing_Previews: PreviewProvider {
    static var previews: some View {
        IndeterminateRing()
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
