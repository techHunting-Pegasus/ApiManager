//
//  Validator.swift
//  Coravida
//
//  Created by Sachtech on 09/04/19.
//  Copyright © 2019 Chanpreet Singh. All rights reserved.
//

import Foundation

extension String{
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
        return self.count > 5
    }
    
    var isAlphanumeric: Bool {
        return range(of: "[^a-zA-Z0-9._]", options: .regularExpression) == nil
    }
    
    // verify Valid PhoneNumber or Not
    func isValidPhone() -> Bool {
        
        let regex = try! NSRegularExpression(pattern: "^[0-9]\\d{9}$", options: .caseInsensitive)
        let valid = regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        print("Mobile validation \(valid)")
        return valid
    }
    
    //ussage if using sitring
    /*let email = "example@example.com"
     let password = "Password@123"
     let phone = "123-456-7890"
     
     if email.isValidEmail {
     print("Email is valid")
     } else {
     print("Email is not valid")
     }
     
     if password.isValidPassword {
     print("Password is valid")
     } else {
     print("Password is not valid")
     }
     
     if phone.isValidPhone() {
     print("Phone number is valid")
     } else {
     print("Phone number is not valid")
     }*/
}

struct Validator{
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    func validate(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        return result
    }
    
    /*
     let email = "example@example.com"
     let password = "Password@123"
     let phone = "123-456-7890"
     
     let validator = Validator()
     
     if validator.isValidEmail(email) {
     print("Email is valid")
     } else {
     print("Email is not valid")
     }
     
     if validator.isPasswordValid(password) {
     print("Password is valid")
     } else {
     print("Password is not valid")
     }
     
     if validator.validate(value: phone) {
     print("Phone number is valid")
     } else {
     print("Phone number is not valid")
     }*/
}




