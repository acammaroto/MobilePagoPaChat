//
//  Message.swift
//  pagoPaChat
//
//  Created by Angelo Cammaroto on 17/03/21.
//

import Foundation

struct Message {
  let message: String
  let senderUsername: String
  let messageSender: MessageSenderType
  
  init(message: String, messageSender: MessageSenderType, username: String) {
    self.message = message.withoutWhitespace()
    self.messageSender = messageSender
    self.senderUsername = username
  }
}
