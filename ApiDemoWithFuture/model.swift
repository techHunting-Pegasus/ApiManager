//
//  model.swift
//  ApiDemoWithFuture
//
//  Created by John on 26/04/23.
//

import Foundation




struct Person: JsonDeserializer, Hashable, Decodable,Encodable {
    
    
    var name: String = ""
    var height: String = ""


    mutating func deserialize(values: Dictionary<String, Any>?) {
        name = values?["name"] as? String ?? ""
        height = values?["height"] as? String ?? ""
        
    }
}

struct Person2: JsonDeserializer, Hashable, Decodable,Encodable {
    var mass: String = ""
    var hair_color: String = ""
    var skin_color: String = ""
    
    mutating func deserialize(values: Dictionary<String, Any>?) {
        
        mass = values?["mass"] as? String ?? ""
        hair_color = values?["hair_color"] as? String ?? ""
        skin_color = values?["skin_color"] as? String ?? ""
    }
}


 

struct Appointment: JsonDeserializer, Hashable, Decodable {
    var eyeColor: String = ""
    var birthdate: String = ""
 

    mutating func deserialize(values: Dictionary<String, Any>?) {
        eyeColor = values?["eye_color"] as? String ?? ""
        birthdate = values?["birth_year"] as? String ?? ""
      
    }
}


struct postRes: JsonDeserializer, Hashable, Decodable {
    var id: Int = 1
   

    mutating func deserialize(values: Dictionary<String, Any>?) {
        id = values?["id"] as? Int ?? 1
       
    }
}
