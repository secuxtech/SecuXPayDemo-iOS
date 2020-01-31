//
//  UISetting.swift
//  SecuXWallet
//
//  Created by Maochun Sun on 2019/11/26.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import Foundation
import UIKit

class UISetting: NSObject {
    
    var portfolioBKColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
    var fontName = "Helvetica"
    var boldFontName = "Helvetica-Bold"
    
    static let shared: UISetting = {
        let shared = UISetting()
        
        return shared
    }()

    private override init(){
        super.init()
        print("UISetting init")
        
 
    }
    
    deinit {
        print("UISetting deinit")
    }
    
}
