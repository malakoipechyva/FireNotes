//
//  Utilities.swift
//  FireNotes
//
//  Created by malakoipechyva on 23.03.21.
//

import UIKit

class Utilities {
    
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        let iv = UIImageView()
        
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.image = image
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor,
                  paddingLeft: 8, paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        
        view.addSubview(textField)
        textField.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,
                         paddingLeft: 8, paddingBottom: 8)
        
        let deviderView = UIView()
        deviderView.backgroundColor = .white
        view.addSubview(deviderView)
        deviderView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,
                           paddingLeft: 8, height: 0.75)
        return view
    }
    
}

