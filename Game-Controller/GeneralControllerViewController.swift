//
//  GeneralControllerViewController.swift
//  Game-Controller
//
//  Created by Connor Reed on 1/7/22.
//

import UIKit

class GeneralControllerViewController: ControllerGeneralViewController {
    var keyMap = ["Space", "W", "A", "S", "D"]
    var currentKeys:[String] = []
    @IBOutlet weak var joyStickArea: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func handleJoystickTouch(touches: Set<UITouch>, event: UIEvent?){
        for touch in touches{
            let hitView = self.view.hitTest(touch.location(in: self.view), with: event)
            if hitView == self.joyStickArea{
                let location = touch.location(in: self.joyStickArea)
                var center = CGPoint()
                center.x = self.joyStickArea.frame.size.width / 2
                center.y = self.joyStickArea.frame.size.height / 2
                var relativeLocation = location
                relativeLocation.x -= center.x
                relativeLocation.y -= center.y
                let angle = self.findAngleFromRelativeLocation(location: relativeLocation)
                let keys = self.getKeysFromAngle(angle:angle)
                for key in keys{
                    if !currentKeys.contains(key){
                        //new key pressed down
                        sendKey(key: key, type: 0)
                    }
                }
                for key in currentKeys{
                    if !keys.contains(key){
                        //key released
                        sendKey(key: key, type: 0)
                    }
                }
                currentKeys = keys
            }
        }
    }
    func getKeysFromAngle(angle: Float) -> [String] {
        let sizes:[Float] = [45, 45, 45, 45, 45, 45, 45, 45]
        let keysPerSection = [["W"], ["W", "A"], ["A"], ["S", "A"], ["S"], ["S", "D"], ["D"], ["W", "D"]]
        var currentAngle:Float = 0
        for i in 0..<sizes.count{
            currentAngle += sizes[i]
            if angle > (currentAngle - sizes[i]) && angle < currentAngle{
                return keysPerSection[i]
            }
        }
        return [""]
    }
    func findAngleFromRelativeLocation(location:CGPoint) -> Float{
        let angle = atan2(location.x * -1, location.y * -1)
        var f_angle = Float(angle)
        if f_angle < 0 {
            f_angle = 2 * 3.141592 + f_angle
        }
        //radians to degrees
        let d_angle = f_angle * (180 / 3.141592)
        return d_angle
    }
    @IBAction func buttonPressed(_ sender: Any) {
        let senderButton = sender as! UIButton
        let keyToSend = keyMap[senderButton.tag]
        sendKey(key: keyToSend, type: 0)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleJoystickTouch(touches: touches, event: event)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleJoystickTouch(touches: touches, event: event)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for key in currentKeys{
            sendKey(key: key, type: 0)
        }
        currentKeys = []
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
