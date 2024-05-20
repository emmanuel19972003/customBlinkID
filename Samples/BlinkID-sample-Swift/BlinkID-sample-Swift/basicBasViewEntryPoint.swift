//
//  basicBasViewEntryPoint.swift
//  basBlinkId
//
//  Created by Emmanuel Zambrano Quitian on 4/26/24.
//

import UIKit

class basicBasViewEntryPoint: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @objc func buttonAction(sender: UIButton!) {
        let vc = BlinkScanDocumentsRouter.getBlinkIdView()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
