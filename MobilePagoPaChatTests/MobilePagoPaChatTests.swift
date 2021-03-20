//
//  MobilePagoPaChatTests.swift
//  MobilePagoPaChatTests
//
//  Created by Angelo Cammaroto on 17/03/21.
//

import XCTest
@testable import MobilePagoPaChat

class MobilePagoPaChatTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
    }
    
    func testGivenAMessaggeWithANewLineCodeThenExpectASingleLineString() {
        let message = Message(message: "Hello\nthere", messageSender: .ourself, username: "Angelo")
        XCTAssertEqual(message.message, "Hello there")
    }
    
    func testGivenAMessaggeWithANullCharCodeThenExpectASingleLineString() {
        let message = Message(message: "Hello\0there", messageSender: .ourself, username: "Angelo")
        XCTAssertEqual(message.message, "Hello there")
    }
    
    func testGivenAMessaggeWithABreakLineCodeThenExpectASingleLineString() {
        let message = Message(message: "Hello\rthere", messageSender: .ourself, username: "Angelo")
        XCTAssertEqual(message.message, "Hello there")
    }
}
