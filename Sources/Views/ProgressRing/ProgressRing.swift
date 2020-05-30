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
    @State private var _progress: RingProgress = .percent(0)

    private let onDidAppearSubject = PassthroughSubject<Void, Never>()
    private var onDidAppearPublisher: AnyPublisher<Void, Never> {
        onDidAppearSubject.eraseToAnyPublisher()
    }

    private let progress: AnyPublisher<RingProgress, Never>
    private var progressPublisher: AnyPublisher<RingProgress, Never> {
        onDidAppearPublisher
            .flatMap { self.progress }
            .eraseToAnyPublisher()
    }

    let axis: RingAxis
    let clockwise: Bool
    let innerRingWidth: Double
    let outerRingWidth: Double
    let innerRingColor: Color
    let outerRingColor: Color
    let innerRingPadding: Double

    private let indeterminateView: () -> IndeterminateView
    private let label: (Double) -> Label

    public init (
        progress: AnyPublisher<RingProgress, Never>,
        animation: Animation = .default,
        axis: RingAxis = .top,
        clockwise: Bool = true,
        innerRingColor: Color = .blue,
        outerRingColor: Color = .red,
        innerRingWidth: Double = 16,
        outerRingWidth: Double = 32,
        innerRingPadding: Double = 16 / 2,
        @ViewBuilder _ label: @escaping (Double) -> Label,
        @ViewBuilder _ indeterminateView: @escaping () -> IndeterminateView
    ) {
        self.progress = progress
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

// MARK: - Init

public extension ProgressRing where IndeterminateView == IndeterminateRing {
    init(
        progress: AnyPublisher<RingProgress, Never>,
        axis: RingAxis = .top,
        clockwise: Bool = true,
        innerRingColor: Color = .blue,
        outerRingColor: Color = .red,
        innerRingWidth: Double = 16,
        outerRingWidth: Double = 32,
        innerRingPadding: Double = 16 / 2,
        @ViewBuilder _ label: @escaping (Double) -> Label
    ) {
        self.progress = progress
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

public extension ProgressRing where Label == Text, IndeterminateView == IndeterminateRing {
    init(
        progress: AnyPublisher<RingProgress, Never>,
        axis: RingAxis = .top,
        clockwise: Bool = true,
        innerRingColor: Color = .blue,
        outerRingColor: Color = .red,
        innerRingWidth: Double = 16,
        outerRingWidth: Double = 32,
        innerRingPadding: Double = 16 / 2
    ) {
        self.progress = progress
        self.axis = axis
        self.clockwise = clockwise
        self.innerRingWidth = innerRingWidth
        self.outerRingWidth = outerRingWidth
        self.innerRingColor = innerRingColor
        self.outerRingColor = outerRingColor
        self.innerRingPadding = innerRingPadding
        self.indeterminateView = { IndeterminateRing() }
        self.label = { percent -> Text in
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .percent

            return Text(numberFormatter.string(from: .init(floatLiteral: percent)) ?? "NaN")
                .font(.system(.largeTitle))
        }
    }
}

extension ProgressRing: View {

    public var body: some View {
        Group {
            if _progress.isIndeterminate {
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
                        percent: _progress.asDouble ?? 0.0,
                        axis: axis,
                        clockwise: clockwise,
                        lineWidth: innerRingWidth,
                        color: innerRingColor
                    )
                    .modifier(
                        AnimatableProgressTextModifier(
                            percent: _progress.asDouble ?? 0.0,
                            label: label
                        )
                    )
                    .padding(CGFloat(innerRingPadding))
                    .visible(!_progress.isIndeterminate)
                }
            }
        }
        .transition(.identity)
        .onAppear() {
            self.onDidAppearSubject.send(())
        }
        .onReceive(progressPublisher) { progress in
            withAnimation(.linear(duration: 2)) {
                self._progress = progress
            }
        }
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProgressRing(progress: Just(RingProgress.percent(0.5)).eraseToAnyPublisher())
        }
    }
}
