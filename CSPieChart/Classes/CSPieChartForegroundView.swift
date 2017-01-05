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
    
    init(frame: CGRect, startAngle: CGFloat, endAngle: CGFloat, color: UIColor, subView: UIView) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.subView = subView
        self.lineColor = color
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
        let isEndPointLeft = turningPoint.x < center.x
        let endPoint = CGPoint(x: turningPoint.x + (isEndPointLeft ? -1 : 1) * 10, y: turningPoint.y)
        
        linePath.move(to: startPoint)
        linePath.addLine(to: turningPoint)
        linePath.addLine(to: endPoint)
        
        lineColor?.setStroke()
        linePath.stroke()
        linePath.close()
        
        let x = subView?.frame.width ?? 0
        if isEndPointLeft {
            subView?.center = CGPoint(x:  endPoint.x - x / 2, y: endPoint.y)
        } else {
            subView?.center = CGPoint(x:  endPoint.x + x / 2, y: endPoint.y)
        }
        
        addSubview(subView!)
    }
}
