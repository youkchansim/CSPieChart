//
//  CSPieChartComponent.swift
//  Pods
//
//  Created by Youk Chansim on 2017. 1. 5..
//
//

import UIKit
import CoreGraphics

class CSPieChartComponent: CALayer {

    fileprivate var startAngle: CGFloat?
    fileprivate var endAngle: CGFloat?
    fileprivate var radiusRate: CGFloat?
    
    internal(set) var path: UIBezierPath?
    internal(set) var componentColor: UIColor?
    internal(set) var lineColor: UIColor?
    internal(set) var lineLength: CGFloat?
    internal(set) var subView: CALayer?
    
    internal(set) var data: CSPieChartData?
    internal(set) var index: Int?
    internal(set) var isAnimated: Bool = false
    
    init(frame: CGRect, startAngle: CGFloat, endAngle: CGFloat, data: CSPieChartData, index: Int, radiusRate: CGFloat) {
        
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.data = data
        self.index = index
        self.radiusRate = radiusRate
        
        super.init()
        
        self.frame = frame
        self.contentsScale = UIScreen.main.scale
        self.shadowOffset = .zero
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        
        // Drawing code
        var radius: CGFloat = 0
        
        if frame.width >= frame.height {
            radius = (frame.height / 2) * radiusRate!
        } else {
            radius = (frame.width / 2) * radiusRate!
        }
        
        ctx.beginPath()
        ctx.setFillColor(componentColor!.cgColor)
        ctx.setStrokeColor(UIColor.clear.cgColor)
        ctx.addPath(drawComponent(withCenter: position, radius: radius, startAngle: startAngle!, endAngle: endAngle!))
        ctx.closePath()
        ctx.drawPath(using: .fillStroke)
        
        ctx.beginPath()
        ctx.setStrokeColor(lineColor!.cgColor)
        ctx.setFillColor(UIColor.clear.cgColor)
        ctx.addPath(drawLineAndSubview(withCenter: position, radius: radius, startAngle: startAngle!, endAngle: endAngle!))
        ctx.closePath()
        ctx.drawPath(using: .fillStroke)
    }
}

extension CSPieChartComponent {
    func drawComponent(withCenter: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) -> CGPath {
        path = UIBezierPath()
        path?.move(to: withCenter)
        path?.addArc(withCenter: withCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        path?.close()
        
        return path!.cgPath
    }
    
    func drawLineAndSubview(withCenter: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) -> CGPath {
        guard let subView = self.subView else { return UIBezierPath().cgPath }
        let linePath = UIBezierPath()
        let midAngle = (startAngle + endAngle) / 2
        
        let startPoint = CGPoint(x: withCenter.x + cos(midAngle) * (radius - lineLength!), y: withCenter.y + sin(midAngle) * (radius - lineLength!))
        let turningPoint = CGPoint(x: withCenter.x + cos(midAngle) * (radius + lineLength!), y: withCenter.y + sin(midAngle) * (radius + lineLength!))
        let isEndPointLeft = turningPoint.x < withCenter.x
        let endPoint = CGPoint(x: turningPoint.x + (isEndPointLeft ? -1 : 1) * lineLength!, y: turningPoint.y)
        
        linePath.move(to: startPoint)
        linePath.addLine(to: turningPoint)
        linePath.move(to: turningPoint)
        linePath.addLine(to: endPoint)
        linePath.close()
        
        let x = subView.frame.width
        if isEndPointLeft {
            subView.position = CGPoint(x: endPoint.x - x / 2, y: endPoint.y)
        } else {
            subView.position = CGPoint(x: endPoint.x + x / 2, y: endPoint.y)
        }
        
        addSublayer(subView)
        
        return linePath.cgPath
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
        let destinationPoint = CGPoint(x: position.x + cos(midAngle) * 8, y: position.y + sin(midAngle) * 8)
        UIView.animate(withDuration: 0.3) {
            self.position = destinationPoint
        }
    }
    
    private func stopPieceAnimation() {
        let midAngle = (startAngle! + endAngle!) / 2
        let destinationPoint = CGPoint(x: position.x - cos(midAngle) * 8, y: position.y - sin(midAngle) * 8)
        UIView.animate(withDuration: 0.3) {
            self.position = destinationPoint
        }
    }
    
    private func startScaleUpAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.setAffineTransform(CGAffineTransform(scaleX: 1.3, y: 1.3))
        }
    }
    
    private func stopScaleUpAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.setAffineTransform(CGAffineTransform(scaleX: 1.0, y: 1.0))
        }
    }
    
    private func startTouchAnimation() {
        zPosition = 1.0
        UIView.animate(withDuration: 0.3) {
            self.shadowRadius = 5
            self.shadowOpacity = 10
        }
    }
    
    private func stopTouchAnimation() {
        zPosition = 0
        UIView.animate(withDuration: 0.3) {
            self.shadowRadius = 3
            self.shadowOpacity = 0
        }
    }
}
