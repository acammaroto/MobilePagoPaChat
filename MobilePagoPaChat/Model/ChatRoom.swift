//
//  ChatRoom.swift
//  MobilePagoPaChat
//
//  Created by Angelo Cammaroto on 17/03/21.
//

import Foundation

protocol ChatRoomDelegate: class {
    func received(message: Message)
    func didConnectionFailsWithError(error: String)
    func didConnectionOK()
}

class ChatRoom: NSObject {
    
    var inputStream: InputStream!
    var outputStream: OutputStream!
    
    weak var delegate: ChatRoomDelegate?
    
    var username = ""
    
    let maxReadLength = 4096
    
    func setupNetworkCommunication() {
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        let host: CFString = "localhost" as CFString
        let port: UInt32 = 10000
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault,
                                           host,
                                           port,
                                           &readStream,
                                           &writeStream)
        
        inputStream = readStream!.takeRetainedValue()
        outputStream = writeStream!.takeRetainedValue()
        
        
        inputStream.delegate = self
        outputStream.delegate = self
        
        inputStream.schedule(in: .current, forMode: .common)
        outputStream.schedule(in: .current, forMode: .common)
        
        inputStream.open()
        outputStream.open()
    }
    
    func joinChat(username: String) {
        let data = "iam:\(username)".data(using: .utf8)!
        self.username = username
        writeOnStream(data: data)
    }
    
    func send(message: String) {
        let data = "msg:\(message)".data(using: .utf8)!
        writeOnStream(data: data)
    }
    
    func stopChatSession() {
        inputStream.close()
        outputStream.close()
    }
    
    func writeOnStream(data: Data) {
        _ = data.withUnsafeBytes {
            guard let pointer = $0.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                print("Error joining chat")
                return
            }
          outputStream.write(pointer, maxLength: data.count)
            
        }
    }
    
}



extension ChatRoom: StreamDelegate {
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .openCompleted:
            delegate?.didConnectionOK()
        case .hasBytesAvailable:
            print("new message received")
            readAvailableBytes(stream: aStream as! InputStream)
        case .endEncountered:
            print("new message received")
            stopChatSession()
        case .errorOccurred:
            print("error occurred")
            delegate?.didConnectionFailsWithError(error: "Connection refused by the server")
        case .hasSpaceAvailable:
            print("has space available")
        default:
            print("some other event...")
        }
    }
    
    private func readAvailableBytes(stream: InputStream) {
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: maxReadLength)
        while stream.hasBytesAvailable {
            let numberOfBytesRead = inputStream.read(buffer, maxLength: maxReadLength)
            
            if numberOfBytesRead < 0, let error = stream.streamError {
                print(error)
                break
            }
            
            // Construct the message object
            if let message = processedMessageString(buffer: buffer, length: numberOfBytesRead) {
                // Notify interested parties
                delegate?.received(message: message)
            }
        }
    }
    
    private func processedMessageString(buffer: UnsafeMutablePointer<UInt8>,
                                        length: Int) -> Message? {
        //1
        guard
            let stringArray = String(
                bytesNoCopy: buffer,
                length: length,
                encoding: .utf8,
                freeWhenDone: true)?.components(separatedBy: ":"),
            let name = stringArray.first,
            let message = stringArray.last
        else {
            return nil
        }
        //2
        let messageSender: MessageSenderType = (name == self.username) ? .ourself : .someoneElse
        //3
        return Message(message: message, messageSender: messageSender, username: name)
    }
}
