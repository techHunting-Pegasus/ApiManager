

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class FacebookSignInHelper: NSObject {
    
    //MARK: Variables
    static let shared = FacebookSignInHelper()

    func facebookSignIn(with view: UIViewController,completion : @escaping (SocialSignInModel?) -> ()){
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["email","public_profile"], from: view) { (loginResult, error) in
            
            if let result = loginResult, result.isCancelled == false{
                
                self.getUserData(completion: { (model) in
                    
                    completion(model)
                })
            }
            else{
                
                print("\(error?.localizedDescription ?? "")")
                completion(nil)
            }
        }
    }
    
    func facebookLogout(){
        
        let loginManager = LoginManager()
        loginManager.logOut()
    }
    
    //MARK: Private Methods
    
    private func getUserData(completion : @escaping (SocialSignInModel?) -> ()){
        
        let param = ["fields": "id, name, picture.type(large), email,first_name,last_name"]
        GraphRequest.init(graphPath: "me", parameters: param).start { connection, result, error in
//
//        }
//        GraphRequest.init(graphPath: "me", parameters: param).start(completionHandler: { (connection, result, error) in

            if let error = error{
                
                print("\(error.localizedDescription)")
                completion(nil)
            }
            
            if let dict = result as? [String:Any]{
                
                let model = SocialSignInModel()
                model.firstName = dict["first_name"] as? String
                model.lastName = dict["last_name"] as? String
                model.email = dict["email"] as? String
                model.name = dict["name"] as? String
                model.id = dict["id"] as? String
                
                if let dictProfile = dict["picture"] as? [String:Any]{
                    if let data = dictProfile["data"] as? [String:Any]{
                        model.profileURl = data["url"] as? String
                    }
                }
                
                completion(model)
            }
        }
//        )
    }
}
