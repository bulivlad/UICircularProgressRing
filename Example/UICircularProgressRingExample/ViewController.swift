//
//  ViewController.swift
//  UICircularProgressRingExample
//
//  Created by Luis on 1/16/20.
//  Copyright © 2020 Luis. All rights reserved.
//

import UIKit

@testable import UICircularProgressRing

final class ViewController: UIViewController {

    private let ring: UICircularProgressRing = {
        let r = UICircularProgressRing()
        return r
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(ring)
        ring.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ring.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            ring.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            ring.widthAnchor.constraint(equalToConstant: 300),
            ring.heightAnchor.constraint(equalToConstant: 300)
        ])


    }

}
