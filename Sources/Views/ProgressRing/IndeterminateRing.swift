//
//  IndeterminateRing.swift
//
//  Created by Luis Padron on 5/28/20.
//

import SwiftUI

public struct IndeterminateRing: View {
    public var body: some View {
        ZStack {
            Ring(
                percent: 0.5,
                axis: .leading,
                clockwise: true,
                lineWidth: 10,
                color: Color.red
            )
        }
    }
}
