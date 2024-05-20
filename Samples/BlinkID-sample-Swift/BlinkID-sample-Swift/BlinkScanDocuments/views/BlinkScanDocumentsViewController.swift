//
//  BlinkScanDocumentsViewController.swift
//  basBlinkId
//
//  Created by Emmanuel Zambrano Quitian on 4/26/24.
//

import UIKit
import BlinkID

enum typeOfBlinkIDView {
    case native
    case custom
}

class BlinkScanDocumentsViewController: UIViewController, BlinkScanDocumentsViewControllerProtocol {
    
    var blinkIdRecognizer: MBBlinkIdMultiSideRecognizer?
    var presenter: BlinkScanDocumentsPresenterProtocol?
    var hasStart = false
    var didFinish = false
    var viewType: typeOfBlinkIDView?
    
    
    override func viewDidLoad() {
        var didFinish = false
        MBMicroblinkSDK.shared().setLicenseKey("sRwCABJjb20ucGVyc29uYS5FbW1hSUQBbGV5SkRjbVZoZEdWa1QyNGlPakUzTVRVM09EVXlPREkwT1RJc0lrTnlaV0YwWldSR2IzSWlPaUkzWldGaFl6YzVPUzA0WWpGbUxUUXhabUl0T1RaaVl5MHdZV0V6WVdVNE4yRTRNelVpZlE9PeMxZOitNAlXL0VIpBHILp13eBm/6ODvNjFMleKxdWqldflQDeAmjxVU5XdR8HCKPJzVRSQXmQYpPuE/hwu8vG3BqOJsBWqCRGcInGVxjtb/ro0w9qIa3Sp8TPAq35CKj95TvRPv4QrGGCAkCTwx/zFsLcu2wyLw") {[weak self] _ in
            self?.showErrorAlert()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !hasStart {
            checkForPermission()
            hasStart = true
            didFinish = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        hasStart = didFinish ? false : true
    }
    
    func checkForPermission() {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { [weak self] response in
            if response {
                DispatchQueue.main.async {
                    self?.viewType == .native ? self?.startBlinkId() : self?.startCustomView()
                }
            }
        }
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Error interno", message: "A ocurrido un error intenta mas tarde", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            guard let navigationController = self.navigationController else { return }
            self.presenter?.popScanDocumentsMicroBlink(with: navigationController)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func startBlinkId() {
        self.blinkIdRecognizer = MBBlinkIdMultiSideRecognizer()
        self.blinkIdRecognizer?.returnFullDocumentImage = true
        
        let settings: MBBlinkIdOverlaySettings = MBBlinkIdOverlaySettings()
        
        let recognizerList = [self.blinkIdRecognizer!]
        let recognizerCollection: MBRecognizerCollection = MBRecognizerCollection(recognizers: recognizerList)
        
        let blinkIdOverlayViewController: MBBlinkIdOverlayViewController =
        MBBlinkIdOverlayViewController(settings: settings, recognizerCollection: recognizerCollection, delegate: self)
        
        guard let recognizerRunneViewController: UIViewController =
                MBViewControllerFactory.recognizerRunnerViewController(withOverlayViewController: blinkIdOverlayViewController) else {
            return
        }
        recognizerRunneViewController.modalPresentationStyle = .fullScreen
        
        self.present(recognizerRunneViewController, animated: false, completion: nil)
    }
    func startCustomView() {
        self.blinkIdRecognizer = MBBlinkIdMultiSideRecognizer()
        self.blinkIdRecognizer?.returnFullDocumentImage = true

        /** Crate recognizer collection */
        let recognizerList = [self.blinkIdRecognizer!]
        let recognizerCollection: MBRecognizerCollection = MBRecognizerCollection(recognizers: recognizerList)

        let customOverlayViewController = CostumeBlinkIDDocumentsViewController()
        customOverlayViewController.delegate = self

        customOverlayViewController.reconfigureRecognizers(recognizerCollection)

        guard let recognizerRunneViewController: UIViewController =
            MBViewControllerFactory.recognizerRunnerViewController(withOverlayViewController: customOverlayViewController) else {
                return
        }

        recognizerRunneViewController.modalPresentationStyle = .fullScreen

        self.present(recognizerRunneViewController, animated: false, completion: nil)
    }
    
    func popView() {
        hasStart = true
        self.dismiss(animated: false, completion: nil)
        guard let navigationController = self.navigationController else { return }
        self.presenter?.popScanDocumentsMicroBlink(with: navigationController)
        
    }
    
    func goToDocumentsPreview(customData: BlinkIDEntity) {
        didFinish = true
        self.dismiss(animated: false, completion: nil)
        guard let navigationController = self.navigationController else { return }
        presenter?.goToDocumentsPreview(data: customData, navigationController: navigationController)
    }
}

extension BlinkScanDocumentsViewController: MBBlinkIdOverlayViewControllerDelegate {
    func blinkIdOverlayViewControllerDidFinishScanning(_ blinkIdOverlayViewController: MBBlinkIdOverlayViewController, state: MBRecognizerResultState) {
        blinkIdOverlayViewController.recognizerRunnerViewController?.pauseScanning()
        
        guard let result = self.blinkIdRecognizer?.result else { return }
        let customData = BlinkIDEntity.MicroBlinkIDResponseAdapter(microBlinkResult: result)
        goToDocumentsPreview(customData: customData)
    }
    
    func blinkIdOverlayViewControllerDidTapClose(_ blinkIdOverlayViewController: MBBlinkIdOverlayViewController) {
        popView()
    }
}

extension BlinkScanDocumentsViewController: CostumeBlinkIDDocumentsProtocol {
    func didTapClose() {
        popView()
    }
    
    func didFinishScanning(customData: BlinkIDEntity) {
        goToDocumentsPreview(customData: customData)
    }
}
