//
//  UICircularProgressRing.swift
//  UICircularProgressRing
//
//  Created by Luis on 1/23/20.
//

#if canImport(UIKit)

import UIKit

/**
 ## UICircularProgressRingStyle

 // TODO: add docs
*/
public enum UICircularProgressRingStyle {
    case inside(padding: UIEdgeInsets)
    case ontop
}

/**
 ## UICircularProgressRing

 // TODO: add docs
 */
public final class UICircularProgressRing: UIView {

    public var style: UICircularProgressRingStyle = .ontop

    // MARK: API

    public init() {
        super.init(frame: .zero)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal

    private func setupLayout() {
        backgroundColor = .clear
        addSubview(outerRing)
        addSubview(innerRing)

        setupOuterRing()
        setupInnerRing()
    }

    private func setupOuterRing() {
        outerRing.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            outerRing.topAnchor.constraint(equalTo: topAnchor),
            outerRing.leadingAnchor.constraint(equalTo: leadingAnchor),
            outerRing.bottomAnchor.constraint(equalTo: bottomAnchor),
            outerRing.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setupInnerRing() {
        innerRing.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            innerRing.topAnchor.constraint(equalTo: topAnchor, constant: innerRingAnchorConstants.top),
            innerRing.leadingAnchor.constraint(equalTo: leadingAnchor, constant: innerRingAnchorConstants.left),
            innerRing.bottomAnchor.constraint(equalTo: bottomAnchor, constant: innerRingAnchorConstants.bottom),
            innerRing.trailingAnchor.constraint(equalTo: trailingAnchor, constant: innerRingAnchorConstants.right)
        ])
    }

    // MARK: Computed

    private var innerRingAnchorConstants: UIEdgeInsets {
        switch style {
        case .inside(let extraPadding):
            let spacing = innerRing.ringWidth * 2
            return UIEdgeInsets(top: spacing + extraPadding.top,
                                left: spacing + extraPadding.left,
                                bottom: -spacing - extraPadding.bottom,
                                right: -spacing - extraPadding.right)

        case .ontop:
            let spacing = innerRing.ringWidth / 2
            return UIEdgeInsets(top: spacing, left: spacing, bottom: -spacing, right: -spacing)
        }
    }

    // MARK: Subviews

    private let outerRing: UICircularRing = {
        let ring = UICircularRing()
        ring.ringColor = .gray
        ring.backgroundColor = .clear
        return ring
    }()

    private let innerRing: UICircularRing = {
        let ring = UICircularRing()
        ring.ringWidth = 5.0
        ring.backgroundColor = .clear
        return ring
    }()
}

#endif
