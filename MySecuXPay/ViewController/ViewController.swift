//
//  ViewController.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/1/16.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit
import swiftScan
import SecuXPaymentKit



class ViewController: BaseViewController {
    
    lazy var scanQRCodeButton:  UIRoundedButtonWithGradientAndShadow = {
        
        let btn = UIRoundedButtonWithGradientAndShadow(gradientColors: [UIColor(red: 0xEB/0xFF, green: 0xCB/0xFF, blue: 0x56/0xFF, alpha: 1), UIColor(red: 0xEB/0xFF, green: 0xCB/0xFF, blue: 0x56/0xFF, alpha: 1)])
        
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.titleLabel?.font = UIFont(name: "Arial", size: 22)
        btn.setTitle(NSLocalizedString("Scan QR code", comment: ""), for: .normal)
        btn.setTitleColor(UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(scanQRCodeAction), for: .touchUpInside)
        
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 2
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowOpacity = 0.3
        
        
        self.view.addSubview(btn)
        
        
        
        NSLayoutConstraint.activate([
            
            btn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -10),
            btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            btn.heightAnchor.constraint(equalToConstant: 48.63),
            btn.widthAnchor.constraint(equalToConstant: 199.54)
            
        ])
       
        return btn
    }()
    
    lazy var itemImg: UIImageView = {

        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_payment_history")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
           
            imageView.centerYAnchor.constraint(equalTo: self.historyButton.centerYAnchor),
            imageView.rightAnchor.constraint(equalTo: self.historyButton.leftAnchor, constant: -5)
           
        ])
        
        return imageView
    }()

    lazy var historyButton: UIButton = {
       
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false

        
        let btnAttributes: [NSAttributedString.Key: Any] = [
                            .font: UIFont(name: "Arial", size: 17)!,
                            .foregroundColor: UIColor.black,
                            .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let attributeString = NSMutableAttributedString(string: "Payment History",
                                                        attributes: btnAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
        
        //btn.titleLabel?.font = UIFont(name: "Arial", size: 17)
        //btn.setTitle("Payment History", for: .normal)
        //btn.setTitleColor(.black, for: .normal)
        
        
        
        btn.addTarget(self, action: #selector(historyAction), for: .touchUpInside)
        

        self.view.addSubview(btn)

        NSLayoutConstraint.activate([
           
            btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            btn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -28)
           
        ])

        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        var _ = self.scanQRCodeButton
        var _ = self.itemImg
        var _ = self.historyButton
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationItem.title = ""
    }
    
    @objc func historyAction(){
        
        let vc = PaymentHistoryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @objc func scanQRCodeAction(){
        
        var style = LBXScanViewStyle()
        style.centerUpOffset = 44
        style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.On
        style.photoframeLineW = 6
        style.photoframeAngleW = 24
        style.photoframeAngleH = 24
        style.colorAngle = UIColor(red: 0xEB/0xFF, green: 0xCB/0xFF, blue: 0x56/0xFF, alpha: 1)
        style.isNeedShowRetangle = true
        
        style.anmiationStyle = LBXScanViewAnimationStyle.NetGrid

        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_part_net")
        
        let vc = LBXScanViewController()
        vc.scanStyle = style
        vc.scanResultDelegate = self
        
        //vc.modalPresentationStyle = .overCurrentContext
        //self.present(vc, animated: true, completion: nil)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(vc, animated: true)
        
    }


}

extension ViewController: LBXScanViewControllerDelegate{
    func scanFinished(scanResult: LBXScanResult, error: String?) {
        
        print("scan ret = \(scanResult.strScanned ?? "")")
        
        /*
         {"amount":"100", "coinType":"DCT", "deviceID": "4ab10000726b"}
        */
        
        if let payInfoStr = scanResult.strScanned{
            
            do{
                if let data = payInfoStr.data(using: String.Encoding.utf8){
              
                    let json  = try JSONSerialization.jsonObject(with: data, options: []) as! [String : String]
                    print(json)
                    
                  
                    if let devID = json["deviceID"]{
                        
                        
                        let amount = json["amount"] ?? "0"
                        
                        var showAccSelection = false
                        var coinType : CoinType = .DCT
                        if let type = json["coinType"], type.count > 0{
                    
                            if let cType = CoinType(rawValue: type), let _ = Wallet.shared.getAccount(type: cType){
                                coinType = cType
                            }else{
                                self.showMessage(title: "Unsupported coin type!", message: "Payment abort")
                                return
                            }
                            
                        
                        }else{
                            
                            showAccSelection = true
                        }
                        
                        
                       
                        DispatchQueue.main.async {
                            let vc = PaymentDetailsViewController()
                            
                            vc.showAccountSelection = showAccSelection
                            vc.deviceID = devID
                            vc.coinType = coinType
                            vc.amount = amount
                            
                            vc.paymentInfo = "{\"amount\":\"\(vc.amount)\", \"coinType\":\"\(vc.coinType)\", \"deviceID\": \"\(vc.deviceID)\"}"
                            

                            self.navigationController?.pushViewController(vc, animated: false)
                            
                            
                        }
                        
                        
                        return
                    }

                
                }
                
            }catch{
                print("Pasing payment info. failed!")
            }
        }
        
        self.showMessage(title: "Invalid QRCode!", message: "Please try again.")
    }
    
    
}

