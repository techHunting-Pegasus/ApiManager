//
//  Utils.swift
//  Camo
//
//  Created by SachTech on 25/02/20.
//  Copyright © 2020 SachTech. All rights reserved.
//

import Foundation



func callOnThread(thread:DispatchQoS.QoSClass,completion:@escaping()->()){
    DispatchQueue.global(qos: thread).async {
        completion()
    }
}

func callOnMain(completion:@escaping()->()){
    DispatchQueue.main.async {
        completion()
    }
}

func callOnMainAfter(secondInt:Int,completion:@escaping()->()){
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(secondInt), execute: {
        completion()
    })
}
