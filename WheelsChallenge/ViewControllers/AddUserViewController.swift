//
//  AddUserViewController.swift
//  WheelsChallenge
//
//  Created by Wergley, Brad on 9/6/19.
//  Copyright © 2019 Brad Wergley. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView?
    @IBOutlet weak var displayNameTextEntryView: UserTextEntryView?
    @IBOutlet weak var reputationTextEntryView: UserTextEntryView?
    @IBOutlet weak var goldBadgeTextEntryView: UserTextEntryView?
    @IBOutlet weak var silverBadgeTextEntryView: UserTextEntryView?
    @IBOutlet weak var bronzeBadgeTextEntryView: UserTextEntryView?
    
    private var textEntryViews: [UserTextEntryView?]?
    
    private let displayNameErrorMessage = "Please enter a display name"
    private let oddNumberErrorMessage = "Please enter an odd number"
    private let multipleOfThreeErrorMessage = "Please enter a multiple of three"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textEntryViews = [displayNameTextEntryView, reputationTextEntryView, goldBadgeTextEntryView, silverBadgeTextEntryView, bronzeBadgeTextEntryView]
        self.setupTextEntryViews()
    }
    
    private func setupTextEntryViews()
    {
        self.displayNameTextEntryView?.set(placeholderText: "Display Name", validateForErrorBlock: { (text) -> String? in
            if text?.count ?? 0 > 0 {
                return nil
            }
            else {
                return self.displayNameErrorMessage
            }
        })
        
        self.reputationTextEntryView?.set(placeholderText: "Reputation", validateForErrorBlock: { (text) -> String? in
            if let number = Int(text ?? ""),
                number % 2 == 1 {
                return nil
            }
            else {
                return self.oddNumberErrorMessage
            }
        })
        
        self.goldBadgeTextEntryView?.set(placeholderText: "Gold Badge Count", validateForErrorBlock: { (text) -> String? in
            if let number = Int(text ?? ""),
                number % 3 == 0 {
                return nil
            }
            else {
                return self.multipleOfThreeErrorMessage
            }
        })
        
        self.silverBadgeTextEntryView?.set(placeholderText: "Silver Badge Count", validateForErrorBlock: { (text) -> String? in
            if let number = Int(text ?? ""),
                number % 3 == 0 {
                return nil
            }
            else {
                return self.multipleOfThreeErrorMessage
            }
        })
        
        self.bronzeBadgeTextEntryView?.set(placeholderText: "Bronze Badge Count", validateForErrorBlock: { (text) -> String? in
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
            if let textEntryView = textEntryView,
                textEntryView.validate() == false {
                if firstInvalidTextEntryView == nil {
                    firstInvalidTextEntryView = textEntryView
                }
            }
        }
        
        if let firstInvalidTextEntryView = firstInvalidTextEntryView {
            self.scrollView?.scrollRectToVisible(firstInvalidTextEntryView.frame, animated: true)
        }
        else {
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
