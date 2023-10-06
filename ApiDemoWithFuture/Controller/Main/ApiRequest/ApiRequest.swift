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

struct CommonRequest: JsonSerilizer {
    
    func serilize() -> Dictionary<String, Any> {
        return [:]
    }
}

struct AppRequest : JsonSerilizer {
  
    var name: String = ""
    var salary : String = ""
    var age : String = ""
    
    func serilize() -> Dictionary<String, Any> {
        return [
          
            "name": name,
            "salary": salary,
            "age": age
        ]
    }
}
