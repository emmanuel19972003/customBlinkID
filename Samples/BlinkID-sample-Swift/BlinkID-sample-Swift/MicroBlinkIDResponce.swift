//
//  MicroBlinkIDResponce.swift
//  GSSMyDealMyCommunity
//
//  Created by Emmanuel Zambrano on 17/04/24.
//

import Foundation
import BlinkID

struct MicroBlinkIDResponce {
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
    
    static func MicroBlinkIDResponceAdapter(microBlinkResult result: MBBlinkIdMultiSideRecognizerResult) -> MicroBlinkIDResponce{
        return MicroBlinkIDResponce(fullName: result.fullName?.description,
                                            firstName: result.firstName?.description,
                                            fathersName: result.fathersName?.description,
                                            mothersName: result.mothersName?.description,
                                            documentNumber: result.documentNumber?.description,
                                            personalIdNumber: result.personalIdNumber?.description,
                                            dateOfBirth: result.dateOfBirth?.description,
                                            dateOfIssue: result.dateOfIssue?.description,
                                            dateOfExpiry: result.dateOfExpiry?.description,
                                            address: result.address?.description)
        
    }
}

