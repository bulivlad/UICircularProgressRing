//
//  UICircularRingLayer.swift
//  UICircularProgressRing
//
//  Copyright (c) 2020 Luis Padron
//

#if canImport(UIKit)

import UIKit

final class UICircularRingLayer: CAShapeLayer {
    // MARK: Properties

    @NSManaged var value: CGFloat
    @NSManaged var minValue: CGFloat
    @NSManaged var maxValue: CGFloat

    weak var ring: UICircularRing! {
        didSet {
            setNeedsDisplay()
        }
    }

    // MARK: Init/Overrides

    override init() {
        super.init()
    }

    override init(layer: Any) {
        guard let layer = layer as? UICircularRingLayer else {
            fatalError("\(#file) \(#function): unable to instantiate \(UICircularRingLayer.self)")
        }

        self.ring = layer.ring
        super.init(layer: layer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        UIGraphicsPushContext(ctx)
        drawRing(in: ctx)
        UIGraphicsPopContext()
    }

    // MARK: Drawing

    private func drawRing(in ctx: CGContext) {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(bounds.width, bounds.height) / 2) - ringWidthOffset
        let start = CGFloat(0)
        let end = CGFloat.pi * 2

        let path = UIBezierPath(arcCenter: center,
                                radius: radius,
                                startAngle: start,
                                endAngle: end,
                                clockwise: true)
        path.lineWidth = ring.ringWidth

        ring.ringColor.setStroke()
        path.stroke()
    }

    // MARK: Internal

    private var ringWidthOffset: CGFloat {
        return ring.ringWidth / 2
    }
}

#endif
