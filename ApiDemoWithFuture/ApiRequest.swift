//
//  ApiRequest.swift
//  ApiDemoWithFuture
//
//  Created by John on 26/04/23.
//

import Foundation
import UIKit

protocol JsonSerilizer{
    func serilize() -> Dictionary<String,Any>
}

struct AppRequest : JsonSerilizer {
  
    var title: String = ""
    var body : String = ""
    
    func serilize() -> Dictionary<String, Any> {
        return [
          
            "title": title,
            "body": body,
        ]
    }
}
