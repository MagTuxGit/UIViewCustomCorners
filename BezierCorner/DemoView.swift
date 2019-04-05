//
//  DemoView.swift
//  BezierCorner
//
//  Created by Andriy Trubchanin on 4/4/19.
//  Copyright © 2019 Andriy Trubchanin. All rights reserved.
//

import UIKit

class DemoView: UIView
{
    var path: UIBezierPath!
    
    init(frame: CGRect, corners: [Corner], radius: CGFloat) {
        super.init(frame: frame)
        customCorner(radius: radius, corners: corners)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /*
    override func draw(_ rect: CGRect) {
        if let path = path {
            path.lineWidth = 3
            UIColor.black.setStroke()
            path.stroke()
        }
    }
     */
}

extension DemoView
{
    enum Corner {
        case topLeft
        case topRight
        case bottomRight
        case bottomLeft
    }
    
    func customCorner(radius: CGFloat = 0, corners: [Corner] = [])
    {
        path = UIBezierPath()
        
        if corners.contains(.topLeft) {
            path.move(to: CGPoint(x: 0, y: radius))
            path.addArc(withCenter: CGPoint(x: 0, y: 0),
                        radius: radius,
                        startAngle: CGFloat(90.0).toRadians(),
                        endAngle: CGFloat(0.0).toRadians(),
                        clockwise: false)
        } else {
            path.move(to: CGPoint(x: 0.0, y: 0.0))
        }
        
        if corners.contains(.topRight) {
            path.addLine(to: CGPoint(x: self.frame.size.width - radius, y: 0))
            path.addArc(withCenter: CGPoint(x: self.frame.size.width, y: 0),
                        radius: radius,
                        startAngle: CGFloat(180.0).toRadians(),
                        endAngle: CGFloat(90.0).toRadians(),
                        clockwise: false)
        } else {
            path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
        }

        if corners.contains(.bottomRight) {
            path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height - radius))
            path.addArc(withCenter: CGPoint(x: self.frame.size.width, y: self.frame.size.height),
                        radius: radius,
                        startAngle: CGFloat(270.0).toRadians(),
                        endAngle: CGFloat(180.0).toRadians(),
                        clockwise: false)
        } else {
            path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        }

        if corners.contains(.bottomLeft) {
            path.addLine(to: CGPoint(x: radius, y: self.frame.size.height))
            path.addArc(withCenter: CGPoint(x: 0.0, y: self.frame.size.height),
                        radius: radius,
                        startAngle: CGFloat(0.0).toRadians(),
                        endAngle: CGFloat(270.0).toRadians(),
                        clockwise: false)
        } else {
            path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        }

        path.close()

        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.backgroundColor = UIColor.orange
        self.layer.mask = maskLayer
        
        let strokeLayer = CAShapeLayer()
        strokeLayer.path = path.cgPath
        strokeLayer.fillColor = UIColor.clear.cgColor
        strokeLayer.strokeColor = UIColor.black.cgColor
        strokeLayer.lineWidth = 5
        self.layer.addSublayer(strokeLayer)
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat.pi / 180.0
    }
}
