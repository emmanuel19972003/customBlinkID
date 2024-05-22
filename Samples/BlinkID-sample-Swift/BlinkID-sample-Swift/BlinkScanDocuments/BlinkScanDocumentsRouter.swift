//
//  BlinkScanDocumentsRouter.swift
//  basBlinkId
//
//  Created by Emmanuel Zambrano Quitian on 4/26/24.
//

import UIKit

class BlinkScanDocumentsRouter: BlinkScanDocumentsRouterProtocol {
    
    static func getBlinkIdView(viewType: typeOfBlinkIDView = .native) -> UIViewController {
        let viewController = BlinkScanDocumentsViewController()
        let presenter = BlinkScanDocumentsPresenter()
        let interactor = BlinkScanDocumentsInteractor()
        let router = BlinkScanDocumentsRouter()
        
        viewController.presenter = presenter
        viewController.viewType = viewType
        
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return viewController
    }
    
    func popScanDocumentsMicroBlink(with navigationController: UINavigationController) {
        navigationController.popViewController(animated: true)
    }
    func goToDocumentsPreview(data: BlinkIDEntity, navigationController: UINavigationController) {
        let vc = resultView()
        vc.addImage(setImage: data)
        navigationController.pushViewController(vc, animated: true)
    }
}


