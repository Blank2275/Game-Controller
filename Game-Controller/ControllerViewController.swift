//
//  ControllerViewController.swift
//  Game-Controller
//
//  Created by Connor Reed on 1/7/22.
//

import UIKit

class ControllerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func sayHiClicked(_ sender: Any) {
        webSocketDelegate?.send(msg: "hello")
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
