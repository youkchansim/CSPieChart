//
//  CSPieChartComponent.swift
//  Pods
//
//  Created by Youk Chansim on 2017. 1. 5..
//
//

import UIKit

class CSPieChartComponent: UIView {

    fileprivate var startAngle: CGFloat?
    fileprivate var endAngle: CGFloat?
    fileprivate var data: CSPieChartData?
    
    init(frame: CGRect, startAngle: CGFloat, endAngle: CGFloat, data: CSPieChartData, color: UIColor) {
        super.init(frame: frame)
        
        self.data = data
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.backgroundColor = color
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(gesture:)))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let radius = (frame.width / 2) * 0.7
        
        let arcPath = UIBezierPath()
        arcPath.move(to: center)
        arcPath.addArc(withCenter: center, radius: radius, startAngle: startAngle!, endAngle: endAngle!, clockwise: true)
        arcPath.close()
        
        let mask = CAShapeLayer()
        mask.path = arcPath.cgPath
        layer.mask = mask
    }
}

extension CSPieChartComponent {
    func tapGesture(gesture: UIGestureRecognizer) {
        let touchLocation = gesture.location(in: self)
        if let shapeLayer = layer.mask?.hitTest(touchLocation) as? CAShapeLayer { // If you hit a layer and if its a Shapelayer
            if shapeLayer.path!.contains(touchLocation) { // Optional, if you are inside its content path
                print(data!.title)
            }
        }
    }
}

class CSPieChartForegroundView: UIView {
    fileprivate var startAngle: CGFloat?
    fileprivate var endAngle: CGFloat?
    
    init(frame: CGRect, startAngle: CGFloat, endAngle: CGFloat, color: UIColor) {
        super.init(frame: frame)
        
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let radius = (frame.width / 2) * 0.7
        
        let linePath = UIBezierPath()
        let midAngle = (startAngle! + endAngle!) / 2
        
        let startPoint = CGPoint(x: center.x + cos(midAngle) * (radius - 10), y: center.y + sin(midAngle) * (radius - 10))
        let turningPoint = CGPoint(x: center.x + cos(midAngle) * (radius + 10), y: center.y + sin(midAngle) * (radius + 10))
        let isEndPointLeft = turningPoint.x<center.x
        let endPoint = CGPoint(x: turningPoint.x + (isEndPointLeft ? -1 : 1) * 10, y: turningPoint.y)
        
        linePath.move(to: startPoint)
        linePath.addLine(to: turningPoint)
        linePath.addLine(to: endPoint)
        
        linePath.stroke()
    }
}
