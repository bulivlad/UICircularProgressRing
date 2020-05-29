//
//  Ring.swift
//  CircularProgressRing
//
//  Created by Luis on 3/8/20.
//

import SwiftUI

struct Ring<Content: View>: View {
    /// current percentage of completion of the ring
    var percent: Double

    /// axis in which to start drawing the ring
    let axis: RingAxis

    /// whether to draw ring towards clockwise direction
    let clockwise: Bool

    /// the width of the rings line relative to its frame
    let lineWidth: Double

    /// the color of the ring
    let color: Color

    /// Function which is given the percent of the ring and
     /// expects `Content` to be drawn in the center of the ring.
    let content: (Double) -> Content

    init(
        percent: Double,
        axis: RingAxis,
        clockwise: Bool,
        lineWidth: Double,
        color: Color,
        @ViewBuilder _ content: @escaping (Double) -> Content
    ) {
        self.percent = percent
        self.axis = axis
        self.clockwise = clockwise
        self.lineWidth = lineWidth
        self.color = color
        self.content = content
    }

    public var body: some View {
        RingShape(
            percent: percent,
            axis: axis,
            lineWidth: lineWidth
        )
            .stroke(color, lineWidth: lineWidth.float)
            .rotation3DEffect(clockwise ? .zero : .degrees(180), axis: axis.as3D)
            .overlay(content(percent), alignment: .center)
    }
}

extension Ring where Content == EmptyView {
    init(
        percent: Double,
        axis: RingAxis,
        clockwise: Bool,
        lineWidth: Double,
        color: Color
    ) {
        self.init(
            percent: percent,
            axis: axis,
            clockwise: clockwise,
            lineWidth: lineWidth,
            color: color
        ) { _ in
            EmptyView()
        }
    }
}

// MARK: - Previews

struct Ring_Previews: PreviewProvider {
    private struct _RingPreview: View {
        @State var percent: Double

        var body: some View {
            Group {
                Ring(
                    percent: percent,
                    axis: .top,
                    clockwise: true,
                    lineWidth: 20,
                    color: .purple
                )
                    .onAppear {
                        withAnimation(.linear(duration: 10), { self.percent = 1 })
                    }

                Ring(
                    percent: percent,
                    axis: .top,
                    clockwise: true,
                    lineWidth: 20,
                    color: .purple
                ) { percent in
                    Text("\(percent)%")
                }
                    .onAppear {
                        withAnimation(.linear(duration: 10), { self.percent = 1 })
                    }
            }
        }
    }

    static var previews: some View {
        _RingPreview(percent: 0)
    }
}
