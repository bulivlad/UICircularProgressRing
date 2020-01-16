//
//  Angle.swift
//  UICircularProgressRing
//
//  Copyright (c) 2020 Luis Padron
//

import Foundation

public struct Angle {
    let degrees: Double
    let radians: Double

    init(degrees: Double) {
        self.degrees = degrees
        self.radians = degrees * .pi / 180
    }

    init(radians: Double) {
        self.radians = radians
        self.degrees = radians * 180 / .pi
    }
}
