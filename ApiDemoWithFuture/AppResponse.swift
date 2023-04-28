//
//  AppResponse.swift
//  Bio Family
//
//  Created by John on 04/01/23.
//

import Foundation

struct AppResponse: JsonDeserilizer {
    
    var statusCode: Int = 0
    var status: Bool = false
    var message: String = ""
    var getapp : [GetAppointment] = []
    var getNotify : [NotificationModel] = []
    mutating func deserilize(values: Dictionary<String, Any>?) {
        status = values?["status"] as? Bool ?? false
        message = values?["message"] as? String ?? ""
        if let detail = values?["data"] as? Array<Dictionary<String, Any>>{
            for d in detail{
                var app = GetAppointment.init()
                app.deserilize(values: d)
                getapp.append(app)
                
                
            }
        }
        
        
        
        if let detail = values?["data"] as? Dictionary<String, Any>{
            if let notify = detail["notification"] as? Array<Dictionary<String, Any>>{
                for d in notify{
                    var app = NotificationModel.init()
                    app.deserilize(values: d)
                    getNotify.append(app)
                    
                    
                }}
        }
    }
    
}

struct GetAppointment: JsonDeserilizer,Hashable {
    var statusCode: Int = 0
    var status: Int = -1
    var message:String = ""
    var id:String = ""
    var insuranceName: String = ""
    var reasonOfAppointment:String = ""
    var createdoOn: Int = 0
    var updateOn = ""
    var v = ""
    var date :String = ""
    
    mutating func deserilize(values: Dictionary<String, Any>?) {
        status = values?["status"] as? Int ?? -1
        message = values?["message"] as? String ?? ""
        id = values?["_id"] as? String ?? ""
        insuranceName = values?["insurance_name"] as? String ?? ""
        reasonOfAppointment = values?["reason"] as? String ?? ""
        createdoOn = values?["created_on"] as? Int ?? 0
        updateOn = values?["updated_on"] as? String ?? ""
        v = values?["__v"] as? String ?? ""
        var datee = Date(timeIntervalSince1970: Double(createdoOn))
        date = datee.getFormattedDate("MM/dd/yyyy")
        
    }
}
struct NotificationModel: JsonDeserilizer,Hashable {
    var statusCode: Int = 0
    var status: Int = -1
    var message:String = ""
    var id:String = ""
    var title:String = ""
    var notifiedon: Int = 0
    var image : String = ""
    var date :String = ""
    
    mutating func deserilize(values: Dictionary<String, Any>?) {
        status = values?["status"] as? Int ?? -1
        message = values?["message"] as? String ?? ""
        id = values?["_id"] as? String ?? ""
        title = values?["title"] as? String ?? ""
        notifiedon = values?["notified_on"] as? Int ?? 0
        image = values?["image_url"] as? String ?? ""
        var datee = Date(timeIntervalSince1970: Double(notifiedon))
        date = datee.getFormattedDate("MM/dd/yyyy")
        
    }
}
