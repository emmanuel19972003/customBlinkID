//
//  CostumeBlinkIDDocumentsViewController.swift
//  BlinkID-sample-Swift
//
//  Created by Emmanuel Zambrano Quitian on 4/30/24.
//  Copyright © 2024 Dino. All rights reserved.
//

import UIKit
import BlinkID

protocol CostumeBlinkIDDocumentsProtocol {
    func didTapClose()
    func didFinishScanning(customData: BlinkIDEntity)
}
class CostumeBlinkIDDocumentsViewController:
    MBCustomOverlayViewController,
    MBScanningRecognizerRunnerViewControllerDelegate,
    MBFirstSideFinishedRecognizerRunnerViewControllerDelegate {
    var delegate: CostumeBlinkIDDocumentsProtocol?
    private var showingBack = false
    private let instructionsLabel: UILabel =  {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.font.withSize(14)
        view.numberOfLines = 0
        view.textColor = .white
        view.text = "Centra y toma una foto del frente de tu identificación oficial"
        view.backgroundColor = .black.withAlphaComponent(0.3)
        return view
    }()
    private let tomarFotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Escaneando", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy private var openGalleryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Abrir galería", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 24
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 3
        button.setImage(UIImage(systemName: "photo"), for: .normal)
        button.addTarget(self, action: #selector(openGallery), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let scanArea: UIView = {
        let view = UIView()
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.purple.cgColor
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let INEIFrontImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ineSample")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 30
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        super.scanningRecognizerRunnerViewControllerDelegate = self
        super.metadataDelegates.firstSideFinishedRecognizerRunnerViewControllerDelegate = self
        viewHierarchy()
        viewConstraints()
    }
    private func viewHierarchy() {
        view.addSubview(instructionsLabel)
        view.addSubview(tomarFotoButton)
        view.addSubview(openGalleryButton)
        view.addSubview(scanArea)
        view.addSubview(INEIFrontImage)
    }
    private func viewConstraints() {
        instructionsLabelConstraints()
        tomarFotoButtonConstraints()
        abrirGaleriaButtonConstraints()
        scanAreaConstraints()
        INEImageConstraints()
    }
    private func instructionsLabelConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            instructionsLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 118),
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    private func tomarFotoButtonConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tomarFotoButton.heightAnchor.constraint(equalToConstant: 48),
            tomarFotoButton.widthAnchor.constraint(equalToConstant: 204),
            tomarFotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tomarFotoButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -88)
        ])
    }
    private func abrirGaleriaButtonConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            openGalleryButton.heightAnchor.constraint(equalToConstant: 48),
            openGalleryButton.widthAnchor.constraint(equalToConstant: 150),
            openGalleryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            openGalleryButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -32)
        ])
    }
    private func scanAreaConstraints() {
        NSLayoutConstraint.activate([
            scanArea.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scanArea.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            scanArea.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scanArea.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scanArea.heightAnchor.constraint(equalTo: scanArea.widthAnchor, multiplier: 1/1.586)
        ])
    }
    private func INEImageConstraints() {
        NSLayoutConstraint.activate([
            INEIFrontImage.heightAnchor.constraint(equalToConstant: 100),
            INEIFrontImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            INEIFrontImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    @objc private func openGallery() {
        let galleryController = BlinkIDDocumentsFromGalleyViewController()
        galleryController.delegate = self
        self.present(galleryController, animated: false, completion: nil)
    }
    @objc private func closeView() {
        self.dismiss(animated: false, completion: nil)
        delegate?.didTapClose()
    }
    func INERotationAnimation() {
        INEIFrontImage.isHidden = false
        UIView.transition(with: self.INEIFrontImage, duration: 1.0, options: .transitionFlipFromLeft, animations: {
            self.INEIFrontImage.image = UIImage(named: "ineSampleReverso")}) { didFinish in
                if didFinish {
                    self.INEIFrontImage.isHidden = true
                }
            }
    }
    func recognizerRunnerViewControllerDidFinishScanning(_ recognizerRunnerViewController:
                                                         UIViewController & MBRecognizerRunnerViewController,
                                                         state: MBRecognizerResultState) {
        recognizerRunnerViewController.pauseScanning()
        for recognizer in self.recognizerCollection.recognizerList where
        recognizer.baseResult?.resultState == MBRecognizerResultState.valid {
            if recognizer is MBBlinkIdMultiSideRecognizer {
                let blinkIdRecognizer = recognizer as? MBBlinkIdMultiSideRecognizer
                guard let result = blinkIdRecognizer?.result else { return }
                let customData = BlinkIDEntity.microBlinkIDResponseAdapter(microBlinkResult: result)
                DispatchQueue.main.async {
                    self.delegate?.didFinishScanning(customData: customData)
                    self.dismiss(animated: false, completion: nil)
                }
            }
        }
    }
    func recognizerRunnerViewControllerDidFinishRecognition(ofFirstSide recognizerRunnerViewController:
                                                            UIViewController & MBRecognizerRunnerViewController) {
        DispatchQueue.main.async {
            self.instructionsLabel.text = "Centra y toma una foto del reverso de tu identificación oficial"
            self.INERotationAnimation()
        }
    }
}
extension CostumeBlinkIDDocumentsViewController: CostumeBlinkIDDocumentsProtocol {
    func didTapClose() {
        closeView()
    }
    func didFinishScanning(customData: BlinkIDEntity) {
        delegate?.didFinishScanning(customData: customData)
    }
}
