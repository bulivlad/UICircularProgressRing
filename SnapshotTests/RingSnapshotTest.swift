//
//  RingSnapshotTest.swift
//
//
//  Created by Luis Padron on 5/28/20.
//

import SwiftUI
import SnapshotTesting
import XCTest

@testable import UICircularProgressRing

final class RingSnapshotTest: SnapshotTest {
    func test_ring_default() {
        let ring = Ring(
            percent: 0.50,
            axis: .top,
            clockwise: true,
            lineWidth: 20,
            color: .blue
        )
            .frame(width: 200, height: 200)

        assertSnapshot(matching: ring, as: .image)
    }

    func test_ring_with_text() {
        let ring = Ring(
            percent: 0.76,
            axis: .trailing,
            clockwise: false,
            lineWidth: 20,
            color: .blue
        ) { percent in
            Text("\(percent * 100)%")
        }
            .frame(width: 200, height: 200)

        assertSnapshot(matching: ring, as: .image)
    }
}
