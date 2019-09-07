//
//  UserTextEntryView.swift
//  WheelsChallenge
//
//  Created by Wergley, Brad on 9/7/19.
//  Copyright © 2019 Brad Wergley. All rights reserved.
//

import UIKit

class UserTextEntryView: UIView {

    private var textField: UITextField?
    private var errorLabel: UILabel?
    private var validateForErrorBlock: ((String?) -> String?)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    func set(placeholderText: String?, validateForErrorBlock: @escaping (String?) -> String?) {
        self.textField?.placeholder = placeholderText
        self.validateForErrorBlock = validateForErrorBlock
    }
    
    func validate() -> Bool {
        let errorString = validateForErrorBlock?(textField?.text)
        if errorString != nil
        {
            self.errorLabel?.text = errorString
            self.errorLabel?.isHidden = false
            return false
        }
        else
        {
            self.errorLabel?.isHidden = true
            return true
        }
    }
    
    private func setupView() {
        let textField = UITextField(frame: .zero)
        self.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        textField.leftAnchor.constraint(equalTo: self.rightAnchor, constant: 20).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .roundedRect
        self.textField = textField
        
        let errorLabel = UILabel(frame: .zero)
        self.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8).isActive = true
        errorLabel.textColor = .red
        errorLabel.isHidden = true
        self.errorLabel = errorLabel
    }
}
