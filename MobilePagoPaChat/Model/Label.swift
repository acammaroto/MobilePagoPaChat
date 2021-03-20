//
//  Label.swift
//  MobilePagoPaChat
//
//  Created by Angelo Cammaroto on 17/03/21.
//
import UIKit

class Label: UILabel {
  override func drawText(in rect: CGRect) {
    let insets = UIEdgeInsets.init(top: 8, left: 16, bottom: 8, right: 16)
    super.drawText(in: rect.inset(by: insets))
  }
}
