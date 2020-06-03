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

    /// the color of the ring
    let color: RingColor

    /// the `StrokeStyle` used to stroke the ring
    let strokeStyle: StrokeStyle

    /// Function which is given the percent of the ring and
     /// expects `Content` to be drawn in the center of the ring.
    let content: (Double) -> Content

    init(
        percent: Double,
        axis: RingAxis,
        clockwise: Bool,
        color: RingColor,
        strokeStyle: StrokeStyle,
        @ViewBuilder _ content: @escaping (Double) -> Content
    ) {
        self.percent = percent
        self.axis = axis
        self.clockwise = clockwise
        self.color = color
        self.strokeStyle = strokeStyle
        self.content = content
    }

    public var body: some View {
        RingShape(
            percent: percent,
            axis: axis,
            insetAmount: strokeStyle.lineWidth / 2
        )
            .stroked(with: color, style: strokeStyle)
            .rotation3DEffect(clockwise ? .zero : .degrees(180), axis: axis.as3D)
            .overlay(content(percent), alignment: .center)
    }
}

extension Ring where Content == EmptyView {
    /// Default init which returns a ring with no label.
    init(
        percent: Double,
        axis: RingAxis,
        clockwise: Bool,
        color: RingColor,
        strokeStyle: StrokeStyle
    ) {
        self.init(
            percent: percent,
            axis: axis,
            clockwise: clockwise,
            color: color,
            strokeStyle: strokeStyle
        ) { _ in
            EmptyView()
        }
    }
}

// MARK: - Extensions

private extension Shape {
    func stroked(with ringColor: RingColor, style: StrokeStyle) -> AnyView {
        switch ringColor {
        case let .color(color):
            return AnyView(self.stroke(color, style: style))
        case let .gradient(gradient):
            return AnyView(self.stroke(gradient, style: style))
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
                    color: .color(.purple),
                    strokeStyle: .init(lineWidth: 20)
                )
                    .onAppear {
                        withAnimation(.linear(duration: 10), { self.percent = 1 })
                    }

                Ring(
                    percent: percent,
                    axis: .top,
                    clockwise: true,
                    color: .color(.purple),
                    strokeStyle: .init(lineWidth: 20)
                ) { percent in
                    Text("\(percent)%")
                }
                    .onAppear {
                        withAnimation(.linear(duration: 10), { self.percent = 1 })
                    }

                Ring(
                    percent: percent,
                    axis: .top,
                    clockwise: true,
                    color: .gradient(
                        AngularGradient(
                            gradient: .init(colors: [.red, .green]),
                            center: .center,
                            angle: RingAxis.top.angle
                        )
                    ),
                    strokeStyle: .init(lineWidth: 20)
                )
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
