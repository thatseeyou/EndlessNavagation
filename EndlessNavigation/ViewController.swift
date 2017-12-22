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
    var remainNum = num, digit = 0
    var han = ""

    while (true) {
        (remainNum, digit) = remainNum.quotientAndRemainder(dividingBy: 10)

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

    @IBOutlet weak var topStackView: UIStackView!

    @IBOutlet weak var currentNumLabel: UILabel!
    @IBOutlet weak var currentHanLabel: UILabel!

    @IBOutlet weak var homeBarButtonItem: UIBarButtonItem!

    @IBOutlet weak var nextButton: UIButton!

    var currentDepth : Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        currentDepth = self.navigationController!.viewControllers.count

        // subview의 가운데 정렬을 위해서 사용
        // dummy view를 추가하지 않기 위해서 layout guide를 코드에 추가한다. (iOS 9)
        // 아직 IB에서 layout guide를 추가할 수 없다.
        let container = UILayoutGuide()
        view.addLayoutGuide(container)

        // Set interior constraints
        container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        container.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true

        // Set exterior constraints
        // WARNING : IB에서 constraint를 추가하지 않으면 자동으로 추가를 해서 아래와 충돌할 수 있으므로 일단 추가를 하고
        //           Remove at buiuld time 옵션을 선택한다.
        topStackView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        topStackView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true


        //
        // template image를 사용하기 위해서 IB 대신 여기에서 이미지를 만든다.
        // CHANGE : asset catalog에서 변경 가능
        //let templatedImage = UIImage(named: "rightarrow")!.imageWithRenderingMode(.AlwaysTemplate)

        //nextButton.setImage(templatedImage, forState: .Normal)

        if (currentDepth == 1) {
            self.navigationItem.rightBarButtonItems = nil
//            homeBarButtonItem.enabled = false
        }

        self.navigationItem.title = "\(currentDepth!)"
        currentNumLabel.text = "\(currentDepth!)"
        currentHanLabel.text = intToHangul(num: currentDepth)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        let deviceOrientation : UIDeviceOrientation = UIDevice.current.orientation

        if (deviceOrientation == .landscapeLeft || deviceOrientation == .landscapeRight) {
            currentNumLabel.alpha = 0.0
            currentHanLabel.alpha = 1.0
        }
        else {
            currentNumLabel.alpha = 1.0
            currentHanLabel.alpha = 0.0
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segue.destinationViewController
        if (segue.identifier == "showHistory") {
            let presentedViewController = segue.destination as! UINavigationController

            // viewDidLoad 전 단계이기는 하지만 이미 contentViewController는 생성된 상태로 보임
            let contentViewController = presentedViewController.viewControllers[0] as! JumpBackTableViewController
            contentViewController.navDepth = currentDepth
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        // old orientation : statusBarOrientation을 통해서 얻을 수 있다.
        // new orientation : 다음과 같이 targetTransform을 통해서 계산할 수 있다.
        // coordinator.targetTransform()

        changeView()
    }

    func changeView() {
        let deviceOrientation : UIDeviceOrientation = UIDevice.current.orientation

        let landscape:Bool = (deviceOrientation == .landscapeLeft || deviceOrientation == .landscapeRight) ? true : false

        // iOS 9 style
        UIView.animate(withDuration: 0.3) { () -> Void in
            self.currentNumLabel.alpha = landscape ? 0.0 : 1.0
            self.currentHanLabel.alpha = landscape ? 1.0 : 0.0
        }
    }

    @IBAction func goHome(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    // MARK: gesture recognizer delegate    
    @IBAction func longPressed(sender: UILongPressGestureRecognizer) {

        if sender.state == .began {
            performSegue(withIdentifier: "showHistory", sender: self)
        }
    }
}

