//
//  RingProgress.swift
//
//  Created by Luis Padron on 3/15/20.
//

import Foundation

/// # Progress
///
/// A type representing some progress.
public enum RingProgress {
    /// A floating point value to describe progress as a percentage.
    /// Percentage is described in floating point representation,
    /// i.e. `100% = 1`, `50%  = 0.5`, `0% = 0`
    case percent(Double)

    /// An indeterminate percentage value.
    case indeterminate
}

// MARK: Percentage + External

public extension RingProgress {
    /// - returns: Whether the progress value is determinate or not.
    var isIndeterminate: Bool {
        switch self {
        case .percent:
            return false
        case .indeterminate:
            return true
        }
    }

    /// - returns: Attempts to convert to double, if `isIndeterminate == true` this returns `nil`.
    var asDouble: Double? {
        switch self {
        case let .percent(val):
            return val
        case .indeterminate:
            return nil
        }
    }
}
