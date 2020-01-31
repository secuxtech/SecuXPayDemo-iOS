//
//  QRCodeHandler.swift
//  SecuXWallet
//
//  Created by Maochun Sun on 2019/11/10.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import UIKit
import CoreImage

class QRCodeHandler: NSObject {
    
    static func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }

    static func generationQRCodeWithLogo(from string: String, with logo:UIImage) -> UIImage? {
        
        
        guard let qrImg = generateQRCode(from: string) else{
            return nil
        }
        
        
        return addImageLogo(srcImg: qrImg, logoImg: logo, logoSize: logo.size)
    }
    
    
    public static func addImageLogo(srcImg: UIImage, logoImg: UIImage, logoSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(srcImg.size)
        srcImg.draw(in: CGRect(x: 0, y: 0, width: srcImg.size.width, height: srcImg.size.height))
        let rect = CGRect(x: srcImg.size.width / 2 - logoSize.width / 2,
                          y: srcImg.size.height / 2 - logoSize.height / 2,
                          width: logoSize.width,
                          height: logoSize.height)
        logoImg.draw(in: rect)
        let resultingImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultingImage!
    }
}


