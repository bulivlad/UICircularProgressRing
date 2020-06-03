//
//  ProgressRingSnapshotTests.swift
//
//
//  Created by Luis on 5/30/20.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import UICircularProgressRing

final class ProgressRingSnapshotTests: XCTestCase {
    func test_progressRing_default() {
        let sut = ProgressRing(progress: .constant(.percent(0.5))).frame(width: 200, height: 200)

        assertSnapshot(matching: sut, as: .image)
    }

    func test_progressRing_axis() {
        let axes: [RingAxis] = [.top, .bottom, .leading, .trailing]

         let sut = Group {
             ForEach(0..<4) { index in
                 ProgressRing(
                     progress: .constant(.percent(0.5)),
                     axis: axes[index]
                 )
                 .frame(width: 200, height: 200)
             }
         }

         assertSnapshot(matching: sut, as: .image)
    }

    func test_progressRing_clockwise() {
        let values: [Bool] = [false, true]

         let sut = Group {
             ForEach(0..<2) { index in
                 ProgressRing(
                     progress: .constant(.percent(0.5)),
                     clockwise: values[index]
                 )
                 .frame(width: 200, height: 200)
             }
         }

         assertSnapshot(matching: sut, as: .image)
    }

    func test_progressRing_style_innerRingColor() {
        let colors: [RingColor] = [
            .color(.red),
            .gradient(.init(gradient: .init(colors: [.red, .blue]), center: .center))
        ]

        let sut = Group {
            ForEach(0..<1) { index in
                ProgressRing(
                    progress: .constant(.percent(0.5)),
                    style: .init(innerRingColor: colors[index])
                )
                .frame(width: 200, height: 200)
            }
        }

        assertSnapshot(matching: sut, as: .image)
    }

    func test_progressRing_outerRingColor() {
        let colors: [RingColor] = [
            .color(.red),
            .gradient(.init(gradient: .init(colors: [.red, .blue]), center: .center))
        ]

        let sut = Group {
            ForEach(0..<1) { index in
                ProgressRing(
                    progress: .constant(.percent(0.5)),
                    style: .init(outerRingColor: colors[index])
                )
                .frame(width: 200, height: 200)
            }
        }

        assertSnapshot(matching: sut, as: .image)
    }

    func test_progressRing_style_innerRing_StrokeStyleLineWidth() {
        let sut = ProgressRing(
            progress: .constant(.percent(0.5)),
            style: .init(innerRingStrokeStyle: .init(lineWidth: 20))
        )
        .frame(width: 200, height: 200)

        assertSnapshot(matching: sut, as: .image)
    }

    func test_progressRing_outerRingWidth() {
        let sut = ProgressRing(
            progress: .constant(.percent(0.5)),
            style: .init(outerRingStrokeStyle: .init(lineWidth: 32))
        )
        .frame(width: 200, height: 200)

        assertSnapshot(matching: sut, as: .image)
    }

    func test_progressRing_innerRingPadding() {
        let sut = ProgressRing(
            progress: .constant(.percent(0.5)),
            style: .init(innerRingPadding: 0)
        )
        .frame(width: 200, height: 200)

        assertSnapshot(matching: sut, as: .image)
    }
}
