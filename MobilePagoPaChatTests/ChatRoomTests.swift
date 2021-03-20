//
//  ChatRoomTests.swift
//  MobilePagoPaChatTests
//
//  Created by Angelo Cammaroto on 18/03/21.
//

import XCTest
@testable import MobilePagoPaChat

class ChatRoomTests: XCTestCase, ChatRoomDelegate {

    var chatRoom: ChatRoom!
    private var resultExpecatations: XCTestExpectation!
    private var result: String!
    
    override func setUp() {
        super.setUp()
        chatRoom = ChatRoom()
    }
    
    func testGivenAConnectionKOThenExpectErrorRaisedUpFromDelegate() {
        chatRoom.delegate = self
        chatRoom.setupNetworkCommunication()
        chatRoom.joinChat(username: "Angelo")
        XCTAssertEqual(self.result, "Connection refused by the server")
    }
    
    func received(message: Message) {
     
    }
    
    func didConnectionFailsWithError(error: String) {
        self.result = error
    }
    
    func didConnectionOK() {
        
    }
}
