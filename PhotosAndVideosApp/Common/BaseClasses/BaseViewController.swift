//
//  BaseViewController.swift
//  PhotosAndVideosApp
//
//  Created by  Ananya M on 13/02/21.
//  Copyright © 2021  Ananya M. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    @IBOutlet weak var headerContainerView: UIView!
    
    var headerView: BaseHeaderView!
    var headerViewStyle: HeaderViewStyle = .general
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHeaderView()
        setUpNavBarActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.headerView?.frame = headerContainerView.bounds
    }
    
    func primaryNavBarTitle() -> String {
        return ""
    }
    
    func backButtonImage() -> UIImage {
        return UIImage()
    }
    
    func setUpNavBarActions() {
        /// Setup the actions will if header view reference is present else return
        guard headerView != nil else { return }

        // Add Action methods for navigation bar buttons
        headerView.backButton?.addTarget(self,
                                         action: #selector(backButtonClicked),
                                         for: .touchUpInside)
    }
    
    func setUpHeaderView() {
        if let headerContainerView = headerContainerView {
            switch headerViewStyle {
            case .general:
                headerView = GeneralHeaderView.getInstance()
                break
            //case .largeHeader:
            }
     
            headerView?.setUpView()
            headerContainerView.addSubview(self.headerView)
            headerView?.frame = headerContainerView.bounds
        }
    }
    
    @objc func backButtonClicked() {
          _ = navigationController?.popViewController(animated: true)
      }
   
    func getScrollView() -> UIScrollView? { return nil }
     func getActiveTextfield() -> UITextField? { return nil }

    // Keyboard Methods
    @objc func handleKeyboardDismiss() {
        view.endEditing(true)
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification/*NSNotification.Name.UIKeyboardWillShow*/, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func deregisterFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: Notification) {}
    /// Called when notification is hidden. super should be called when this method is overidden in subclass
    ///
    /// - Parameter notification: notification object
    @objc func keyboardWasShown(notification: Notification) {
        
        guard let scrollView = getScrollView() else {
            return

        }
        guard let activeTextfield = getActiveTextfield() else {
            return

        }
        
        var userInfo = notification.userInfo!
        var keyboardRect:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        if keyboardRect.size.height <= 0 { // to fix bug on iOS 11
            keyboardRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        }
        keyboardRect = view.convert(keyboardRect, from: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: (keyboardRect.size.height), right: 0.0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            let viewRect = scrollView.convert(activeTextfield.frame, from: scrollView)
            scrollView.scrollRectToVisible(viewRect, animated: true)

        }
    }
    
    /// Called when notification is hidden. super should be called when this method is overidden in subclass
    ///
    /// - Parameter notification: notification object
    @objc func keyboardWillBeHidden(notification _: Notification) {
        guard let scrollView = getScrollView() else { return }
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    func dismissKeyboardOnTap() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleKeyboardDismiss))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    func addChildViewController(childeViewController: UIViewController,inContainerView containerView: UIView) {
          self.addChild(childeViewController)
          childeViewController.view.frame = containerView.bounds
          containerView.addSubview(childeViewController.view)
          childeViewController.didMove(toParent: self)
      }
      
      func removeViewControllerFromParentViewController(childViewController: UIViewController)
      {
          childViewController.willMove(toParent: nil)
          childViewController.view.removeFromSuperview()
          childViewController.removeFromParent()
      }
    
//    func updateStatusBarToLightColor() {
//
//           UIApplication.shared.statusBarStyle = .lightContent
//      }
//
//      func updateStatusBarToDarkColor() {
//          UIApplication.shared.statusBarStyle = .default
//      }
}
