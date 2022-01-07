//
//  ControllerGeneralViewController.swift
//  Game-Controller
//
//  Created by Connor Reed on 1/7/22.
//

import UIKit

class ControllerGeneralViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func sendKey(key:String){
        webSocketDelegate?.send(msg: key)
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
