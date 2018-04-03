//
//  CustomCell.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 4/2/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell{
    var message : String?
    var mainImage: UIImage?
    
    var messageView : UITextView = {
       var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var mainImageView : UIImageView = {
       var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(mainImageView)
        self.addSubview(messageView)
        
        //Forma de mensajes
        mainImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mainImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        messageView.leftAnchor.constraint(equalTo: self.mainImageView.rightAnchor).isActive = true
        messageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        messageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let message = message {
            messageView.text = message
        }
        if let image = mainImage {
            mainImageView.image = image
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
