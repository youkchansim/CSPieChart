//
//  CSPieChartForegroundView.swift
//  Pods
//
//  Created by Youk Chansim on 2017. 1. 6..
//
//

import UIKit

class CSPieChartForegroundView: UIView {
    
    fileprivate var startAngle: CGFloat?
    fileprivate var endAngle: CGFloat?
    fileprivate var subView: UIView?
    fileprivate var lineColor: UIColor?
    
    fileprivate var radiusRate: CGFloat?
    fileprivate var lineLength: CGFloat?
    
    init(frame: CGRect, startAngle: CGFloat, endAngle: CGFloat, lineColor: UIColor, radiusRate: CGFloat, subView: UIView, lineLength: CGFloat?) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.lineColor = lineColor
        self.radiusRate = radiusRate
        self.subView = subView
        self.lineLength = lineLength
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let radius = frame.width * radiusRate! / 2
        
        let linePath = UIBezierPath()
        let midAngle = (startAngle! + endAngle!) / 2
        
        let startPoint = CGPoint(x: center.x + cos(midAngle) * (radius - lineLength!), y: center.y + sin(midAngle) * (radius - lineLength!))
        let turningPoint = CGPoint(x: center.x + cos(midAngle) * (radius + lineLength!), y: center.y + sin(midAngle) * (radius + lineLength!))
        let isEndPointLeft = turningPoint.x < center.x
        let endPoint = CGPoint(x: turningPoint.x + (isEndPointLeft ? -1 : 1) * lineLength!, y: turningPoint.y)
        
        linePath.move(to: startPoint)
        linePath.addLine(to: turningPoint)
        linePath.addLine(to: endPoint)
        
        lineColor?.setStroke()
        linePath.stroke()
        linePath.close()
        
        let x = subView?.frame.width ?? 0
        if isEndPointLeft {
            subView?.center = CGPoint(x: endPoint.x - x / 2, y: endPoint.y)
        } else {
            subView?.center = CGPoint(x: endPoint.x + x / 2, y: endPoint.y)
        }
        
        addSubview(subView!)
    }
}
