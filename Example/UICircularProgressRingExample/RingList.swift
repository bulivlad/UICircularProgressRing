//
//  RingList.swift
//  UICircularProgressRingExample
//
//  Created by Luis on 5/29/20.
//  Copyright © 2020 Luis. All rights reserved.
//

import UICircularProgressRing
import SwiftUI

enum RingExamples: String {
    case `default`
    case indeterminate
    case customization
}

struct RingList: View {
    let ringExamples: [RingExamples] = [
        .default,
        .indeterminate,
        .customization
    ]

    var body: some View {
        NavigationView {
            List(ringExamples, id: \.self) { ringType in
                ExampleRingRow(type: ringType)
            }
            .navigationBarTitle("Examples")
        }
    }
}

struct RingList_Previews: PreviewProvider {
    static var previews: some View {
        RingList()
    }
}

private struct ExampleRingRow: View {
    let type: RingExamples
    @State private var isShown = false

    var body: some View {
        NavigationLink(destination: type.view, isActive: $isShown) {
            Text(type.title)
                .font(.system(.body))
                .padding([.top, .bottom], 16)
        }
    }
}

private extension RingExamples {
    var title: String {
        switch self {
        case .default:
            return "Basic Ring"
        case .indeterminate:
            return "Indeterminate Ring"
        case .customization:
            return "Customization Example"
        }
    }

    var view: AnyView {
        switch self {
        case .default:
            return AnyView(DefaultExample())
        case .indeterminate:
            return AnyView(IndeterminateExample())
        case .customization:
            return AnyView(ProgressRingCustomizationExample())
        }
    }
}
