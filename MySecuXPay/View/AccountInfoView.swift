//
//  AccountInfoView.swift
//  SecuXWallet
//
//  Created by Maochun Sun on 2019/11/27.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import UIKit
import SecuXPaymentKit

class AccountInfoView: UIView {
    
    
    lazy var bkView: UIView = {
        let bkview = UIView()
        bkview.translatesAutoresizingMaskIntoConstraints = false
        bkview.backgroundColor = .white
        
        bkview.layer.cornerRadius = 10
        /*
        bkview.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        bkview.layer.shadowOffset = CGSize(width: 1, height: 1)
        bkview.layer.shadowOpacity = 0.2
        bkview.layer.shadowRadius = 15
        */
        bkview.layer.shadowColor = UIColor.darkGray.cgColor
        //bkview.layer.shadowPath = UIBezierPath(roundedRect: bkview.bounds, cornerRadius: 10).cgPath
        bkview.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        bkview.layer.shadowOpacity = 0.4
        bkview.layer.shadowRadius = 3.0
        
        //bkview.layer.borderColor = UIColor(red: 0.62, green: 0.62, blue: 0.62,alpha:1).cgColor
        //bkview.layer.borderWidth = 0.2
        
        self.addSubview(bkview)
        
        NSLayoutConstraint.activate([
            
            bkview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3),
            bkview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -3),
            bkview.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            bkview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6)
            
        ])
        
        return bkview
    }()
    
    lazy var itemImg: UIImageView = {

        let imageView = UIImageView()
        imageView.image = UIImage(named: "btc")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        return imageView
    }()
       
    lazy var itemNameLabel : UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10" //"\(row+1)"

        //label.font = UIFont.preferredFont(forTextStyle: .headline)
        //label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.init(name: "Arial-Bold", size: 12)
        label.textColor = UIColor(red: 0x70/255, green: 0x70/255, blue: 0x70/255, alpha: 1)
        label.textAlignment = NSTextAlignment.left

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()


        self.addSubview(label)
        return label
    }()

    lazy var itemValLabel : UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 USD"

        label.font = UIFont.init(name: "Arial", size: 16)
        label.textColor = UIColor(red: 0x70/255, green: 0x70/255, blue: 0x70/255, alpha: 1)
        label.textAlignment = NSTextAlignment.right

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()

        self.addSubview(label)

        return label
    }()
    
    lazy var itemBalanceLabel : UILabel = {
        let label = UILabel()
       
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 USD"

        label.font = UIFont.init(name: "Arial", size: 19)
        label.textColor = UIColor(red: 0x70/255, green: 0x70/255, blue: 0x70/255, alpha: 1)
        label.textAlignment = NSTextAlignment.right

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()

        self.addSubview(label)

        return label
    }()
    
    
    var theAccount : Account?

    lazy var dropdownImage: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(named: "angle-down")
        
        imageview.isHidden = true
        
        self.addSubview(imageview)
        
        NSLayoutConstraint.activate([
        
            imageview.centerYAnchor.constraint(equalTo: self.itemImg.centerYAnchor, constant: 0),
            
            imageview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),

        ])
        
        
        return imageview
    }()
    

    
    var dropdownMenuShows = false
    func dropdownToggle(){
        self.dropdownMenuShows = !self.dropdownMenuShows
        
        if !self.dropdownMenuShows{
            UIView.animate(withDuration: 0.5, animations: {
                self.dropdownImage.transform = self.dropdownImage.transform.rotated(by: -(CGFloat.pi * 0.999))
                
                
                
            })
        }else{
            UIView.animate(withDuration: 0.5, animations: {
                self.dropdownImage.transform = self.dropdownImage.transform.rotated(by: CGFloat.pi)
            })
        }
    }
    
    func setupWithDropdownBtn(account: Account){
        self.backgroundColor = .white
       
        removeAccountBalanceObserver()
        self.theAccount = account
        var _ = self.bkView
        
        self.theAccount?.formatedBalance.addObserver({ (value) in
            
            self.itemValLabel.text = "\(account.formatedBalance.value) \(account.type.rawValue)"
            self.itemBalanceLabel.text = "$" + String(account.usdBalance.roundToDecimal(2))
        
        })
        
        //let tt = account.getCoinImg()
        self.itemImg.image = account.getCoinImg()
        self.dropdownImage.isHidden = false
        
     
        NSLayoutConstraint.activate([
            
            self.itemImg.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.itemImg.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            
            self.itemNameLabel.leftAnchor.constraint(equalTo: itemImg.rightAnchor, constant: 10),
            self.itemNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.itemNameLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 1/2, constant: -55),
            
            self.itemBalanceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -35),
            self.itemBalanceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15.46),
            
            self.itemValLabel.rightAnchor.constraint(equalTo: itemBalanceLabel.rightAnchor, constant: 0),
            self.itemValLabel.topAnchor.constraint(equalTo: self.itemBalanceLabel.bottomAnchor, constant: 3)

        ])
            
        
        
        
        self.itemNameLabel.text = account.name
        self.itemValLabel.text = "\(account.formatedBalance.value) " + account.type.rawValue
        self.itemBalanceLabel.text = "$" + String(account.usdBalance.roundToDecimal(2))
        
        
        //print("setup account \(self.itemValLabel.text)  \(self.itemBalanceLabel.text)")
    }
    
    func setup(account: Account){
        
        self.backgroundColor = .white
        var _ = self.bkView
        
        removeAccountBalanceObserver()
        self.theAccount = account
        self.theAccount?.formatedBalance.addObserver({ (value) in
            
            self.itemValLabel.text = "\(account.formatedBalance.value) \(account.type.rawValue)"
            self.itemBalanceLabel.text = "$" + String(account.usdBalance.roundToDecimal(2))
         })
        
        self.itemImg.image = account.getCoinImg()

        NSLayoutConstraint.activate([
            
            self.itemImg.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.itemImg.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            
            self.itemNameLabel.leftAnchor.constraint(equalTo: itemImg.rightAnchor, constant: 10),
            self.itemNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.itemNameLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 1/2, constant: -35),
            
            self.itemBalanceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -13.1),
            self.itemBalanceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15.46),
            
            self.itemValLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12.7),
            self.itemValLabel.topAnchor.constraint(equalTo: self.itemBalanceLabel.bottomAnchor, constant: 3)

        ])
    
        
        self.itemNameLabel.text = account.name
        self.itemValLabel.text = "\(account.formatedBalance.value) \(account.type.rawValue)"
        self.itemBalanceLabel.text = "$" + String(account.usdBalance.roundToDecimal(2))
        
      
        //print("setup account \(self.itemValLabel.text)  \(self.itemBalanceLabel.text)")
    }
    
    func removeAccountBalanceObserver(){
        
        self.theAccount?.formatedBalance.removeObserver()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        

        
    }
    
}
