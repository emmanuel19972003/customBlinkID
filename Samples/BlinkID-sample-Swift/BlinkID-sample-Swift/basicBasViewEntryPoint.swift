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
        button.setTitle("Native BlinkID", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        let button2 = UIButton(frame: CGRect(x: 100, y: 300, width: 150, height: 100))
        button2.backgroundColor = .systemBlue
        button2.layer.cornerRadius = 25
        button2.setTitle("Custom BlinkID", for: .normal)
        button2.addTarget(self, action: #selector(buttonAction2), for: .touchUpInside)
        
        self.view.addSubview(button2)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        let vc = BlinkScanDocumentsRouter.getBlinkIdView(viewType: .native)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func buttonAction2(sender: UIButton!) {
        let vc = BlinkScanDocumentsRouter.getBlinkIdView(viewType: .custom)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

#Preview {
    basicBasViewEntryPoint()
}
