//
//  ViewController.swift
//  EndlessNavigation
//
//  Created by Oh Sang Young on 2015. 11. 2..
//  Copyright © 2015년 Oh Sang Young. All rights reserved.
//

import UIKit

func intToHangul(num: Int) -> String {
    let x0 : [String] = ["", "", "이", "삼", "사", "오", "육", "칠", "팔", "구"]
    let x1 : [String] = ["", "일", "이", "삼", "사", "오", "육", "칠", "팔", "구"]
    let x10 : [String] = ["", "십", "백", "천"]
    let x10000 : [String] = ["", "만", "억", "조", "경"]

    var currentPos = 0
    var remainNum = num
    var han : String = ""

    while (true) {
        let digit = remainNum % 10
        remainNum = remainNum / 10

        if ((currentPos % 4) == 0) {
            han = x1[digit] + x10000[currentPos / 4] + han
        }
        else {
            han = x0[digit] + x10[currentPos % 4] + han
        }

        if (remainNum == 0) {
            break
        }
        currentPos += 1
    }
    
    return han
}

class ViewController: UIViewController {

    @IBOutlet weak var currentNumLabel: UILabel!
    @IBOutlet weak var currentHanLabel: UILabel!

    @IBOutlet weak var homeBarButtonItem: UIBarButtonItem!

    @IBOutlet weak var nextButton: UIButton!

    var currentDepth : Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        currentDepth = self.navigationController!.viewControllers.count

        //
        // template image를 사용하기 위해서 IB 대신 여기에서 이미지를 만든다.
        // CHANGE : asset catalog에서 변경 가능
        //let templatedImage = UIImage(named: "rightarrow")!.imageWithRenderingMode(.AlwaysTemplate)

        //nextButton.setImage(templatedImage, forState: .Normal)

        if (currentDepth == 1) {
            self.navigationItem.rightBarButtonItems = nil
//            homeBarButtonItem.enabled = false
        }

        self.navigationItem.title = "\(currentDepth)"
        currentNumLabel.text = "\(currentDepth)"
        currentHanLabel.text = intToHangul(currentDepth)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        let deviceOrientation : UIDeviceOrientation = UIDevice.currentDevice().orientation

        if (deviceOrientation == .LandscapeLeft || deviceOrientation == .LandscapeRight) {
            currentNumLabel.alpha = 0.0
            currentHanLabel.alpha = 1.0
        }
        else {
            currentNumLabel.alpha = 1.0
            currentHanLabel.alpha = 0.0
        }
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        changeView()
    }

    func changeView() {
        let deviceOrientation : UIDeviceOrientation = UIDevice.currentDevice().orientation

        let landscape:Bool = (deviceOrientation == .LandscapeLeft || deviceOrientation == .LandscapeRight) ? true : false

//        UIView.animateWithDuration(0.3, animations: {
//            self.currentNumLabel.alpha = landscape ? 0.0 : 1.0
//            self.currentHanLabel.alpha = landscape ? 1.0 : 0.0
//        })

        // iOS 9 style
        UIView.animateWithDuration(0.3) { () -> Void in
            self.currentNumLabel.alpha = landscape ? 0.0 : 1.0
            self.currentHanLabel.alpha = landscape ? 1.0 : 0.0
        }
    }

    @IBAction func nextPressed(sender: UIButton) {

        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ViewController") as! ViewController


        self.navigationController!.pushViewController(viewController, animated: true)
    }

    @IBAction func goHome(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}

