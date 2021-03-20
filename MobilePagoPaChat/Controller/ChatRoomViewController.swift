//
//  ChatRoomViewController.swift
//  MobilePagoPaChat
//
//  Created by Angelo Cammaroto on 17/03/21.
//
import UIKit

class ChatRoomViewController: UIViewController {
    let tableView = UITableView()
    let messageInputBar = MessageInputView()
    let chatRoom = ChatRoom()
    
    var messages: [Message] = []
    
    var username = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        chatRoom.delegate = self
        chatRoom.setupNetworkCommunication()
        chatRoom.joinChat(username: username)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        chatRoom.stopChatSession()
    }
}


extension ChatRoomViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        loadViews()
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)!.cgRectValue
            let messageBarHeight = messageInputBar.bounds.size.height
            let point = CGPoint(x: messageInputBar.center.x, y: endFrame.origin.y - messageBarHeight/2.0)
            let inset = UIEdgeInsets(top: 0, left: 0, bottom: endFrame.size.height, right: 0)
            UIView.animate(withDuration: 0.25) {
                self.messageInputBar.center = point
                self.tableView.contentInset = inset
            }
        }
    }
    
    func loadViews() {
        navigationItem.title = "Let's Chat!"
        navigationItem.backBarButtonItem?.title = "Run!"
        
        view.backgroundColor = UIColor(named: "pa-blue")
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        view.addSubview(messageInputBar)
        
        messageInputBar.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let messageBarHeight:CGFloat = 60.0
        let size = view.bounds.size
        tableView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height - messageBarHeight - view.safeAreaInsets.bottom)
        messageInputBar.frame = CGRect(x: 0, y: size.height - messageBarHeight - view.safeAreaInsets.bottom, width: size.width, height: messageBarHeight)
    }
}



//MARK: - Message Input Bar
extension ChatRoomViewController: MessageInputDelegate {
    func sendWasTapped(message: String) {
        chatRoom.send(message: message)
    }
}

//MARK: - ChatRoomDelegate
extension ChatRoomViewController: ChatRoomDelegate {
    func didConnectionOK() {
    }
    
    func didConnectionFailsWithError(error: String) {
        let alert = UIAlertController(title: "Warning", message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: {_ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func received(message: Message) {
        insertNewMessageCell(message)
    }
}

