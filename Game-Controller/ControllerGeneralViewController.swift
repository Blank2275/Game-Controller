//
//  ControllerGeneralViewController.swift
//  Game-Controller
//
//  Created by Connor Reed on 1/7/22.
//

import UIKit
import SpriteKit

class ControllerGeneralViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func sendKey(key:String, type:Int){
        switch type{
        case 0://keys
            let msgObject = ["type":"key", "msg":key]
            do{
            let data = try JSONSerialization.data(withJSONObject: msgObject, options: .prettyPrinted)
                let msg = String(data: data, encoding: .utf8) ?? ""
            webSocketDelegate?.send(msg: msg)
            } catch{
                
            }
        case 1:
            webSocketDelegate?.send(msg: key)
        default:
            break
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
