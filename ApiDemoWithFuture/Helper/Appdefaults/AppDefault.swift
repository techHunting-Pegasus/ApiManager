//
//  AppDefault.swift
//  ApiDemoWithFuture
//
//  Created by John on 27/04/23.
//

import Foundation
struct  AppDefaults{
    
    static var accessToken: String{
        set{
            UserDefaults.standard.set(newValue, forKey: "accessToken")
        }
        get{
            return UserDefaults.standard.string(forKey:  "accessToken") ?? ""
        }
    }
    static var userData: LoginModel{
        set{
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey:"userData")
        }
        get{
            if let data = UserDefaults.standard.value(forKey:"userData") as? Data {
                let userData = (try? PropertyListDecoder().decode(LoginModel.self, from: data)) ?? LoginModel()
                return userData
            }
            else{
              return LoginModel()
            }
        }
    }

}
