//
//  customViewBAZ.swift
//  BlinkID-sample-Swift
//
//  Created by Emmanuel Zambrano Quitian on 4/15/24.
//  Copyright © 2024 Dino. All rights reserved.
//

import UIKit
import BlinkID

class customViewBAZ: MBCustomOverlayViewController, MBScanningRecognizerRunnerViewControllerDelegate,
                     MBFirstSideFinishedRecognizerRunnerViewControllerDelegate, MBScanningRecognizerRunnerDelegate {
    func recognizerRunner(_ recognizerRunner: MBRecognizerRunner, didFinishScanningWith state: MBRecognizerResultState) {
    }
    
    
    private let InstructionsLabel: UILabel =  {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.font.withSize(14)
        view.text = "Centra y toma una foto del frente de tu identificación oficial"
        return view
    }()
    
    private let TomarFotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Tomar foto", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let AbrirGaleriaButton: UIButton = {
        let button = UIButton()
        button.setTitle("Abrir galería", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 24
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 3
        button.setImage(UIImage(systemName: "photo"), for: .normal)
        button.imageEdgeInsets.left = -5
        button.addTarget(self, action:  #selector(openGallery), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let ScanArea: UIView = {
        let view = UIView()
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.purple.cgColor
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
//        view.backgroundColor = .red
        viewHierarchy()
        viewConstraints()
    }
    
    private func viewHierarchy() {
        view.addSubview(InstructionsLabel)
        view.addSubview(TomarFotoButton)
        view.addSubview(AbrirGaleriaButton)
        view.addSubview(ScanArea)
    }
    
    private func viewConstraints() {
        instructionsLabelConstraints()
        tomarFotoButtonConstraints()
        abrirGaleriaButtonConstraints()
        scanAreaConstraints()
    }
    
    private func instructionsLabelConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            InstructionsLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 118),
            InstructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            InstructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func tomarFotoButtonConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            TomarFotoButton.heightAnchor.constraint(equalToConstant: 48),
            TomarFotoButton.widthAnchor.constraint(equalToConstant: 204),
            TomarFotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            TomarFotoButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -88)
        ])
        
    }
    
    private func abrirGaleriaButtonConstraints(){
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            AbrirGaleriaButton.heightAnchor.constraint(equalToConstant: 48),
            AbrirGaleriaButton.widthAnchor.constraint(equalToConstant: 150),
            AbrirGaleriaButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            AbrirGaleriaButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -32)
        ])
        
    }
    
    private func scanAreaConstraints(){
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            ScanArea.heightAnchor.constraint(equalToConstant: 197),
            ScanArea.widthAnchor.constraint(equalToConstant: 328),
            ScanArea.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ScanArea.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func openGallery() {
        print("Emma")
    }
    
    func recognizerRunnerViewControllerDidFinishScanning(_ recognizerRunnerViewController: UIViewController & MBRecognizerRunnerViewController, state: MBRecognizerResultState) {
    }
    
    func recognizerRunnerViewControllerDidFinishRecognition(ofFirstSide recognizerRunnerViewController: UIViewController & MBRecognizerRunnerViewController) {
    }
}
