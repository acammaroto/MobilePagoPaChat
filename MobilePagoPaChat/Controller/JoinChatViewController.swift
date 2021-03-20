//
//  ViewController.swift
//  MobilePagoPaChat
//
//  Created by Angelo Cammaroto on 17/03/21.
//

import UIKit

class JoinChatViewController: UIViewController {
  let logoImageView = UIImageView()
  let shadowView = UIView()
  let nameTextField = TextField()
}

extension JoinChatViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let chatRoomVC = ChatRoomViewController()
    if let username = nameTextField.text {
      chatRoomVC.username = username
    }
    navigationController?.pushViewController(chatRoomVC, animated: true)
    return true
  }
}

class TextField: UITextField {
  let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8)
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
}

extension JoinChatViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadViews()
    nameTextField.accessibilityIdentifier = "nameTextField"
    view.addSubview(shadowView)
    view.addSubview(logoImageView)
    view.addSubview(nameTextField)
    
  }

  func loadViews() {
    view.backgroundColor = UIColor(named: "pa-blue")
    navigationItem.title = "PagoPa Chat!"
    
    logoImageView.image = UIImage(named: "pachat")
    logoImageView.layer.cornerRadius = 4
    logoImageView.clipsToBounds = true
    
    shadowView.layer.shadowColor = UIColor.black.cgColor
    shadowView.layer.shadowRadius = 5
    shadowView.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
    shadowView.layer.shadowOpacity = 0.5
    
    nameTextField.placeholder = "What's your username?"
    nameTextField.backgroundColor = .white
    nameTextField.layer.cornerRadius = 4
    nameTextField.delegate = self
    
    let backItem = UIBarButtonItem()
    backItem.title = "Exit"
    navigationItem.backBarButtonItem = backItem
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    logoImageView.bounds = CGRect(x: 0, y: 0, width: 150, height: 150)
    logoImageView.center = CGPoint(x: view.bounds.size.width / 2.0, y: logoImageView.bounds.size.height / 2.0 + view.bounds.size.height/4)
    shadowView.frame = logoImageView.frame
    
    nameTextField.bounds = CGRect(x: 0, y: 0, width: view.bounds.size.width - 40, height: 44)
    nameTextField.center = CGPoint(x: view.bounds.size.width / 2.0, y: logoImageView.center.y + logoImageView.bounds.size.height / 2.0 + 20 + 22)
  }
}
