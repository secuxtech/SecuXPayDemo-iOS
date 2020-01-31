//
//  PaymentHistoryTableViewCell.swift
//  SecuXWallet
//
//  Created by Maochun Sun on 2019/12/1.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import UIKit
import SecuXPaymentKit

class PaymentHistoryTableViewCell: UITableViewCell {
    
    
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
        
        self.contentView.addSubview(bkview)
        
        NSLayoutConstraint.activate([
            
            bkview.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 3),
            bkview.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -3),
            bkview.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6),
            bkview.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6)
            
        ])
        
        return bkview
    }()
    
    lazy var storeNameLabel : UILabel = {
        let label = UILabel()
       
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""

        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 20)
        label.textColor = UIColor(red: 0x70/255, green: 0x70/255, blue: 0x70/255, alpha: 1)
        label.textAlignment = NSTextAlignment.right

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()

        self.contentView.addSubview(label)

        return label
    }()
    
    lazy var timestampLabel : UILabel = {
        let label = UILabel()
       
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""

        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 12)
        label.textColor = UIColor(red: 0x70/255, green: 0x70/255, blue: 0x70/255, alpha: 1)
        label.textAlignment = NSTextAlignment.right

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()

        self.contentView.addSubview(label)

        return label
    }()
    
    lazy var itemImg: UIImageView = {

        let imageView = UIImageView()
        imageView.image = UIImage(named: "btc")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imageView)
        
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


        self.contentView.addSubview(label)
        return label
    }()

    lazy var itemValLabel : UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""

        label.font = UIFont.init(name: "Arial", size: 16)
        label.textColor = UIColor(red: 0x70/255, green: 0x70/255, blue: 0x70/255, alpha: 1)
        label.textAlignment = NSTextAlignment.right

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()

        self.contentView.addSubview(label)

        return label
    }()
    
    lazy var itemBalanceLabel : UILabel = {
        let label = UILabel()
       
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""

        label.font = UIFont.init(name: "Arial", size: 19)
        label.textColor = UIColor(red: 0x70/255, green: 0x70/255, blue: 0x70/255, alpha: 1)
        label.textAlignment = NSTextAlignment.right

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()

        self.contentView.addSubview(label)

        return label
    }()
    
    
    func setup(historyInfo: PaymentHistoryInfo){
        
        self.contentView.backgroundColor = UISetting.shared.portfolioBKColor
        self.backgroundColor = UISetting.shared.portfolioBKColor
        var _ = self.bkView
        
        guard let accType = CoinType(rawValue: historyInfo.coinType),
           let account = Wallet.shared.getAccount(type: accType) else{
           return
        }
        
        self.itemImg.image = account.getCoinImg()
        
        NSLayoutConstraint.activate([
            
            self.storeNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            self.storeNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            self.itemImg.leftAnchor.constraint(equalTo: self.storeNameLabel.leftAnchor, constant: 0),
            self.itemImg.topAnchor.constraint(equalTo: self.storeNameLabel.bottomAnchor, constant: 5),
            
            self.itemImg.widthAnchor.constraint(equalToConstant: 22),
            self.itemImg.heightAnchor.constraint(equalToConstant: 22),
            
            
            self.itemNameLabel.leftAnchor.constraint(equalTo: itemImg.rightAnchor, constant: 10),
            self.itemNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            self.itemNameLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 1/2, constant: -35),
            
            self.timestampLabel.leftAnchor.constraint(equalTo: self.storeNameLabel.leftAnchor, constant: 0),
            
            self.timestampLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            self.itemBalanceLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -13.1),
            self.itemBalanceLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            
            self.itemValLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12.7),
            self.itemValLabel.topAnchor.constraint(equalTo: self.itemBalanceLabel.bottomAnchor, constant: 5)

        ])
        
        self.storeNameLabel.text = historyInfo.storeName
        self.timestampLabel.text = historyInfo.timestamp
        self.itemNameLabel.text = account.name
        self.itemValLabel.text = historyInfo.amount + " " + historyInfo.coinType
        
        //self.itemBalanceLabel.text = "$" + historyInfo.amountUSD
        
        var usdValue : Double = 0
        if let dbAmount = Double(historyInfo.amount), let type = CoinType(rawValue: historyInfo.coinType),
            let usdRate = Wallet.shared.getCoinToUSDRate(type: type){
            usdValue = dbAmount * usdRate
        }
        
        self.itemBalanceLabel.text = "$\(usdValue.roundToDecimal(2))"
        
        
        //print("setup account \(self.itemValLabel.text)  \(self.itemBalanceLabel.text)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
}
