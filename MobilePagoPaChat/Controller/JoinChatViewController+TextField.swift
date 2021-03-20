//
//  JoinChatViewController+TextField.swift
//  MobilePagoPaChat
//
//  Created by Angelo Cammaroto on 20/03/21.
//

import Foundation
import UIKit

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
