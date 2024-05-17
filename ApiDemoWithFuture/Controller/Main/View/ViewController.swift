//
//  ViewController.swift
//  ApiDemoWithFuture
//
//  Created by John on 26/04/23.
//

import UIKit
import Combine

class ViewController: BaseVC {
    private let apiService = APIService()
    private var viewModel = ViewModel()
    var isLoadingSubscriptions = Set<AnyCancellable>()
    
    
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var lblname2: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observer()
      
//        viewModel.getPerson()
    }
    
    @IBAction   func apiButton(_ sender: UIButton) {
        viewModel.create(createuserdata:AppRequest(name: "ishpreet singh", salary: "78955", age: "25"))

    }
    
    
    @IBAction func secondBUtton(_ sender: Any) {

        
    }
    
    
    fileprivate func observer() {
        viewModel.$isLoading.sink { [weak self] isLoading in
            if let wkSelf = self{
                isLoading ? wkSelf.showLoader():wkSelf.hideLoader()}
            }.store(in: &isLoadingSubscriptions)
        
            viewModel.$Appresponse.combineLatest( viewModel.$error)
            .sink { [weak self] response, error in

                guard let self = self else{return}
                print(response, "response")
                if (response.login.status == true) {
                   
                }else if (response.login.status == false){
                    
                }
                else{
                    if let err = error{
                        if err.localizedDescription != ""{
                            showAlert("\(err.localizedDescription)")
                        }
                    }
                }
                
            }.store(in: &isLoadingSubscriptions)
    }
    
    
}
