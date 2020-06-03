//
//  ProgressRingStyle.swift
//
//  Created by Luis Padron on 6/3/20.
//

import SwiftUI

public struct ProgressRingStyle {
    /// The `RingColor` for the inner ring.
    public let innerRingColor: RingColor
    /// The `RingColor` for the outer ring.
    public let outerRingColor: RingColor
    /// The `StrokeStyle` for the inner ring.
    public let innerRingStrokeStyle: StrokeStyle
    /// The `StrokeStyle` for the outer ring.
    public let outerRingStrokeStyle: StrokeStyle
    /// The amount of padding to use for the inner ring.
    public let innerRingPadding: Double

    public init(
        innerRingColor: RingColor = .color(.blue),
        outerRingColor: RingColor = .color(.gray),
        innerRingStrokeStyle: StrokeStyle = .init(lineWidth: 16, lineCap: .round, lineJoin: .round),
        outerRingStrokeStyle: StrokeStyle = .init(lineWidth: 32),
        innerRingPadding: Double = 8
    ) {
        self.innerRingColor = innerRingColor
        self.outerRingColor = outerRingColor
        self.innerRingStrokeStyle = innerRingStrokeStyle
        self.outerRingStrokeStyle = outerRingStrokeStyle
        self.innerRingPadding = innerRingPadding
    }
}
