//
//  TopNavigationController.swift
//  EndlessNavigation
//
//  Created by Oh Sang Young on 2015. 11. 30..
//  Copyright © 2015년 Oh Sang Young. All rights reserved.
//

import UIKit

class TopNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addObservers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewWillAppear(animated: Bool) {
        log_trace()
    }

    override func viewDidAppear(animated: Bool) {
        log_trace()
    }

    override func viewWillDisappear(animated: Bool) {
        log_trace()
    }

    override func viewDidDisappear(animated: Bool) {
        log_trace()
    }

    func addObservers() {
        // object : limit sender
        NSNotificationCenter.defaultCenter().addObserverForName(JumpBackTableControllerDidSelectItemNotification, object: nil, queue: nil) { (notification:NSNotification) -> Void  in
            self.log_debug("received " + notification.name)

            if let depth:Int = notification.userInfo?[JumpBackTableControllerSelectedItemUserInfoKey] as? Int {
                assert(self.viewControllers.count > depth)
                self.popToViewController(self.viewControllers[depth], animated: true)
            }
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
