//
//  BlinkScanDocumentsPresenter.swift
//  basBlinkId
//
//  Created by Emmanuel Zambrano Quitian on 4/26/24.
//

import UIKit

class BlinkScanDocumentsPresenter: BlinkScanDocumentsPresenterProtocol {
    func goToDocumentsPreview(data: BlinkIDEntity, navigationController: UINavigationController) {
        router?.goToDocumentsPreview(data: data, navigationController: navigationController)
    }
    var interactor: BlinkScanDocumentsInteractorProtocol?
    var router: BlinkScanDocumentsRouterProtocol?
    func popScanDocumentsMicroBlink(with navigationController: UINavigationController) {
        router?.popScanDocumentsMicroBlink(with: navigationController)
    }
}
