//
//  BlinkIDDocumentsFromGalleyViewController.swift
//  BlinkID-sample-Swift
//
//  Created by Emmanuel Zambrano Quitian on 5/14/24.
//  Copyright © 2024 Dino. All rights reserved.
//

enum scanState {
    case front
    case back
    
    func alertTitle() -> String {
        switch self {
        case .front:
            return "Anverso"
        case .back:
            return "Reverso"
        }
    }
    
    func aletMessage() -> String {
        switch self {
        case .front:
            return "Escanee el anverso de la INE"
        case .back:
            return "Escanee el reverso de la INE"
        }
    }
}

import UIKit
import BlinkID
import MobileCoreServices

class BlinkIDDocumentsFromGalleyViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var delegate: CostumeBlinkIDDocumentsProtocol?
    
    var didCancel: Bool = false
    
    private var imagePicker = UIImagePickerController()
    
    private let serialQueue = DispatchQueue(label: "com.microblink.DirectAPI-sample-swift")
    private var recognizerRunner: MBRecognizerRunner?
    private var blinkIdMultiSideRecognizer: MBBlinkIdMultiSideRecognizer?
    
    override func viewDidLoad() {
        setupRecognizerRunner()
        setUpView()
//        view.backgroundColor = .red
    }
    
    private func setUpView() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        imagePicker.transitioningDelegate = self
        openImagePicker()
    }
    
    private func setupRecognizerRunner() {
        var recognizers = [MBRecognizer]()
        blinkIdMultiSideRecognizer = MBBlinkIdMultiSideRecognizer()
        blinkIdMultiSideRecognizer?.returnFullDocumentImage = true
        recognizers.append(blinkIdMultiSideRecognizer!)
        let recognizerCollection = MBRecognizerCollection(recognizers: recognizers)
        recognizerRunner = MBRecognizerRunner(recognizerCollection: recognizerCollection)
        recognizerRunner?.scanningRecognizerRunnerDelegate = self
        recognizerRunner?.metadataDelegates.firstSideFinishedRecognizerRunnerDelegate = self
    }
    
    func openImagePicker(animated: Bool = true) {
        present(imagePicker, animated: animated, completion: nil)
    }
    
    private func processImageRunner(_ originalImage: UIImage?) {
        var image: MBImage? = nil
        if let anImage = originalImage {
            image = MBImage(uiImage: anImage)
        }
        image?.cameraFrame = false
        image?.orientation = MBProcessingOrientation.left
        
        
        serialQueue.async(execute: {() -> Void in
            self.recognizerRunner?.processImage(image!)
        })
    }
    
    private func showStepAlert(type sate: scanState) {
        
        let alert = UIAlertController(title: sate.alertTitle(), message: sate.aletMessage(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.openImagePicker()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    private func dismissAfter() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.dismiss(animated: false, completion: nil)
        }
    }
}


extension BlinkIDDocumentsFromGalleyViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            processImageRunner(pickedImage)
        }
        picker.dismiss(animated: false, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        self.dismiss(animated: false, completion: nil)
    }
}

extension BlinkIDDocumentsFromGalleyViewController: MBFirstSideFinishedRecognizerRunnerDelegate {
    
    func recognizerRunnerDidFinishRecognition(ofFirstSide recognizerRunner: MBRecognizerRunner) {
        DispatchQueue.main.async {
            self.showStepAlert(type: .back)
        }
    }
}

extension BlinkIDDocumentsFromGalleyViewController: MBScanningRecognizerRunnerDelegate {
    
    func recognizerRunner(_ recognizerRunner: MBRecognizerRunner, didFinishScanningWith state: MBRecognizerResultState) {
        DispatchQueue.main.async(execute: {() -> Void in
            if state != .valid {
                self.showStepAlert(type: .back)
                self.openImagePicker()
                return
            }
            
            guard let result = self.blinkIdMultiSideRecognizer?.result else { return }
            let customData = BlinkIDEntity.MicroBlinkIDResponseAdapter(microBlinkResult: result)
            
            self.delegate?.didFinishScanning(customData: customData)
            
        })
    }
}

extension BlinkIDDocumentsFromGalleyViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        dismissAfter()
        return nil
    }
}
