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
    fileprivate var radiusRate: CGFloat?
    
    var data: CSPieChartData?
    
    init(frame: CGRect, startAngle: CGFloat, endAngle: CGFloat, data: CSPieChartData, color: UIColor, radiusRate: CGFloat) {
        super.init(frame: frame)
        
        self.data = data
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.backgroundColor = color
        self.radiusRate = radiusRate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        var radius: CGFloat = 0
        
        if frame.width >= frame.height {
            radius = (frame.height / 2) * self.radiusRate!
        } else {
            radius = (frame.width / 2) * self.radiusRate!
        }
        
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
    func startSpreadAnimation() {
        self.radiusRate = 0.8
        setNeedsDisplay()
    }
    
    func stopSpreadAnimation() {
        
    }
}
