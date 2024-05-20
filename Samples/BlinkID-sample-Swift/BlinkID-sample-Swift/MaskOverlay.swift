//
//  MaskOverlay.swift
//  BlinkID-sample-Swift
//
//  Created by Emmanuel Zambrano on 7/05/24.
//  Copyright © 2024 Dino. All rights reserved.
//

import UIKit

class MaskOverlay: ViewController {
    
    static let height = (UIScreen.main.bounds.width - (16) * 2)/1.586
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setUpUI()
        overlayViews()
    }
    func setUpUI() {
        view.addSubview(BlackCover)
        view.addSubview(ScanArea)
        view.addSubview(BlackCover1)
        scanAreaConstraints()
    }
    private let ScanArea: UIView = {
        let view = UIView()
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.purple.cgColor
        view.layer.cornerRadius = 0
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let BlackCover: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .black.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //window.bounds
    
    private let BlackCover1: UIView = {
        let view = UIView(frame: CGRect(origin: CGPoint(x: 16,
                                                        y: UIScreen.main.bounds.midY - height/2),
                                        size: CGSize(width: UIScreen.main.bounds.width - (16) * 2,
                                                     height: height)))
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func scanAreaConstraints(){
        NSLayoutConstraint.activate([
            ScanArea.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ScanArea.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ScanArea.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ScanArea.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ScanArea.heightAnchor.constraint(equalTo: ScanArea.widthAnchor, multiplier: 1/1.586)
        ])
        print(ScanArea.heightAnchor)
    }
    func overlayViews() {
        BlackCover.mask(BlackCover1.frame, invert: true)
    }
}

extension UIView{
    
    func mask(_ rect: CGRect, invert: Bool = false) {
        let maskLayer = CAShapeLayer()
        let path = CGMutablePath()
        if invert {
            path.addRect(bounds)
        }
        path.addRect(rect)
        maskLayer.path = path
        if invert {
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        }
        // Set the mask of the view.
        layer.mask = maskLayer
    }
}
