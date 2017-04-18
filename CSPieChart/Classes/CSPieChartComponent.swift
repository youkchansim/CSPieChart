//
//  CSPieChartComponent.swift
//  Pods
//
//  Created by Youk Chansim on 2017. 1. 5..
//
//

import UIKit

class CSPieChartComponent: CALayer {

    fileprivate var startAngle: CGFloat = 0
    fileprivate var endAngle: CGFloat = 0
    fileprivate var radiusRate: CGFloat = 0
    
    internal(set) var componentColor: UIColor?
    internal(set) var lineColor: UIColor?
    internal(set) var lineLength: CGFloat?
    internal(set) var subView: CALayer?
    
    internal(set) var data: CSPieChartData?
    internal(set) var index: Int?
    internal(set) var isAnimated: Bool = false
    
    internal(set) var componentLayer = CAShapeLayer()
    internal(set) var lineLayer = CAShapeLayer()
    
    fileprivate var radius: CGFloat = 0
    fileprivate var animated = false
    fileprivate var componentPath = UIBezierPath()
    
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
        
        if frame.width >= frame.height {
            radius = (frame.height / 2) * radiusRate
        } else {
            radius = (frame.width / 2) * radiusRate
        }
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CSPieChartComponent {
    func draw(animated: Bool) {
        self.animated = animated
        
        createComponentLayer(withCenter: position, radius: radius)
        createLineAndSubviewLayer(withCenter: position, radius: radius)
        
        if animated {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = 1
            animation.duration = 0.5
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            animation.delegate = self
            animation.isRemovedOnCompletion = false
            componentLayer.add(animation, forKey: "componentAnimation")
        }
    }
    
    func createComponentLayer(withCenter: CGPoint, radius: CGFloat) {
        let path = UIBezierPath()
        let startPoint = CGPoint(x: withCenter.x + cos(startAngle) * (radius - (radius / 2)), y: withCenter.y + sin(startAngle) * (radius - (radius / 2)))
        
        path.move(to: startPoint)
        path.addArc(withCenter: withCenter, radius: radius - (radius / 2), startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        componentLayer.path = path.cgPath
        componentLayer.fillColor = UIColor.clear.cgColor
        componentLayer.strokeColor = componentColor?.cgColor
        
        let width = radius
        componentLayer.lineWidth = CGFloat(width)
        
        componentPath.move(to: withCenter)
        componentPath.addArc(withCenter: withCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        addSublayer(componentLayer)
    }
    
    func createLineAndSubviewLayer(withCenter: CGPoint, radius: CGFloat) {
        guard let subView = self.subView else { return }
        
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
        
        lineLayer.path = linePath.cgPath
        lineLayer.strokeColor = lineColor?.cgColor
        lineLayer.fillColor = UIColor.clear.cgColor
        
        addSublayer(lineLayer)
        
        let x = subView.frame.width
        if isEndPointLeft {
            subView.position = CGPoint(x: endPoint.x - x / 2, y: endPoint.y)
        } else {
            subView.position = CGPoint(x: endPoint.x + x / 2, y: endPoint.y)
        }
        addSublayer(subView)
        
        if animated {
            lineLayer.strokeEnd = 0
            subView.opacity = 0
        }
    }
}

extension CSPieChartComponent: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let animation = anim as? CABasicAnimation {
            if componentLayer.animation(forKey: "componentAnimation") == animation {
                let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
                strokeAnimation.fromValue = 0
                strokeAnimation.toValue = 1
                strokeAnimation.fillMode = kCAFillModeBoth
                strokeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                strokeAnimation.delegate = self
                strokeAnimation.isRemovedOnCompletion = false
                lineLayer.add(strokeAnimation, forKey: "lineAnimation")
                
                let alphaAnimation = CABasicAnimation(keyPath: "opacity")
                alphaAnimation.fromValue = 0
                alphaAnimation.toValue = 1
                alphaAnimation.fillMode = kCAFillModeBoth
                alphaAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                alphaAnimation.delegate = self
                alphaAnimation.isRemovedOnCompletion = false
                subView?.add(alphaAnimation, forKey: "alphaAnimation")
                
                componentLayer.strokeEnd = 1
                componentLayer.removeAnimation(forKey: "componentAnimation")
            } else if lineLayer.animation(forKey: "lineAnimation") == animation {
                lineLayer.strokeEnd = 1
                lineLayer.removeAnimation(forKey: "lineAnimation")
            } else if subView?.animation(forKey: "alphaAnimation") == animation {
                subView?.opacity = 1
                subView?.removeAnimation(forKey: "alphaAnimation")
            }
        }
    }
}

extension CSPieChartComponent {
    func containPoint(point: CGPoint) -> Bool {
        return componentPath.contains(point)
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
        let midAngle = (startAngle + endAngle) / 2
        let destinationPoint = CGPoint(x: position.x + cos(midAngle) * 8, y: position.y + sin(midAngle) * 8)
        UIView.animate(withDuration: 0.3) {
            self.position = destinationPoint
        }
    }
    
    private func stopPieceAnimation() {
        let midAngle = (startAngle + endAngle) / 2
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
