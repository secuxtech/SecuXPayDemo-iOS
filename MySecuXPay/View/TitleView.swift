//
//  TitleView.swift
//  SecuXWallet
//
//  Created by Maochun Sun on 2019/11/8.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import UIKit
import SecuXPaymentKit

enum TitleViewType{
    case portfolioTitleView
    case HWWalletTitleView
    case SWWalletTitleView
    case SWAccountTitleView
    case HWAccountTitleView
}

class TitleView: UIView {
    
    lazy var itemImage: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(named: "HW_Yellow")
        
        
        self.addSubview(imageview)
        
        
        return imageview
    }()
    
    lazy var coinImage: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(named: "hw_yellow")
        
        
        self.addSubview(imageview)
        
        
        return imageview
    }()
    
    lazy var backButton: UIButton = {
       
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let btnImg = UIImage(named: "icon_back")
        btn.setBackgroundImage(btnImg, for: .normal)
        
        self.addSubview(btn)
        
        return btn
        
    }()
    
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 20)
        label.text = ""
        label.textColor = .white
        label.textAlignment = NSTextAlignment.center
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var balanceLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 20)
        
        label.text = "Total Balance"
        label.textColor = .white
        label.textAlignment = NSTextAlignment.center
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.addSubview(label)
        
   
        return label
    }()
    
    lazy var balanceValLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 20)
        
        label.text = "$0 USD"
        label.textColor = UIColor(red: 0xEB/255, green: 0xCB/255, blue: 0x56/255, alpha: 1)
        label.textAlignment = NSTextAlignment.center
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.addSubview(label)
        
       
        return label
    }()
    
    //let statusBarHeight = UIApplication.shared.statusBarFrame.height

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        var _ = self.titleLabel
        var _ = self.balanceLabel
        var _ = self.balanceValLabel
        
        self.backgroundColor = UIColor(red: 0x1F/255, green: 0x20/255, blue: 0x20/255, alpha: 1)

        
    }
    
    func setType(type: TitleViewType){
        
        switch type {
            
        case .portfolioTitleView:
            self.balanceLabel.text = "Total Balance"
            NSLayoutConstraint.activate([
                
                self.balanceValLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -36.85),
                self.balanceValLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                self.balanceLabel.bottomAnchor.constraint(equalTo: self.balanceValLabel.topAnchor, constant: -16.15),
                self.balanceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                self.titleLabel.bottomAnchor.constraint(equalTo: self.balanceLabel.topAnchor, constant: -23),
                self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
            ])
            break
            
        case .SWAccountTitleView:
            self.balanceLabel.text = "Balance"
            self.itemImage.image = UIImage(named: "sw_yellow")
            
            NSLayoutConstraint.activate([
                
                self.balanceValLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -36.85),
                self.balanceValLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                self.balanceLabel.bottomAnchor.constraint(equalTo: self.balanceValLabel.topAnchor, constant: -16.15),
                self.balanceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 25),
                
                self.titleLabel.bottomAnchor.constraint(equalTo: self.balanceLabel.topAnchor, constant: -23),
                self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 21),
                
                self.itemImage.centerYAnchor.constraint(equalTo: self.balanceLabel.centerYAnchor, constant: 0),
                self.itemImage.rightAnchor.constraint(equalTo: self.balanceLabel.leftAnchor, constant: -10),
                
                self.coinImage.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor, constant: 0),
                self.coinImage.rightAnchor.constraint(equalTo: self.titleLabel.leftAnchor, constant: -8),
                
                /*
                self.backButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15.44),
                self.backButton.centerYAnchor.constraint(equalTo: self.coinImage.centerYAnchor)
                */
            ])
            break
            
        case .HWAccountTitleView:
            self.balanceLabel.text = "Balance"
            self.itemImage.image = UIImage(named: "hw_yellow")
            
            NSLayoutConstraint.activate([
                
                self.balanceValLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -36.85),
                self.balanceValLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                self.balanceLabel.bottomAnchor.constraint(equalTo: self.balanceValLabel.topAnchor, constant: -16.15),
                self.balanceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 25),
                
                self.titleLabel.bottomAnchor.constraint(equalTo: self.balanceLabel.topAnchor, constant: -23),
                self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 21),
                
                self.itemImage.centerYAnchor.constraint(equalTo: self.balanceLabel.centerYAnchor, constant: 0),
                self.itemImage.rightAnchor.constraint(equalTo: self.balanceLabel.leftAnchor, constant: -10),
                
                self.coinImage.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor, constant: 0),
                self.coinImage.rightAnchor.constraint(equalTo: self.titleLabel.leftAnchor, constant: -8)
                
            ])
            break
            
        case .HWWalletTitleView:
            self.balanceLabel.text = "Balance"
            self.itemImage.image = UIImage(named: "hw_yellow")
            
            NSLayoutConstraint.activate([
                
                self.balanceValLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -36.85),
                self.balanceValLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                self.balanceLabel.bottomAnchor.constraint(equalTo: self.balanceValLabel.topAnchor, constant: -16.15),
                self.balanceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 25),
                
                self.titleLabel.bottomAnchor.constraint(equalTo: self.balanceLabel.topAnchor, constant: -23),
                self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                self.itemImage.centerYAnchor.constraint(equalTo: self.balanceLabel.centerYAnchor, constant: 0),
                self.itemImage.rightAnchor.constraint(equalTo: self.balanceLabel.leftAnchor, constant: -10)
                
            ])
            break
        
        
            
        case .SWWalletTitleView:
            self.balanceLabel.text = "Balance"
            self.itemImage.image = UIImage(named: "sw_yellow")
            
            NSLayoutConstraint.activate([
                
                self.balanceValLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -36.85),
                self.balanceValLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                self.balanceLabel.bottomAnchor.constraint(equalTo: self.balanceValLabel.topAnchor, constant: -16.15),
                self.balanceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 25),
                
                self.titleLabel.bottomAnchor.constraint(equalTo: self.balanceLabel.topAnchor, constant: -23),
                self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                self.itemImage.centerYAnchor.constraint(equalTo: self.balanceLabel.centerYAnchor, constant: 0),
                self.itemImage.rightAnchor.constraint(equalTo: self.balanceLabel.leftAnchor, constant: -10)
                
            ])
            break
        }
    }
    
    func setValue(title:String, balance:String){
        
        self.titleLabel.text = title
        if balance.count > 0{
            self.balanceValLabel.text = "$\(balance) USD"
        }else{
            self.balanceValLabel.text = ""
        }
        
        
    }
    
    func setBalanceTitle(balanceTitle: String){
        self.balanceLabel.text = balanceTitle
    }
    
    
    func setCoinType(type: CoinType){
        switch type {
        case .BTC:
            self.coinImage.image = UIImage(named: "btc")
            break
            
        case .BCH:
            self.coinImage.image = UIImage(named: "bch")
            break
            
        case .BNB:
            self.coinImage.image = UIImage(named: "bnb")
            break
            
        case .DCT, .IFC:
            self.coinImage.image = UIImage(named: "dct")
            break
            
        case .DGB:
            self.coinImage.image = UIImage(named: "dgb")
            break
            
        case .DSH:
            self.coinImage.image = UIImage(named: "dsh")
            break
            
        case .ETH:
            self.coinImage.image = UIImage(named: "bch")
            break
            
        case .GRS:
            self.coinImage.image = UIImage(named: "grs")
            break
            
        case .LBR:
            self.coinImage.image = UIImage(named: "lbr")
            break
            
        case .LTC:
            self.coinImage.image = UIImage(named: "ltc")
            break
            
        case .XRP:
            self.coinImage.image = UIImage(named: "xrp")
            break
        }
        
    }
    
    /*
    override func layoutSubviews() {
        self.setGradientBackground(colorLeft: UIColor(red: 0x21/255, green: 0x5F/255, blue: 0xFB/255, alpha: 1), colorRight: UIColor(red: 0x37/255, green: 0xD1/255, blue: 0xED/255, alpha: 1))
    }
    
    func setGradientBackground(colorLeft: UIColor, colorRight: UIColor){
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorLeft.cgColor, colorRight.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.locations = [0, 1]
            gradientLayer.frame = bounds
        
            print("\(bounds)")

            layer.insertSublayer(gradientLayer, at: 0)
    }
    */
}
