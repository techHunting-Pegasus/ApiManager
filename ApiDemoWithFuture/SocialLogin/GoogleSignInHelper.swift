

import UIKit
import GoogleSignIn

class GoogleSignInHelper: NSObject{

    //MARK: Variables
    static let shared = GoogleSignInHelper()
    private var completion : ((SocialSignInModel?) -> ())?
    private var model : SocialSignInModel?
    private var presentationController : UIViewController?

    func googleSignIn(with view: UIViewController,completion : @escaping (SocialSignInModel?) -> ()){
       // let config = GIDConfiguration(clientID: "734412433009-hua8gppg3t4cnj8gdvreor8g5d2a08kr.apps.googleusercontent.com")
                self.completion = completion
        
        // Start the sign in flow!
//        GIDSignIn.sharedInstance.sighcvh
        GIDSignIn.sharedInstance.signIn(withPresenting: view) { [unowned self] userr, error in

                    if let user = userr{
                        let model = SocialSignInModel()
                        model.id = user.user.userID
                        model.name = user.user.profile?.name
                        model.firstName = user.user.profile?.givenName
                        model.lastName = user.user.profile?.familyName
                        model.email = user.user.profile?.email
                        self.completion?(model)
                    }
        }
        
        
        
        
        // Insert Client Id here  OLD CODE
//        GIDSignIn.sharedInstance.clientID = "882529681402-ouqhejq6mjsac7bq8vi1bu5plq2t7ns7.apps.googleusercontent.com"
//        self.presentationController = view
//        self.completion = completion
//        GIDSignIn.sharedInstance().delegate = self
//        GIDSignIn.sharedInstance()?.presentingViewController = view
//        GIDSignIn.sharedInstance().uiDelegate = self
//        GIDSignIn.sharedInstance().signIn()

    }

    func googleLogout(){

        GIDSignIn.sharedInstance.signOut()
    }


}

//extension GoogleSignInHelper : GIDSignInDelegate{
//
//    // Present a view that prompts the user  to sign in with Google
//    func sign(_ signIn: GIDSignIn!,
//              present viewController: UIViewController!) {
//
//        self.presentationController?.present(viewController, animated: true, completion: nil)
//    }
//
//    // Dismiss the "Sign in with Google" view
//    func sign(_ signIn: GIDSignIn!,
//              dismiss viewController: UIViewController!) {
//
//        self.presentationController?.dismiss(animated: true, completion: nil)
//    }
//
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//
//        if let error = error {
//
//            print("\(error.localizedDescription)")
//            self.completion?(nil)
//        }
//
//        if let user = user{
//            let model = SocialSignInModel()
//            model.id = user.userID
//            model.name = user.profile.name
//            model.firstName = user.profile.givenName
//            model.lastName = user.profile.familyName
//            model.email = user.profile.email
//
//            self.completion?(model)
//        }
//        self.presentationController?.dismiss(animated: true, completion: nil)
//    }
//
//    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
//              withError error: Error!) {
//        // Perform any operations when the user disconnects from app here.
//        // ...
//    }
//}
