//
//  ViewController.swift
//  BezierCorner
//
//  Created by Andriy Trubchanin on 4/4/19.
//  Copyright © 2019 Andriy Trubchanin. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let width: CGFloat = 240.0
        let height: CGFloat = 160.0
        
        let frame1 = CGRect(x: self.view.frame.size.width/2 - width/2,
                            y: self.view.frame.size.height/2 - height/2,
                            width: width / 2,
                            height: height)
        let demoView1 = DemoView(frame: frame1, corners: [.topRight, .bottomRight], radius: 20, dashSide: .right)
        self.view.addSubview(demoView1)

        let frame2 = CGRect(x: self.view.frame.size.width/2 + 8,
                            y: self.view.frame.size.height/2 - height/2,
                            width: width / 2,
                            height: height)
        let demoView2 = DemoView(frame: frame2, corners: [.topLeft, .bottomLeft], radius: 20, dashSide: .left)
        self.view.addSubview(demoView2)
    }
}
