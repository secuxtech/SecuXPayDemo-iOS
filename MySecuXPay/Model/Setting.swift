//
//  Setting.swift
//  SecuXWallet
//
//  Created by Maochun Sun on 2019/11/8.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import Foundation



class Setting: NSObject {
    
    var hasInternet = Observable<Bool>(value: true)

    
    var showPaymentPage = false

    
    static let shared: Setting = {
        let shared = Setting()
        
        return shared
    }()

    private override init(){
        super.init()
        print("Setting init")
    }
    
    deinit {
        print("Setting deinit")
    }

}
