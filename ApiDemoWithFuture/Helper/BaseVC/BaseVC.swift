import Foundation
import UIKit

import SVProgressHUD
import Lottie
import Combine
import StoreKit
//import FirebaseAuth
//import KYDrawerController

class BaseViewController: UIViewController {
    
    //MARK: Userdefined Variables
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let userDefaults = UserDefaults.standard
    var isFromPopUp:Bool = false
    var typee:UIImagePickerController.SourceType = .camera
    var subscriptions = Set<AnyCancellable>()
    
    var updateIsAvailable = false
    private var  ImageView : LottieAnimationView? = nil
    
    
        private var activityIndicator: UIActivityIndicatorView?
        
    
    //MARK: Lifecycles
    override func viewDidLoad() {
//        if updateIsAvailable {
//               showUpdateAlert()
//        }else{
//            print("no update  @@@@@@@@@@++++++++=======>")
//
//        }
        
        ConfigUI()
        hideNavBar()
        setProgressHUD()
        Networklost()
        view.addSubview(ImageView!)
    }
    
    override func viewDidLayoutSubviews() {
        ImageView!.frame = CGRect(x: 0,
                                 y: 0,
                                  width: self.view.frame.width,
                                 height: self.view.frame.height)
    }
    func extractYouTubeID(from url: String) -> String? {
        let regexString = "^https?://(?:www\\.)?(?:youtube\\.com/watch\\?v=|youtu\\.be/)([\\w-]+)"
        if let regex = try? NSRegularExpression(pattern: regexString, options: .caseInsensitive) {
            let range = NSRange(location: 0, length: url.utf16.count)
            if let match = regex.firstMatch(in: url, options: [], range: range) {
                let videoIDRange = match.range(at: 1)
                if let swiftRange = Range(videoIDRange, in: url) {
                    return String(url[swiftRange])
                }
            }
        }
        return nil
    }
      
    func ConfigUI(){
        ImageView = .init(name: "54633-no-internet-access-animation.json")
           ImageView!.contentMode = .scaleAspectFit
           ImageView!.loopMode = .loop
           ImageView!.animationSpeed = 0.5
           ImageView?.backgroundColor = UIColor(named: "Color") ?? .black
           ImageView?.layer.zPosition = 999999999999999999
           view.backgroundColor = .white
           ImageView!.play()
           self.ImageView?.isHidden = true
    }
    func Networklost(){
        Reachability.shared.publisher
                   .sink { path in
                       if path.isReachable {
                           
                           print("isOn")
                           self.ImageView?.isHidden = true
                          
                       } else {
                           print("isOff")
                           self.ImageView?.isHidden = false
                         
                       }
                   }
                   .store(in: &subscriptions)
    }
    
    
    func pop(){
        self.navigationController?.popViewController(animated: true)
    }
    func hideNavBar(){
        navigationController?.navigationBar.isHidden = true
    }
    func showError(_ error: Error) {
        // Show an error message to the user
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showNavBar(backgroundColor: UIColor,textColor:UIColor,titleVc:String? = nil){
       
        setNavBar(backgroundColor: backgroundColor, textColor: textColor,title: titleVc)
    
    }
  
    func setProgressHUD(){
//    SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: self.view.frame.midX, vertical: self.view.frame.midY))

    SVProgressHUD.setRingThickness(3)
    SVProgressHUD.setDefaultStyle(.custom)
    SVProgressHUD.setDefaultMaskType(.custom)
    SVProgressHUD.setForegroundColor(UIColor(named: "themeDarkGreen") ?? UIColor.green) //Ring Color
    SVProgressHUD.setBackgroundColor(UIColor.white) //HUD Color
    SVProgressHUD.setBackgroundLayerColor(UIColor.black.withAlphaComponent(0.4))//Background Color
    }
    
 
    
    func setTransparentNavBar(){
        navigationController?.transparentNavBar()
    }
    
    func setNavBar(backgroundColor:UIColor,textColor:UIColor,title:String? = nil){
        let lblText = UILabel()
        lblText.font = UIFont(name: "AvenirNextLTPro-Bold", size: 18.0)
        lblText.textColor = textColor
        lblText.text = title ??  self.title
        navigationItem.titleView = lblText
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = backgroundColor
        navigationController?.navigationBar.isHidden = false
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = backgroundColor
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance =  self.navigationController?.navigationBar.standardAppearance
        } else {
            // Fallback on earlier versions
        }
        
    }
    
  
   
 
    
    func randomString() -> String {
        let length = 24
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func getJoinedString(arr: [String])-> String{
        if arr.count == 1{
            return arr[0]
        }else if arr.count == 2{
            return arr.joined(separator: "and")
        }else if arr.count > 2{
            let lastElement = arr.last ?? ""
            var arrStr = arr
            arrStr.removeLast()
            let str = arrStr.joined(separator: ", ")
            let arr = [str, lastElement]
            return arr.joined(separator: " and ")
        }else{
            return ""
        }
    }
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: Constant.AppName, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK:- Custom Progress Setup
    func showProgress(_ text: String = "Loading"){
        callOnMain {
            
            SVProgressHUD.show()
            UIApplication.shared.windows.first { $0.isKeyWindow }?.isUserInteractionEnabled = false


        }
    }
    
    
    func hideProgress(){
        callOnMain {
            SVProgressHUD.dismiss()
            
            UIApplication.shared.windows.first { $0.isKeyWindow }?.isUserInteractionEnabled = true

        }
    }
    

    //MARK: SHOW VERSIONALERT
    
  
    
 
    //MARK: check update
    
    
    

    
//    func checkForUpdates(){
//        let appId = "1666464256"
//        let appStoreURL = URL(string: "https://itunes.apple.com/app/id\(appId)?mt=8&action=write-review")!
//
//        let storeViewController = SKStoreProductViewController()
//        storeViewController.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: appId]) { (success, error) in
//            if success {
//                self.present(storeViewController, animated: true, completion: nil)
//            } else {
//                print("Error: \(error?.localizedDescription ?? "Unknown error")")
//            }
//        }
//
//
//        let bundleIdentifier = Bundle.main.bundleIdentifier!
//        let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(bundleIdentifier)")!
//
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//
//            guard let data = data else {
//                print("Error: No data received")
//                return
//            }
//
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                let results = json["results"] as! [[String: Any]]
//                let currentVersion = results[0]["version"] as! String
//
//                // Compare current version with installed version
//                let installedVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
//
//                if currentVersion != installedVersion {
//                    // Show update notification
//                    let alert = UIAlertController(title: "Update Available", message: "A new version of the app is available. Do you want to update now?", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { _ in
//                        // Open App Store page
//                        self.present(storeViewController, animated: true, completion: nil)
//                    }))
//
//                }
//            } catch {
//                print("Error: \(error.localizedDescription)")
//            }
//        }
//
//        task.resume()
//
//    }
    
    
}

extension BaseViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    func presentPickerSelector(view:UICollectionView){
        
        let picker = UIImagePickerController()
        picker.delegate = self
//        picker.allowsEditing = true
        
        let alert = UIAlertController(title: "Select image from", message: nil, preferredStyle:    UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (handler) in
            picker.allowsEditing = false
            picker.sourceType = .camera
            picker.sourceType = UIImagePickerController.SourceType.camera
            
            picker.showsCameraControls = true
           
            picker.cameraCaptureMode = .photo
            self.typee = .camera
            self.present(picker, animated: true, completion: nil)
            
        }
        
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { (handler) in
            picker.allowsEditing = true
            picker.sourceType = .photoLibrary
            self.typee = .photoLibrary
            self.present(picker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (handler) in
            
        }
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = view
            presenter.sourceRect = view.bounds
        }
        present(alert, animated: true)
    }
}



