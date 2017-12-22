//
//  JumpBackTableViewController.swift
//  EndlessNavigation
//
//  Created by Oh Sang Young on 2015. 11. 13..
//  Copyright © 2015년 Oh Sang Young. All rights reserved.
//

import UIKit

let JumpBackTableControllerDidSelectItemNotification = "JumpBackTableControllerDidSelectItemNotification"
let JumpBackTableControllerSelectedItemUserInfoKey = "SelectedItem"

class JumpBackTableViewController: UITableViewController {

    var navDepth = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return navDepth
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath as IndexPath)
        let label = cell.contentView.viewWithTag(100) as! UILabel

        label.text = "\(indexPath.row + 1)"

        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // NOTICE:
        // NavigationViewController의 content view controller(ViewController)에서 present 했지만
        // presentingViewController는 navigation controller가 되고 있다. 
        //let topNavigationController = self.presentingViewController as? UINavigationController

        presentingViewController?.dismiss(animated: true) { () -> Void in

            NotificationCenter.default.post(name: NSNotification.Name(rawValue: JumpBackTableControllerDidSelectItemNotification), object: self, userInfo: [JumpBackTableControllerSelectedItemUserInfoKey: indexPath.row])
        }
    }
}
