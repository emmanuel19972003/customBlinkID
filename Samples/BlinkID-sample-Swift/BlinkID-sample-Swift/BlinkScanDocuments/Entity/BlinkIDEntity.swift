//
//  BlinkIDEntity.swift
//  basBlinkId
//
//  Created by Emmanuel Zambrano Quitian on 4/26/24.
//

import Foundation
import BlinkID

struct BlinkIDEntity {
    let fullName: String?
    let firstName: String?
    let fathersName: String?
    let mothersName: String?
    let documentNumber: String?
    let personalIdNumber: String?
    let dateOfBirth: String?
    let dateOfIssue: String?
    let dateOfExpiry: String?
    let address: String?
    let backINE: UIImage?
    let frontINE: UIImage?
    static func microBlinkIDResponseAdapter(microBlinkResult result: MBBlinkIdMultiSideRecognizerResult) -> BlinkIDEntity{
        return BlinkIDEntity(fullName: result.fullName?.description,
                             firstName: result.firstName?.description,
                             fathersName: result.fathersName?.description,
                             mothersName: result.mothersName?.description,
                             documentNumber: result.documentNumber?.description,
                             personalIdNumber: result.personalIdNumber?.description,
                             dateOfBirth: result.dateOfBirth?.description,
                             dateOfIssue: result.dateOfIssue?.description,
                             dateOfExpiry: result.dateOfExpiry?.description,
                             address: result.address?.description,
                             backINE: result.fullDocumentBackImage?.image,
                             frontINE: result.fullDocumentFrontImage?.image
        )
    }
}
