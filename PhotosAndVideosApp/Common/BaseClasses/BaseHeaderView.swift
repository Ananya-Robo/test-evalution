//
//  BaseHeaderView.swift
//  PhotosAndVideosApp
//
//  Created by  Ananya M on 13/02/21.
//  Copyright © 2021  Ananya M. All rights reserved.
//

import Foundation
import UIKit

enum HeaderViewStyle {
    case general
}

protocol BaseHeaderViewDelegate: class {
    func textFieldEditingBegin(searchedText: String)
    func textFieldEditingChanged(searchedText: String)
    func searchForTheResult(searchedText: String)
}

class BaseHeaderView: UIView {
// MARK: - Properties
var headerBackgroundColor: UIColor = .black
weak var delegate: BaseHeaderViewDelegate?
var primaryTitle: String = "" {
       didSet {
          titleLabel?.text = primaryTitle
      }
  }

// MARK: - IBOutlets
     @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var searchByItemTextField: UITextField!
    @IBOutlet weak var addToCartButton: UIButton!
    
    @IBOutlet weak var titleImage: UIImageView! {
    didSet {
               titleImage.image = #imageLiteral(resourceName: "Logo")
           }
    }
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setImage(#imageLiteral(resourceName: "background_android"), for: .normal)
            backButton.tintColor = .white
        }
    }
     
// MARK: - Init Method

required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
}

override init(frame: CGRect) {
    super.init(frame: frame)
}
// MARK: - Lifecycle Methods
override func awakeFromNib() {
    super.awakeFromNib()
    setUpView()
}
    
    // MARK: - Helper Methods

    func setUpView() {
        searchByItemTextField?.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        searchByItemTextField?.delegate = self
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        
        if let textCount = textField.text?.count, textCount >= 3 {
            delegate?.textFieldEditingChanged(searchedText: searchByItemTextField.text ?? "")
        }
        guard let itemName = searchByItemTextField.text, !itemName.isEmpty
            else {
                cancelButton.isHidden = true
                return
        }
       
        cancelButton.isHidden = false
    }
}

extension BaseHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.searchForTheResult(searchedText: textField.text ?? "")
        endEditing(true)
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldEditingBegin(searchedText: textField.text ?? "")
    }
}
