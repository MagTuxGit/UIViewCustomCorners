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
    var corners: [Corner]
    var radius: CGFloat
    var dashSide: DashSide
    
    init(frame: CGRect, corners: [Corner], radius: CGFloat, dashSide: DashSide)
    {
        self.corners = corners
        self.radius = radius
        self.dashSide = dashSide

        super.init(frame: frame)
        
        customCorner()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.corners = []
        self.radius = 0
        self.dashSide = .none

        super.init(coder: aDecoder)
    }
}

extension DemoView
{
    enum Corner {
        case topLeft
        case topRight
        case bottomRight
        case bottomLeft
    }
    
    enum DashSide {
        case left
        case right
        case none
    }
    
    func customCorner()
    {
        path = UIBezierPath()
        let dashPath = UIBezierPath()

        switch dashSide {
        case .left, .none:
            path.move(to: CGPoint(x: 0, y: radius))
            topLeftCorner()
            path.addLine(to: CGPoint(x: self.frame.size.width - radius, y: 0))
            topRightCorner()
            path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height - radius))
            bottomRightCorner()
            path.addLine(to: CGPoint(x: radius, y: self.frame.size.height))
            bottomLeftCorner()
            
            dashPath.move(to: CGPoint(x: 0, y: radius))
            dashPath.addLine(to: CGPoint(x: 0, y: self.frame.size.height - radius))

        case .right:
            path.move(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height - radius))
            bottomRightCorner()
            path.addLine(to: CGPoint(x: radius, y: self.frame.size.height))
            bottomLeftCorner()
            path.addLine(to: CGPoint(x: 0, y: radius))
            topLeftCorner()
            path.addLine(to: CGPoint(x: self.frame.size.width - radius, y: 0))
            topRightCorner()
            
            dashPath.move(to: CGPoint(x: self.frame.size.width, y: radius))
            dashPath.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height - radius))
        }
        
        var strokePath = UIBezierPath(cgPath: path.cgPath)
        path.close()
        if dashSide == .none {
            strokePath = UIBezierPath(cgPath: path.cgPath)
        }
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.backgroundColor = UIColor.orange
        self.layer.mask = maskLayer
        
        let strokeLayer = CAShapeLayer()
        strokeLayer.path = strokePath.cgPath
        strokeLayer.fillColor = UIColor.clear.cgColor
        strokeLayer.strokeColor = UIColor.black.cgColor
        strokeLayer.lineWidth = 5
        self.layer.addSublayer(strokeLayer)
        
        let strokeDashLayer = CAShapeLayer()
        strokeDashLayer.path = dashPath.cgPath
        //strokeDashLayer.fillColor = UIColor.clear.cgColor
        strokeDashLayer.strokeColor = UIColor.black.cgColor
        strokeDashLayer.lineWidth = 5
        strokeDashLayer.lineDashPattern = [ 16.0, 16.0 ]
        self.layer.addSublayer(strokeDashLayer)
    }
    
    private func topLeftCorner()
    {
        if corners.contains(.topLeft) {
            path.addArc(withCenter: CGPoint(x: 0, y: 0),
                        radius: radius,
                        startAngle: CGFloat(90.0).toRadians(),
                        endAngle: CGFloat(0.0).toRadians(),
                        clockwise: false)
        } else {
            path.addArc(withCenter: CGPoint(x: radius, y: radius),
                        radius: radius,
                        startAngle: CGFloat(180.0).toRadians(),
                        endAngle: CGFloat(270.0).toRadians(),
                        clockwise: true)
        }
    }
    
    private func topRightCorner()
    {
        if corners.contains(.topRight) {
            path.addArc(withCenter: CGPoint(x: self.frame.size.width, y: 0),
                        radius: radius,
                        startAngle: CGFloat(180.0).toRadians(),
                        endAngle: CGFloat(90.0).toRadians(),
                        clockwise: false)
        } else {
            path.addArc(withCenter: CGPoint(x: self.frame.size.width - radius, y: radius),
                        radius: radius,
                        startAngle: CGFloat(270.0).toRadians(),
                        endAngle: CGFloat(0.0).toRadians(),
                        clockwise: true)
        }
    }
    
    private func bottomRightCorner()
    {
        if corners.contains(.bottomRight) {
            path.addArc(withCenter: CGPoint(x: self.frame.size.width, y: self.frame.size.height),
                        radius: radius,
                        startAngle: CGFloat(270.0).toRadians(),
                        endAngle: CGFloat(180.0).toRadians(),
                        clockwise: false)
        } else {
            path.addArc(withCenter: CGPoint(x: self.frame.size.width - radius, y: self.frame.size.height - radius),
                        radius: radius,
                        startAngle: CGFloat(0.0).toRadians(),
                        endAngle: CGFloat(90.0).toRadians(),
                        clockwise: true)
        }
    }

    private func bottomLeftCorner()
    {
        if corners.contains(.bottomLeft) {
            path.addArc(withCenter: CGPoint(x: 0.0, y: self.frame.size.height),
                        radius: radius,
                        startAngle: CGFloat(0.0).toRadians(),
                        endAngle: CGFloat(270.0).toRadians(),
                        clockwise: false)
        } else {
            path.addArc(withCenter: CGPoint(x: radius, y: self.frame.size.height - radius),
                        radius: radius,
                        startAngle: CGFloat(90.0).toRadians(),
                        endAngle: CGFloat(180.0).toRadians(),
                        clockwise: true)
        }
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat.pi / 180.0
    }
}
