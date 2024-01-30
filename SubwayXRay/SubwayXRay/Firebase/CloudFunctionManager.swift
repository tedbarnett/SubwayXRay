//
//  CloudFunctionManager.swift
//  SubwayXRay
//
//  Created by MyMac on 09/01/24.
//

import Foundation
import FirebaseFunctions
import FirebaseSharedSwift

struct CloudFunctionManager {
        
    static let shared = CloudFunctionManager()
    var functions = Functions.functions()
    
    func getGTFSACE() {
        
        functions.httpsCallable("getGTFSACEData").call() { result, error in
                        
            if let error = error as NSError? {
                if error.domain == FunctionsErrorDomain {
                    let code = FunctionsErrorCode(rawValue: error.code)
                    let message = error.localizedDescription
                    let details = error.userInfo[FunctionsErrorDetailsKey]
                    
                    print("code: \(String(describing: code))\nmessage: \(message)\ndetails: \(String(describing: details))")
                }
            }
            
            if let data = result?.data as? [String: Any] {
                print("data from cloud function: \(data)")
            }
        }
    }
}
