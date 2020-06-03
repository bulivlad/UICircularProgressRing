//
//  ProgressRing.swift
//
//  Created by Luis Padron on 5/28/20.
//

import Combine
import SwiftUI

/// # ProgressRing
///
public struct ProgressRing<Label, IndeterminateView> where Label: View, IndeterminateView: View {
    @Binding private var progress: RingProgress

    let axis: RingAxis
    let clockwise: Bool
    let style: ProgressRingStyle

    private let indeterminateView: (Double) -> IndeterminateView
    private let label: (Double) -> Label

    /// Creates a `ProgressRing`.
    ///
    /// - Parameters:
    ///   - progress: A `Binding` to some `RingProgress` which determines the state of the progress ring.
    ///   - axis: A `RingAxis` which determines the starting axis for which to draw.
    ///   - clockwise: Whether the ring is drawn in a clock wise manner or not.
    ///   - style: The `ProgressRingStyle` used to customize the progress ring.
    ///   - label: A closure which constructs the `Label` for the progress ring.
    ///   - indeterminateView: A closure which constructs a view that is used when progress `isIndeterminate`.
    public init (
        progress: Binding<RingProgress>,
        axis: RingAxis = .top,
        clockwise: Bool = true,
        style: ProgressRingStyle = .init(),
        @ViewBuilder _ label: @escaping (Double) -> Label,
        @ViewBuilder _ indeterminateView: @escaping (Double) -> IndeterminateView
    ) {
        self._progress = progress
        self.axis = axis
        self.clockwise = clockwise
        self.style = style
        self.indeterminateView = indeterminateView
        self.label = label
    }
}

// MARK: - Init

public extension ProgressRing where IndeterminateView == IndeterminateRing {

    /// Creates a `ProgressRing`.
    /// Uses a default `IndeterminateView`.
    ///
    /// - Parameters:
    ///   - progress: A `Binding` to some `RingProgress` which determines the state of the progress ring.
    ///   - axis: A `RingAxis` which determines the starting axis for which to draw.
    ///   - clockwise: Whether the ring is drawn in a clock wise manner or not.
    ///   - style: The `ProgressRingStyle` used to customize the progress ring.
    ///   - label: A closure which constructs the `Label` for the progress ring.
    init(
        progress: Binding<RingProgress>,
        axis: RingAxis = .top,
        clockwise: Bool = true,
        style: ProgressRingStyle = .init(),
        @ViewBuilder _ label: @escaping (Double) -> Label
    ) {
        self.init(
            progress: progress,
            axis: axis,
            clockwise: clockwise,
            style: style,
            label,
            { IndeterminateRing(percent: $0) }
        )
    }
}

public extension ProgressRing where Label == PercentFormattedText, IndeterminateView == IndeterminateRing {

    /// Creates a `ProgressRing`.
    /// Uses a default `Label` and `IndeterminateView`.
    ///
    /// - Parameters:
    ///   - progress: A `Binding` to some `RingProgress` which determines the state of the progress ring.
    ///   - axis: A `RingAxis` which determines the starting axis for which to draw.
    ///   - clockwise: Whether the ring is drawn in a clock wise manner or not.
    ///   - style: The `ProgressRingStyle` used to customize the progress ring.
    ///   - innerRingPadding: The padding for the inner progress ring.
    init(
        progress: Binding<RingProgress>,
        axis: RingAxis = .top,
        clockwise: Bool = true,
        style: ProgressRingStyle = .init()
    ) {
        self.init(
            progress: progress,
            axis: axis,
            clockwise: clockwise,
            style: style,
            { PercentFormattedText(percent: $0) },
            { IndeterminateRing(percent: $0) }
        )
    }
}

extension ProgressRing: View {

    public var body: some View {
        Group {
            if progress.isIndeterminate {
                indeterminateView(0.5)
            } else {
                ZStack(alignment: .center) {
                    Ring(
                        percent: 1,
                        axis: axis,
                        clockwise: clockwise,
                        color: style.outerRingColor,
                        strokeStyle: style.outerRingStrokeStyle
                    )

                    Ring(
                        percent: progress.asDouble ?? 0.0,
                        axis: axis,
                        clockwise: clockwise,
                        color: style.innerRingColor,
                        strokeStyle: style.innerRingStrokeStyle
                    )
                    .modifier(
                        AnimatablePercentTextModifier(
                            percent: progress.asDouble ?? 0.0,
                            label: label
                        )
                    )
                    .padding(CGFloat(style.innerRingPadding))
                }
            }
        }
        .transition(.opacity)
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProgressRing(progress: .constant(.percent(0.5)))
        }
    }
}
