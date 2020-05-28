//
//  SnapshotTest.swift
//  
//
//  Created by Luis on 5/28/20.
//

import SnapshotTesting
import XCTest

class SnapshotTest: XCTestCase {
    override func setUp() {
        super.setUp()

        //
        // This defines whether snapshot test recording
        // runs or not. i.e. whether we generate new images or not.
        // change this to true, run the tests, and change back to false
        // when a change to the UI was intended.
        //
        record = false
        //
        //
    }
}
