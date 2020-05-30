//
//  RingList.swift
//  UICircularProgressRingExample
//
//  Created by Luis on 5/29/20.
//  Copyright © 2020 Luis. All rights reserved.
//

import UICircularProgressRing
import SwiftUI

enum RingType: String {
    case `default`
    case indeterminate
}

struct RingList: View {
    let ringTypes: [RingType] = [
        .default,
        .indeterminate
    ]

    var body: some View {
        NavigationView {
            List(ringTypes, id: \.self) { ringType in
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
    let type: RingType
    @State private var isShown = false

    var body: some View {
        NavigationLink(destination: type.view, isActive: $isShown) {
            Text(type.title)
                .font(.system(.body))
                .padding([.top, .bottom], 16)
        }
    }
}

private extension RingType {
    var title: String {
        switch self {
        case .default:
            return "Basic Ring"
        case .indeterminate:
            return "Indeterminate Ring"
        }
    }

    var view: AnyView {
        switch self {
        case .default:
            return AnyView(DefaultExample())
        case .indeterminate:
            return AnyView(EmptyView())
        }
    }
}
