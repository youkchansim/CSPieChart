//
//  CSPieChartComponent.swift
//  Pods
//
//  Created by Youk Chansim on 2017. 1. 5..
//
//

import UIKit
import CoreGraphics

class CSPieChartComponent: UIView {

    fileprivate var startAngle: CGFloat?
    fileprivate var endAngle: CGFloat?
    fileprivate var radiusRate: CGFloat?
    fileprivate var path: UIBezierPath?
    
    internal(set) var componentColor: UIColor?
    internal(set) var lineColor: UIColor?
    internal(set) var lineLength: CGFloat?
    internal(set) var subView: UIView?
    
    internal(set) var data: CSPieChartData?
    internal(set) var index: Int?
    internal(set) var isAnimated: Bool?
    
    init(frame: CGRect, startAngle: CGFloat, endAngle: CGFloat, data: CSPieChartData, index: Int, radiusRate: CGFloat) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.data = data
        self.index = index
        self.radiusRate = radiusRate
        
        self.isAnimated = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Drawing code
        var radius: CGFloat = 0
        
        if frame.width >= frame.height {
            radius = (frame.height / 2) * radiusRate!
        } else {
            radius = (frame.width / 2) * radiusRate!
        }
        
        drawComponent(withCenter: center, radius: radius, startAngle: startAngle!, endAngle: endAngle!)
        drawLineAndSubview(withCenter: center, radius: radius, startAngle: startAngle!, endAngle: endAngle!)
    }
}

extension CSPieChartComponent {
    func drawComponent(withCenter: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) {
        path = UIBezierPath()
        path?.move(to: withCenter)
        path?.addArc(withCenter: withCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        componentColor?.setFill()
        
        path?.fill()
    }
    
    func drawLineAndSubview(withCenter: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) {
        if let subView = self.subView {
            let linePath = UIBezierPath()
            let midAngle = (startAngle + endAngle) / 2
            
            let startPoint = CGPoint(x: withCenter.x + cos(midAngle) * (radius - lineLength!), y: withCenter.y + sin(midAngle) * (radius - lineLength!))
            let turningPoint = CGPoint(x: withCenter.x + cos(midAngle) * (radius + lineLength!), y: withCenter.y + sin(midAngle) * (radius + lineLength!))
            let isEndPointLeft = turningPoint.x < withCenter.x
            let endPoint = CGPoint(x: turningPoint.x + (isEndPointLeft ? -1 : 1) * lineLength!, y: turningPoint.y)
            
            linePath.move(to: startPoint)
            linePath.addLine(to: turningPoint)
            linePath.addLine(to: endPoint)
            
            lineColor?.setStroke()
            linePath.stroke()
            linePath.close()
            
            let x = subView.frame.width
            if isEndPointLeft {
                subView.center = CGPoint(x: endPoint.x - x / 2, y: endPoint.y)
            } else {
                subView.center = CGPoint(x: endPoint.x + x / 2, y: endPoint.y)
            }
            
            addSubview(subView)
        }
    }
}

extension CSPieChartComponent {
    func containsPoint(point: CGPoint) -> Bool {
        return path?.contains(point) ?? false
    }
    
    func startAnimation(animationType: SelectingAnimationType) {
        isAnimated = true
        
        switch animationType {
        case .piece:
            startPieceAnimation()
        case .scaleUp:
            startScaleUpAnimation()
        case .touch:
            startTouchAnimation()
        default: break
        }
    }
    
    func stopAnimation(animationType: SelectingAnimationType) {
        isAnimated = false
        
        switch animationType {
        case .piece:
            stopPieceAnimation()
        case .scaleUp:
            stopScaleUpAnimation()
        case .touch:
            stopTouchAnimation()
        default: break
        }
    }
    
    private func startPieceAnimation() {
        let midAngle = (startAngle! + endAngle!) / 2
        let destinationPoint = CGPoint(x: center.x + cos(midAngle) * 8, y: center.y + sin(midAngle) * 8)
        UIView.animate(withDuration: 0.3) {
            self.center = destinationPoint
            self.superview?.layoutIfNeeded()
        }
    }
    
    private func stopPieceAnimation() {
        let midAngle = (startAngle! + endAngle!) / 2
        let destinationPoint = CGPoint(x: center.x - cos(midAngle) * 8, y: center.y - sin(midAngle) * 8)
        
        UIView.animate(withDuration: 0.3) {
            self.center = destinationPoint
            self.superview?.layoutIfNeeded()
        }
    }
    
    private func startScaleUpAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }
    }
    
    private func stopScaleUpAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    private func startTouchAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0.7
        }
    }
    
    private func stopTouchAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1.0
        }
    }
}
