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
            axis: .top,
            clockwise: true,
            lineWidth: 20,
            color: .blue
        ) { percent in
            Text("\(percent * 100)%")
        }
            .frame(width: 200, height: 200)

        assertSnapshot(matching: ring, as: .image)
    }

    func test_ring_axis() {
        let allAxis = RingAxis.allCases
        let sut = Group {
            ForEach(allAxis, id: \.self) { axis in
                Ring(
                    percent: 0.5,
                    axis: axis,
                    clockwise: true,
                    lineWidth: 20,
                    color: .blue
                )
                .frame(width: 200, height: 200)
            }
        }


        assertSnapshot(matching: sut, as: .image)
    }

    func test_ring_clockwise() {
        let sut = Group {
            ForEach([false, true], id: \.self) { clockwise in
                Ring(
                    percent: 0.5,
                    axis: .top,
                    clockwise: clockwise,
                    lineWidth: 20,
                    color: .blue
                )
                .frame(width: 200, height: 200)
            }
        }


        assertSnapshot(matching: sut, as: .image)
    }

    func test_ring_lineWidth() {
         let sut = Group {
            ForEach([20.0, 10.0], id: \.self) { lineWidth in
                 Ring(
                    percent: 0.5,
                     axis: .top,
                     clockwise: true,
                     lineWidth: lineWidth,
                     color: .blue
                 )
                .frame(width: 200, height: 200)
             }
         }


         assertSnapshot(matching: sut, as: .image)
     }

    func test_ring_color() {
         let sut = Group {
            ForEach([Color.blue, Color.red], id: \.self) { color in
                 Ring(
                     percent: 0.5,
                     axis: .top,
                     clockwise: true,
                     lineWidth: 20,
                     color: color
                 )
                .frame(width: 200, height: 200)
             }
         }


         assertSnapshot(matching: sut, as: .image)
     }
}
