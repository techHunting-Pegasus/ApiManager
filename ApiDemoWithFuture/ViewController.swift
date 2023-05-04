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
        
        
    }
    
    @IBAction   func apiButton(_ sender: UIButton) {
        // Call the fetchData() method of the ViewModel
//        viewModel.postExample(parameters: AppRequest(title: "hello ishpree singh", body: "hello ios developer"))
        
        
    }
    
    
    @IBAction func secondBUtton(_ sender: Any) {
//        viewModel.getappoint()
        
        viewModel.multipleAPI()
        
    }
    
    
    fileprivate func observer() {
        viewModel.$isLoading.sink { [weak self] isLoading in
            if let wkSelf = self{
                isLoading ? wkSelf.showLoader():wkSelf.hideLoader()}
            }.store(in: &isLoadingSubscriptions)
        
            viewModel.$Appresponse.combineLatest( viewModel.$error)
            .sink { [weak self] response, error in

                if let _ = self{
                    switch self!.viewModel.type {
                    case .getuser:
                        print("")
                    case .appointment:
                        print("")
                    case .postApi:
                        print("hello api hit succesfully")
                        
                    case .none:
                        break
                    }
                }
                
            }.store(in: &isLoadingSubscriptions)
    }
    
    
}
