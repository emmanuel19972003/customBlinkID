//
//  BlinkScanDocumentsProtocols.swift
//  basBlinkId
//
//  Created by Emmanuel Zambrano Quitian on 4/26/24.
//

import UIKit

protocol BlinkScanDocumentsViewControllerProtocol {
    var presenter: BlinkScanDocumentsPresenterProtocol? { get set }
}
protocol BlinkScanDocumentsPresenterProtocol {
    var interactor: BlinkScanDocumentsInteractorProtocol? { get set }
    var router: BlinkScanDocumentsRouterProtocol? { get set }
    func popScanDocumentsMicroBlink(with navigationController: UINavigationController)
    func goToDocumentsPreview(data: BlinkIDEntity, navigationController: UINavigationController)
}
protocol BlinkScanDocumentsInteractorProtocol {
    var presenter: BlinkScanDocumentsPresenterProtocol? { get set }
}
protocol BlinkScanDocumentsRouterProtocol {
    static func getBlinkIdView(viewType: typeOfBlinkIDView) -> UIViewController
    func popScanDocumentsMicroBlink(with navigationController: UINavigationController)
    func goToDocumentsPreview(data: BlinkIDEntity, navigationController: UINavigationController)
}
