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

                if let res = self{
                    switch self!.viewModel.type {
                    case .getuser:
                        print("res")
                    case .appointment:
                        print("")
                    case .postApi:
                        print("hello api hit succesfully")
                        print(res)
                    case .none:
                        break
                    }
                }
                
            }.store(in: &isLoadingSubscriptions)
    }
    
    
}
