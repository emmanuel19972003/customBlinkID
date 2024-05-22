//
//  resultView.swift
//  BlinkID-sample-Swift
//
//  Created by Emmanuel Zambrano Quitian on 4/30/24.
//  Copyright © 2024 Dino. All rights reserved.
//

import UIKit

class ResultView: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .white
        addButton()
    }
    func addButton() {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 150, height: 100))
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 25
        button.setTitle("Test Button", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
    }
    func addImage(setImage: BlinkIDEntity) {
        let view = UIImageView(frame: CGRect(x: 100, y: 300, width: 150, height: 100))
        view.image = setImage.frontINE
        self.view.addSubview(view)
        let view2 = UIImageView(frame: CGRect(x: 100, y: 600, width: 150, height: 100))
        view2.image = setImage.backINE
        self.view.addSubview(view2)
    }
    @objc func buttonAction(sender: UIButton!) {
        navigationController?.popViewController(animated: true)
    }
}
