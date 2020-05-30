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
    let innerRingWidth: Double
    let outerRingWidth: Double
    let innerRingColor: Color
    let outerRingColor: Color
    let innerRingPadding: Double

    private let indeterminateView: () -> IndeterminateView
    private let label: (Double) -> Label

    /// Creates a `ProgressRing`.
    ///
    /// - Parameters:
    ///   - progress: A `Binding` to some `RingProgress` which determines the state of the progress ring.
    ///   - axis: A `RingAxis` which determines the starting axis for which to draw.
    ///   - clockwise: Whether the ring is drawn in a clock wise manner or not.
    ///   - innerRingColor: The `Color` of the inner progress ring.
    ///   - outerRingColor: The `Color` of the outer progress ring.
    ///   - innerRingWidth: The width of the inner progress ring.
    ///   - outerRingWidth: The width of the outer progress ring.
    ///   - innerRingPadding: The padding for the inner progress ring.
    ///   - label: A closure which constructs the `Label` for the progress ring.
    ///   - indeterminateView: A closure which constructs a view that is used when progress `isIndeterminate`.
    public init (
        progress: Binding<RingProgress>,
        axis: RingAxis = ProgressRingDefaults.axis,
        clockwise: Bool = ProgressRingDefaults.clockwise,
        innerRingColor: Color = ProgressRingDefaults.innerRingColor,
        outerRingColor: Color = ProgressRingDefaults.outerRingColor,
        innerRingWidth: Double = ProgressRingDefaults.innerRingWidth,
        outerRingWidth: Double = ProgressRingDefaults.outerRingWidth,
        innerRingPadding: Double = ProgressRingDefaults.innerRingPadding,
        @ViewBuilder _ label: @escaping (Double) -> Label,
        @ViewBuilder _ indeterminateView: @escaping () -> IndeterminateView
    ) {
        self._progress = progress
        self.axis = axis
        self.clockwise = clockwise
        self.innerRingWidth = innerRingWidth
        self.outerRingWidth = outerRingWidth
        self.innerRingColor = innerRingColor
        self.outerRingColor = outerRingColor
        self.innerRingPadding = innerRingPadding
        self.indeterminateView = indeterminateView
        self.label = label
    }
}

// MAR: - Defaults

/// Defaults for the `ProgressRing` initializers.
public enum ProgressRingDefaults {
    public static let axis: RingAxis = .top
    public static let clockwise: Bool = true
    public static let innerRingColor: Color = .blue
    public static let outerRingColor: Color = .gray
    public static let innerRingWidth: Double = 16
    public static let outerRingWidth: Double = 32
    public static let innerRingPadding: Double = 16 / 2
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
    ///   - innerRingColor: The `Color` of the inner progress ring.
    ///   - outerRingColor: The `Color` of the outer progress ring.
    ///   - innerRingWidth: The width of the inner progress ring.
    ///   - outerRingWidth: The width of the outer progress ring.
    ///   - innerRingPadding: The padding for the inner progress ring.
    ///   - label: A closure which constructs the `Label` for the progress ring.
    init(
        progress: Binding<RingProgress>,
        axis: RingAxis = ProgressRingDefaults.axis,
        clockwise: Bool = ProgressRingDefaults.clockwise,
        innerRingColor: Color = ProgressRingDefaults.innerRingColor,
        outerRingColor: Color = ProgressRingDefaults.outerRingColor,
        innerRingWidth: Double = ProgressRingDefaults.innerRingWidth,
        outerRingWidth: Double = ProgressRingDefaults.outerRingWidth,
        innerRingPadding: Double = ProgressRingDefaults.innerRingPadding,
        @ViewBuilder _ label: @escaping (Double) -> Label
    ) {
        self._progress = progress
        self.axis = axis
        self.clockwise = clockwise
        self.innerRingWidth = innerRingWidth
        self.outerRingWidth = outerRingWidth
        self.innerRingColor = innerRingColor
        self.outerRingColor = outerRingColor
        self.innerRingPadding = innerRingPadding
        self.indeterminateView = { IndeterminateRing() }
        self.label = label
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
    ///   - innerRingColor: The `Color` of the inner progress ring.
    ///   - outerRingColor: The `Color` of the outer progress ring.
    ///   - innerRingWidth: The width of the inner progress ring.
    ///   - outerRingWidth: The width of the outer progress ring.
    ///   - innerRingPadding: The padding for the inner progress ring.
    init(
        progress: Binding<RingProgress>,
        axis: RingAxis = ProgressRingDefaults.axis,
        clockwise: Bool = ProgressRingDefaults.clockwise,
        innerRingColor: Color = ProgressRingDefaults.innerRingColor,
        outerRingColor: Color = ProgressRingDefaults.outerRingColor,
        innerRingWidth: Double = ProgressRingDefaults.innerRingWidth,
        outerRingWidth: Double = ProgressRingDefaults.outerRingWidth,
        innerRingPadding: Double = ProgressRingDefaults.innerRingPadding
    ) {
        self._progress = progress
        self.axis = axis
        self.clockwise = clockwise
        self.innerRingWidth = innerRingWidth
        self.outerRingWidth = outerRingWidth
        self.innerRingColor = innerRingColor
        self.outerRingColor = outerRingColor
        self.innerRingPadding = innerRingPadding
        self.indeterminateView = { IndeterminateRing() }
        self.label = { PercentFormattedText(percent: $0) }
    }
}

extension ProgressRing: View {

    public var body: some View {
        Group {
            if progress.isIndeterminate {
                indeterminateView()
            } else {
                ZStack(alignment: .center) {
                    Ring(
                        percent: 1,
                        axis: axis,
                        clockwise: clockwise,
                        lineWidth: outerRingWidth,
                        color: outerRingColor
                    )

                    Ring(
                        percent: progress.asDouble ?? 0.0,
                        axis: axis,
                        clockwise: clockwise,
                        lineWidth: innerRingWidth,
                        color: innerRingColor
                    )
                    .modifier(
                        AnimatablePercentTextModifier(
                            percent: progress.asDouble ?? 0.0,
                            label: label
                        )
                    )
                    .padding(CGFloat(innerRingPadding))
                }
            }
        }
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProgressRing(progress: .constant(.percent(0.5)))
        }
    }
}
