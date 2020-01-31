//
//  UnderlineIconTextField.swift
//  SecuXWallet
//
//  Created by Maochun Sun on 2019/12/10.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import UIKit

class UnderlineIconTextField: UIView {
    
    var leftImage: UIImage? {
        didSet {
            self.itemImage.image = leftImage
        }
    }
    
    var rightTxt: String = ""{
        didSet{
            self.theTextLabel.text = rightTxt
        }
    }
    
    var editText: String = ""{
        didSet{
            self.theTextField.text = editText
        }
    
    }
    
    var editTextFont: UIFont?{
        didSet{
            self.theTextField.font = editTextFont
        }
    }
    
    var text: String?{
        get{
            return self.theTextField.text
        }
    }
    
    var keyboardType:UIKeyboardType = .decimalPad{
        didSet{
            self.theTextField.keyboardType = keyboardType
        }
    }
    
    var enableTextField: Bool = true{
        didSet{
            self.theTextField.isUserInteractionEnabled = enableTextField
        }
    }
    
    var hasLeftIcon = false
    var hasRightTxt = false
    
    lazy var itemImage: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(named: "btc")
        
        
        self.addSubview(imageview)
        
        NSLayoutConstraint.activate([
        
            imageview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            imageview.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageview.widthAnchor.constraint(equalToConstant: 32),
            imageview.heightAnchor.constraint(equalToConstant: 32)
        
        ])
        
        return imageview
    }()
    
    lazy var theTextField : UITextField = {
    //lazy var theTextField : UITextView = {
        let textfield = UITextField()
        //let textfield = UITextView()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        textfield.keyboardType = UIKeyboardType.decimalPad
        textfield.returnKeyType = .default
        textfield.backgroundColor = .white
       
        //let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 10))
        //textfield.leftView = paddingView
        //textfield.leftViewMode = UITextField.ViewMode.always
        
        //textfield.borderStyle = .none
        
        textfield.textColor = UIColor(red: 0x70/0xFF, green: 0x70/0xFF, blue: 0x70/0xFF, alpha: 1)
        
        textfield.font = UIFont(name: UISetting.shared.fontName, size: 19.0)
        
        //textfield.textContainer.lineBreakMode = .byCharWrapping
        
        self.addSubview(textfield)
        
        if self.hasLeftIcon{
            NSLayoutConstraint.activate([
            
                textfield.leftAnchor.constraint(equalTo: self.itemImage.rightAnchor, constant: 10),
                textfield.topAnchor.constraint(equalTo: self.topAnchor),
                textfield.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3),
                //textfield.rightAnchor.constraint(equalTo: self.theTextLabel.leftAnchor, constant: -16),
                
                textfield.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -32-self.theTextLabel.intrinsicContentSize.width-15)
            ])
        }else if self.hasRightTxt{
            NSLayoutConstraint.activate([
            
                textfield.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
                textfield.topAnchor.constraint(equalTo: self.topAnchor),
                textfield.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3),
                //textfield.rightAnchor.constraint(equalTo: self.theTextLabel.leftAnchor, constant: -16)
                
                textfield.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -self.theTextLabel.intrinsicContentSize.width-15)
            ])
        }else{
            NSLayoutConstraint.activate([
            
                textfield.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
                textfield.topAnchor.constraint(equalTo: self.topAnchor),
                textfield.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3),
                //textfield.rightAnchor.constraint(equalTo: self.theTextLabel.leftAnchor, constant: -16)
                
                textfield.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -1)
            ])
        }
        
        return textfield
        
    }()
    
    lazy var theTextLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 20)
        label.text = "BTC"
        label.textColor = UIColor(red: 0.44, green: 0.44, blue: 0.44,alpha:1)
        label.textAlignment = NSTextAlignment.right
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
        
            label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        return label
    }()
    
    lazy var lineView: UIView = {
        let theView = UIView()
        theView.translatesAutoresizingMaskIntoConstraints = false
        theView.layer.borderWidth = 1.0
        theView.layer.borderColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1).cgColor
        self.addSubview(theView)
        
        NSLayoutConstraint.activate([
        
            theView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            theView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1),
         
            theView.widthAnchor.constraint(equalTo: self.widthAnchor),
            theView.heightAnchor.constraint(equalToConstant: 1.0)
        
        ])
        
        return theView
        
    }()
    
    func setup(hasLeftIcon: Bool, hasRightTxt: Bool){
        
        self.hasLeftIcon = hasLeftIcon
        self.hasRightTxt = hasRightTxt
        
        if self.hasLeftIcon{
            var _ = self.itemImage
        }
        var _ = self.lineView
        
        if self.hasRightTxt{
            var _ = self.theTextLabel
        }
        var _ = self.theTextField
    }
    
    func setText(text: String){
        self.theTextField.text = text
    }
    
    func setTextFieldDelegate(delegate: UITextFieldDelegate){
        self.theTextField.delegate = delegate
    }
  
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
    }
    
    
}
