//
//  SettingTableViewCell.swift
//  shippingassistant
//
//  Created by Maochun Sun on 2019/8/8.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import UIKit
import UserNotifications
import LocalAuthentication

enum SettingCellType {
    case fpSwitchCell
    case msgSwitchCell
    case testModeSwitchCell
    case testPhoneNumCell
    case logSwitchCell
    case logFileCell
    case versionCell
}

class SettingTableViewCell: UITableViewCell {
    

    var hasImgFlag = false
    var leftOffset : CGFloat = 16
    
    lazy var itemImg: UIImageView = {
        let img = UIImage(named: "max")
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        //let imageView = UIImageView(frame: CGRect(x:15, y: (self.height - 22)/2, width: (img?.size.width)!, height: (img?.size.width)!))
        
        self.contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
        
            imageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16)
        
        ])
        
        return imageView
    }()
    
    lazy var itemLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10" //"\(row+1)"
        
        label.font = UIFont.init(name: "Arial", size: 16)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .black
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        
        self.contentView.addSubview(label)
        
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            label.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: self.leftOffset),
            label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        
        ])
        
        
        return label
    }()
    
    lazy var itemValueLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10" //"\(row+1)"
        
        label.font = UIFont.init(name: "Arial", size: 16)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .gray
        label.textAlignment = NSTextAlignment.right
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        
        self.contentView.addSubview(label)
        
        if self.hasImgFlag{
            NSLayoutConstraint.activate([
            
                label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
                label.rightAnchor.constraint(equalTo: self.itemImg.leftAnchor, constant: -10),
                label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
            
            ])
            
        }else{
            
            NSLayoutConstraint.activate([
            
                label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
                label.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
                label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
            
            ])
        }
        
        return label
    }()
    
    func rotateImg(){
        self.itemImg.transform = self.itemImg.transform.rotated(by: CGFloat.pi)
       
    }
    
    func setup(title: String, value: String, imgName: String) {
        
        self.backgroundColor = .white
        
        self.hasImgFlag = true
        
        self.itemImg.image = UIImage(named: imgName)
        
        self.itemLabel.text = title
        self.itemValueLabel.text = value
        
        
    }
    
    func updateValue(value: String){
        self.itemValueLabel.text = value
    }
    
    func setup(title: String, value: String) {
        
        self.backgroundColor = .white
        
        self.itemLabel.text = title
        self.itemValueLabel.text = value
        
    }
}
