
import SwiftUI
import SnapshotTesting
import XCTest

final class ReplaceMeSnapshotTest: SnapshotTest {
    func test_replace_me_view() {
        let view = Rectangle().fill(Color.red).frame(width: 100, height: 200)
        assertSnapshot(matching: view, as: .image)
    }
}
