//
//  RingShape.swift
//  CircularProgressRing
//
//  Created by Luis on 3/8/20.
//

import SwiftUI

struct RingShape: Shape {
    /// percent the ring shape is stroked in, valid range: [0, 1]
    var percent: Double

    /// axis in which to start drawing the ring shape
    let axis: RingAxis

    /// the width of the ring shapes line relative to its frame
    let lineWidth: Double

    func path(in rect: CGRect) -> Path {
        Circle()
            .inset(by: lineWidth.float / 2)
            .trim(  to: CGFloat(min(percent, 1.0)))
            .rotation(axis.angle)
            .path(in: rect)
    }

    var animatableData: Double {
        get { percent }
        set { percent = newValue }
    }
}
