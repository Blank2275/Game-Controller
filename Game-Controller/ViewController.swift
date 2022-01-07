//
//  ViewController.swift
//  Game-Controller
//
//  Created by Connor Reed on 1/7/22.
//

import UIKit

class WebSocket: NSObject, URLSessionWebSocketDelegate{
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("Web Socket did connect")
        ping()
        receive()
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Web Socket did disconnect")
    }
    func ping(){
        webSocketTask?.sendPing{error in
            if let error = error{
                print("error in ping \(error)")
            } else{
                print("connection is alive")
                DispatchQueue.global().asyncAfter(deadline: .now() + 5){
                    self.ping()
                }
            }
        }
    }
    func close(){
        let reason = "Closing Connection".data(using: .utf8)
        webSocketTask?.cancel(with: .goingAway, reason: reason)
    }
    func send(msg:String){
        webSocketTask?.send(.string(msg)){error in
            if let error = error{
                print("error sending \(error)")
            }
        }
    }
    func receive(){
        webSocketTask!.receive{result in
            switch result{
            case .success(let message):
                switch message{
                case .data(let data):
                    print(data)
                case.string(let string):
                    print(string)
                
                }
            case .failure(let error):
                print("error receiving \(error)")
                
            }
            self.receive()
        }
    }
}
var webSocketTask:URLSessionWebSocketTask?
var webSocketDelegate:WebSocket?
var session:URLSession?
class ViewController: UIViewController{
    
    @IBOutlet weak var urlInput: UITextField!
    @IBOutlet weak var connectButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        webSocketDelegate = WebSocket()
        session = URLSession(configuration: .default, delegate: webSocketDelegate, delegateQueue: OperationQueue())
        session = session!
    }
        
        // Do any additional setup after loading the view.
    @IBAction func connect(_ sender: Any) {
        var urlString = "ws://localhost:8080"
        let url = URL(string: urlString)!
        webSocketTask = session?.webSocketTask(with: url)
        webSocketTask?.resume()
        webSocketDelegate?.send(msg: "hello")
        performSegue(withIdentifier: "controllerSegue", sender: self)
    }

}

