//
//  AddUserViewController.swift
//  WheelsChallenge
//
//  Created by Wergley, Brad on 9/6/19.
//  Copyright © 2019 Brad Wergley. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController, UserTextEntryViewDelegate {
    
    @objc public var addUserCompletionBlock: ((User?) -> Void)?
    
    @IBOutlet weak var scrollView: UIScrollView?
    @IBOutlet weak var displayNameTextEntryView: UserTextEntryView?
    @IBOutlet weak var reputationTextEntryView: UserTextEntryView?
    @IBOutlet weak var goldBadgeTextEntryView: UserTextEntryView?
    @IBOutlet weak var silverBadgeTextEntryView: UserTextEntryView?
    @IBOutlet weak var bronzeBadgeTextEntryView: UserTextEntryView?
    @IBOutlet weak var addUserButton: UIButton?
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint?
    @IBOutlet weak var addUserButtonHeightConstraint: NSLayoutConstraint?
    
    private var textEntryViews: [UserTextEntryView?]?
    
    private let displayNameErrorMessage = "Please enter a display name"
    private let oddNumberErrorMessage = "Please enter an odd number"
    private let multipleOfThreeErrorMessage = "Please enter a multiple of three"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextEntryViews()
        self.addKeyboardObservers()
        self.adjustAddUserButtonHeight(addSafeAreaHeight: true)
    }
    
    private func adjustAddUserButtonHeight(addSafeAreaHeight: Bool) {
        let bottomSafeArea = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        self.addUserButtonHeightConstraint?.constant = 40 + (addSafeAreaHeight ? bottomSafeArea : 0)
        self.addUserButton?.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: addSafeAreaHeight ? bottomSafeArea : 0, right: 0)
    }
    
    private func setupTextEntryViews() {
        self.textEntryViews = [self.displayNameTextEntryView, self.reputationTextEntryView, self.goldBadgeTextEntryView, self.silverBadgeTextEntryView, self.bronzeBadgeTextEntryView]
        self.displayNameTextEntryView?.set(delegate: self,
                                           placeholderText: "Display Name",
                                           validateForErrorBlock: { (text) -> String? in
            if text?.count ?? 0 > 0 {
                return nil
            }
            else {
                return self.displayNameErrorMessage
            }
        })
        
        self.reputationTextEntryView?.set(delegate: self,
                                          placeholderText: "Reputation",
                                          keyboardType: .numberPad,
                                          validateForErrorBlock: { (text) -> String? in
            if let number = Int(text ?? ""),
                number % 2 == 1 {
                return nil
            }
            else {
                return self.oddNumberErrorMessage
            }
        })
        
        self.goldBadgeTextEntryView?.set(delegate: self,
                                         placeholderText: "Gold Badge Count",
                                         keyboardType: .numberPad,
                                         validateForErrorBlock: { (text) -> String? in
            if let number = Int(text ?? ""),
                number % 3 == 0 {
                return nil
            }
            else {
                return self.multipleOfThreeErrorMessage
            }
        })
        
        self.silverBadgeTextEntryView?.set(delegate: self,
                                           placeholderText: "Silver Badge Count",
                                           keyboardType: .numberPad,
                                           validateForErrorBlock: { (text) -> String? in
            if let number = Int(text ?? ""),
                number % 3 == 0 {
                return nil
            }
            else {
                return self.multipleOfThreeErrorMessage
            }
        })
        
        self.bronzeBadgeTextEntryView?.set(delegate: self,
                                           placeholderText: "Bronze Badge Count",
                                           keyboardType: .numberPad,
                                           returnKeyType: .done,
                                           validateForErrorBlock: { (text) -> String? in
            if let number = Int(text ?? ""),
                number % 3 == 0 {
                return nil
            }
            else {
                return self.multipleOfThreeErrorMessage
            }
        })
    }
    
    @IBAction func addUserTapped() {
        
        var firstInvalidTextEntryView: UserTextEntryView? = nil
        for textEntryView in self.textEntryViews ?? [] {
            if let textEntryView = textEntryView {
                let _ = textEntryView.resignFirstResponder()
                if textEntryView.validate() == false && firstInvalidTextEntryView == nil {
                    firstInvalidTextEntryView = textEntryView
                }
            }
        }
        
        if let firstInvalidTextEntryView = firstInvalidTextEntryView {
            self.scrollView?.scrollRectToVisible(firstInvalidTextEntryView.frame, animated: true)
        }
        else {
            let user = User()
            user.displayName = self.displayNameTextEntryView?.text
            user.reputation = Int(self.reputationTextEntryView?.text ?? "") ?? 0
            user.goldBadgeCount = Int(self.goldBadgeTextEntryView?.text ?? "") ?? 0
            user.silverBadgeCount = Int(self.silverBadgeTextEntryView?.text ?? "") ?? 0
            user.bronzeBadgeCount = Int(self.bronzeBadgeTextEntryView?.text ?? "") ?? 0
            
            self.addUserCompletionBlock?(user)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func userTextEntryViewDidEndEditing(view: UserTextEntryView?) {
        if let textEntryViews = self.textEntryViews,
            let viewIndex = textEntryViews.firstIndex(of: view)
        {
            if viewIndex == textEntryViews.count - 1
            {
                self.addUserTapped()
            }
            else
            {
                if let nextTextEntryView = textEntryViews[viewIndex + 1]
                {
                    let _ = nextTextEntryView.becomeFirstResponder()
                }
            }
        }
    }
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        let duration = userInfo.object(forKey: UIResponder.keyboardAnimationDurationUserInfoKey) as! NSNumber
        self.bottomLayoutConstraint?.constant = keyboardHeight
        self.adjustAddUserButtonHeight(addSafeAreaHeight: false)
        UIView.animate(withDuration: duration.doubleValue) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let duration = userInfo.object(forKey: UIResponder.keyboardAnimationDurationUserInfoKey) as! NSNumber
        self.bottomLayoutConstraint?.constant = 0
        self.adjustAddUserButtonHeight(addSafeAreaHeight: true)
        UIView.animate(withDuration: duration.doubleValue) {
            self.view.layoutIfNeeded()
        }
    }
}
