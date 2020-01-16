//
//  UICircularRing.swift
//  UICircularProgressRing
//
//  Copyright (c) 2020 Luis Padron
//

#if canImport(UIKit)

import UIKit

/**
 # UICircularRing

 TODO: add docs
 */
open class UICircularRing: UIView {

    // MARK: API

    public var ringColor: UIColor = Defaults.ringColor {
        didSet {
            ringLayer.setNeedsDisplay()
        }
    }

    public var ringWidth: CGFloat = Defaults.ringWidth {
        didSet {
            ringLayer.setNeedsDisplay()
        }
    }

    public init() {
        super.init(frame: .zero)
        setupLayout()
        setupLayer()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal / Overrides

    private func setupLayout() {
        backgroundColor = .clear
    }

    private func setupLayer() {
        ringLayer.ring = self
    }

    open override func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    /// returns overriden layer class
    open override class var layerClass: AnyClass {
        return UICircularRingLayer.self
    }

    /// returns `self.layer` as `UICircularRingLayer`
    var ringLayer: UICircularRingLayer {
        return layer as! UICircularRingLayer
    }
}

#endif
