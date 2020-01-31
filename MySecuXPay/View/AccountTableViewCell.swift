//
//  AccountTableCellView.swift
//  SecuXTest
//
//  Created by Maochun Sun on 2019/11/6.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell{
    
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
    
    lazy var ifcBalanceLabel : UILabel = {
        let label = UILabel()
       
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 IFC"

        label.font = UIFont.init(name: "Arial", size: 16)
        label.textColor = UIColor(red: 0x70/255, green: 0x70/255, blue: 0x70/255, alpha: 1)
        label.textAlignment = NSTextAlignment.right

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()

        self.contentView.addSubview(label)

        return label
    }()
    
    var theAccount : Account?
    
    func setup(account: Account){
        
        self.contentView.backgroundColor = UISetting.shared.portfolioBKColor
        self.backgroundColor = UISetting.shared.portfolioBKColor
        var _ = self.bkView
      
        self.itemImg.image = account.getCoinImg()

        self.theAccount = account
        self.theAccount?.formatedBalance.addObserver({ (value) in
           
           self.itemValLabel.text = "\(account.formatedBalance.value) \(account.type.rawValue)"
           self.itemBalanceLabel.text = "$" + String(account.usdBalance.roundToDecimal(2))
        })
       
            
        self.ifcBalanceLabel.isHidden = true
        NSLayoutConstraint.activate([
            
            self.itemImg.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            self.itemImg.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            
            self.itemNameLabel.leftAnchor.constraint(equalTo: itemImg.rightAnchor, constant: 10),
            self.itemNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            self.itemNameLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 1/2, constant: -35),
            
            self.itemBalanceLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -13.1),
            self.itemBalanceLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15.46),
            
            self.itemValLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -13.1),
            self.itemValLabel.topAnchor.constraint(equalTo: self.itemBalanceLabel.bottomAnchor, constant: 3)

        ])
            
        
        
        
        self.itemNameLabel.text = account.name
        self.itemValLabel.text = "\(account.formatedBalance.value) " + account.type.rawValue
        self.itemBalanceLabel.text = "$" + String(account.usdBalance.roundToDecimal(2))
        
    }
    
    func removeAccountBalanceObserver(){
        
        self.theAccount?.formatedBalance.removeObserver()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
}
