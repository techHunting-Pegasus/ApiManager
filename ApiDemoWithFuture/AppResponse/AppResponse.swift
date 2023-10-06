//
//  AppResponse.swift
//  Bio Family
//
//  Created by John on 04/01/23.
//

//import Foundation
//
protocol JsonDeserializer {
    init()
    mutating func deserialize(values: Dictionary<String, Any>?)
}

struct AppResponse {
    var person : Person = Person()
    var Apppint: Appointment = Appointment()
    var postExa: postRes = postRes()
    var createuUser: createuser = createuser()
}

