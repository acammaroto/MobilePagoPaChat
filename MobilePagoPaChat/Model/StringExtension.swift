//
//  StringExtension.swift
//  pagoPaChat
//
//  Created by Angelo Cammaroto on 17/03/21.
//

import Foundation


extension String {
  func withoutWhitespace() -> String {
    return self.replacingOccurrences(of: "\n", with: " ")
      .replacingOccurrences(of: "\r", with: " ")
      .replacingOccurrences(of: "\0", with: " ")
  }
}
