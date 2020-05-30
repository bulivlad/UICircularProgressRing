//
//  ProgressRingTests.swift
//  
//
//  Created by Luis on 5/30/20.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import UICircularProgressRing

final class ProgressRingTests: XCTestCase {
    func test_progress_ring_default() {
        let sut = ProgressRing(progress: .constant(.percent(0.5))).frame(width: 200, height: 200)

        assertSnapshot(matching: sut, as: .image)
    }
}
