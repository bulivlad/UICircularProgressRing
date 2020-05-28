//
//  RingSnapshotTest.swift
//
//
//  Created by Luis Padron on 5/28/20.
//

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
            color: .red
        )
            .frame(width: 200, height: 200)

        assertSnapshot(matching: ring, as: .image)
    }
}
