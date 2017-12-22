//
//  TopNavigationController.swift
//  EndlessNavigation
//
//  Created by Oh Sang Young on 2015. 11. 30..
//  Copyright © 2015년 Oh Sang Young. All rights reserved.
//

import UIKit

class TopNavigationController: UINavigationController {

    var observer : NSObjectProtocol?;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addObservers()
    }

    deinit {
        // meaningless on current context
        removeObservers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewWillAppear(_ animated: Bool) {
        log_trace()
    }

    override func viewDidAppear(_ animated: Bool) {
        log_trace()
    }

    override func viewWillDisappear(_ animated: Bool) {
        log_trace()
    }

    override func viewDidDisappear(_ animated: Bool) {
        log_trace()
    }

    func addObservers() {
        // object : limit sender
        observer = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: JumpBackTableControllerDidSelectItemNotification), object: nil, queue: nil) { (notification:Notification) -> Void  in
            self.log_debug(msg: "received " + notification.name.rawValue)

            if let depth:Int = notification.userInfo?[JumpBackTableControllerSelectedItemUserInfoKey] as? Int {
                assert(self.viewControllers.count > depth)
                self.popToViewController(self.viewControllers[depth], animated: true)
            }
        }
    }

    func removeObservers() {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer);
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
