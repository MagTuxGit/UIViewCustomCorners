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
        
        let frame = CGRect(x: self.view.frame.size.width/2 - width/2,
                           y: self.view.frame.size.height/2 - height/2,
                           width: width,
                           height: height)
        
        let demoView = DemoView(frame: frame, corners: [.topRight, .bottomRight], radius: 20)

        self.view.addSubview(demoView)
    }
}

