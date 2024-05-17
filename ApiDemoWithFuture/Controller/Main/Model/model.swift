////
////  model.swift
////  ApiDemoWithFuture
////
////  Created by John on 26/04/23.
////
//
//import Foundation
//
//
//
//



import Foundation



struct LoginModel: Codable, Hashable {
    var status: Bool?
    var message: String?
    var data: DataClass?
}

struct DataClass: Codable, Hashable {
    var result: LoginResult?
    var token: String?
    var time: String?
}

struct LoginResult: Codable, Hashable {
    var id: String?
    var name: String?
    var email: String?
    var lastLoginTime: Int?
    var dateOfBirth: String?
    var phoneNo: String?
    var password: String?
    var gender: String?
    var isSubscribe: Int?
    var otp: String?
    var profilePic: String?
    var fcmToken: [LofinFcmToken]?
    var loginSource: String?
    var originalTransactionId: String?
    var subscriptionSource: String?
    var cancelledOn: Int?
    var stripeCustomerId: String?
    var subscriptionId: String?
    var isCancelled: Int?
    var fbUid: String?
    var platform: String?
    var googleId: String?
    var authToken: String?
    var status: Int?
    var v: Int?
    var updateOn: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id", name, email, lastLoginTime = "last_login_time", dateOfBirth = "date_of_birth", phoneNo = "phone_no", password, gender, isSubscribe = "is_subscribe", otp, profilePic = "profile_pic", fcmToken = "Fcm_token", loginSource = "login_source", originalTransactionId = "original_transaction_id", subscriptionSource = "subscription_source", cancelledOn = "cancelled_on", stripeCustomerId = "stripe_customer_id", subscriptionId = "subscription_id", isCancelled = "is_cancelled", fbUid = "fb_uid", platform, googleId = "google_id", authToken = "auth_token", status, v = "__v", updateOn = "updated_on"
    }
}

struct LofinFcmToken: Codable, Hashable {
    var id: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
    }
}

//struct LoginModel: JsonDeserializer, Hashable, Decodable,Encodable  {
//
//    var status: Bool?
//    var message: String?
//    var data = DataClass()
//    mutating func deserialize(values: Dictionary<String, Any>?) {
//        status = values?["status"] as? Bool
//        message = values?["message"] as? String
//
//        //MARK: if the response is direct dictionary
//        if let detail = values?["data"] as? Dictionary<String, Any>{
//
//            data.deserialize(values: detail)
//        }
//
//    }
//}
//
//// MARK: - DataClass
//struct DataClass: JsonDeserializer, Hashable, Decodable,Encodable  {
//
//    var  result = loginResult()
//    var  token : String?
//    var time: String?
//
//    mutating func deserialize(values: Dictionary<String, Any>?) {
//        token = values?["token"] as? String
//        time = values?["time"] as? String
//        if let detail = values?["result"] as? Dictionary<String, Any>{
//     print(detail, "klsfhvisdfivbu")
//            result.deserialize(values: detail)
//        }
//
//    }
//}
//struct loginResult: JsonDeserializer, Hashable, Decodable,Encodable {
//
//    var id: String?
//    var name: String?
//    var email: String?
//    var lastLoginTime: Int?
//    var dateOfBirth: String?
//    var phoneNo: String?
//    var password: String?
//    var gender: String?
//    var isSubscribe: Int?
//    var otp: String?
//    var profilePic: String?
//    var fcmToken : [LofinFcmToken]?
//    var loginSource: String?
//    var originalTransactionId: String?
//    var subscriptionSource: String?
//    var cancelledOn: Int?
//    var stripeCustomerId: String?
//    var subscriptionId: String?
//    var isCancelled: Int?
//    var fbUid: String?
//    var platform: String?
//    var googleId: String?
//    var authToken: String?
//    var status: Int?
//    var v: Int?
//    var updateon: Int?
//
//    mutating func deserialize(values: Dictionary<String, Any>?) {
//        id = values?["_id"] as? String
//        name = values?["name"] as? String
//        email = values?["email"] as? String
//        lastLoginTime = values?["last_login_time"] as? Int
//        dateOfBirth = values?["date_of_birth"] as? String
//        phoneNo = values?["phone_no"] as? String
//        password = values?["password"] as? String
//        gender = values?["gender"] as? String
//        isSubscribe = values?["is_subscribe"] as? Int
//        otp = values?["otp"] as? String
//        profilePic = values?["profile_pic"] as? String
//        if let detail = values?["Fcm_token"] as? Array<Dictionary<String, Any>>{
//            for d in detail{
//                var app = LofinFcmToken.init()
//                app.deserialize(values: d)
//                fcmToken?.append(app)
//            }
//        }
//        loginSource = values?["login_source"] as? String
//        originalTransactionId = values?["original_transaction_id"] as? String
//        subscriptionSource = values?["subscription_source"] as? String
//        cancelledOn = values?["cancelled_on"] as? Int
//        stripeCustomerId = values?["stripe_customer_id"] as? String
//        subscriptionId = values?["subscription_id"] as? String
//        isCancelled = values?["is_cancelled"] as? Int
//        fbUid = values?["fb_uid"] as? String
//        platform = values?["platform"] as? String
//        googleId = values?["google_id"] as? String
//        authToken = values?["auth_token"] as? String
//        status = values?["status"] as? Int
//        v = values?["__v"] as? Int
//        updateon = values?["updated_on"] as? Int
//    }
//
//}
//struct LofinFcmToken : JsonDeserializer, Hashable, Decodable,Encodable {
//
//
//    var _id: String?
//    mutating func deserialize(values: Dictionary<String, Any>?) {
//
//        _id = values?["_id"] as? String
//    }
//
//
//}

//struct Person: JsonDeserializer, Hashable, Decodable,Encodable {
//    
//    
//    var name: String = ""
//    var height: String = ""
//
//
//    mutating func deserialize(values: Dictionary<String, Any>?) {
//        name = values?["name"] as? String ?? ""
//        height = values?["height"] as? String ?? ""
//        
//    }
//}
//
//struct Person2: JsonDeserializer, Hashable, Decodable,Encodable {
//    var mass: String = ""
//    var hair_color: String = ""
//    var skin_color: String = ""
//    
//    mutating func deserialize(values: Dictionary<String, Any>?) {
//        
//        mass = values?["mass"] as? String ?? ""
//        hair_color = values?["hair_color"] as? String ?? ""
//        skin_color = values?["skin_color"] as? String ?? ""
//    }
//}
//
//
// 
//
//struct Appointment: JsonDeserializer, Hashable, Decodable {
//    var eyeColor: String = ""
//    var birthdate: String = ""
// 
//
//    mutating func deserialize(values: Dictionary<String, Any>?) {
//        eyeColor = values?["eye_color"] as? String ?? ""
//        birthdate = values?["birth_year"] as? String ?? ""
//      
//    }
//}
//
//
//struct postRes: JsonDeserializer, Hashable, Decodable {
//    var id: Int = 1
//   
//
//    mutating func deserialize(values: Dictionary<String, Any>?) {
//        id = values?["id"] as? Int ?? 1
//       
//    }
//}
//
//struct createuser: JsonDeserializer, Hashable, Decodable {
//    init() { }
//    var status: String?
//    var message: String?
//    var data = DataClass()
//    mutating func deserialize(values: Dictionary<String, Any>?) {
//        status = values?["status"] as? String
//        message = values?["message"] as? String
//        
//        //MARK: if the response is direct dictionary
//        if let detail = values?["data"] as? Dictionary<String, Any>{
//     
//            data.deserialize(values: detail)
//        }
//        //MARK: if the response isarray of dictionary
////        if let detail = values?["data"] as? Array<Dictionary<String, Any>>{
////            for d in detail{
////                var app = DataClass.init()
////                app.deserialize(values: d)
////                data.append(app)
////            }
////        }
//        
//    }
//}
//
//// MARK: - DataClass
//struct DataClass: JsonDeserializer, Hashable, Decodable {
//    
//    var  name : String?
//    var  salary : String?
//    var age: String?
//    var  id: Int?
//    mutating func deserialize(values: Dictionary<String, Any>?) {
//        name = values?["name"] as? String
//        salary = values?["salary"] as? String
//        age = values?["age"] as? String
//        id = values?["id"] as? Int
//    }
//}
