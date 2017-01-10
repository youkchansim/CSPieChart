//
//  CSPieChartViewController.swift
//  Pods
//
//  Created by Youk Chansim on 2017. 1. 5..
//
//

import UIKit

public enum SelectingAnimationType {
    case none
    case piece
    case scaleUp
    case touch
}

public class CSPieChartViewController: UIViewController {
    
    public var dataSource: CSPieChartDataSource?
    public var delegate: CSPieChartDelegate?
    
    //  Pie chart radius rate that is percentage of frames in the superview
    public var pieChartRadiusRate: CGFloat = 0.7
    
    // Pie chart line length between component and subview
    public var pieChartLineLength: CGFloat = 10
    
    //  This is piechart component selecting animation. default is none
    public var seletingAnimationType: SelectingAnimationType = .none
    
    fileprivate var pieChartView: UIView?
    fileprivate var selectedComponent: CSPieChartComponent?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let width = view.frame.width
        let height = width
        let size = CGSize(width: width, height: height)
        
        let pieChartPoint = CGPoint(x: 0, y: 0)
        let pieChartFrame = CGRect(origin: pieChartPoint, size: size)
        pieChartView = UIView(frame: pieChartFrame)
        
        if let itemCount = dataSource?.numberOfComponentData() {
            
            var sum: Double = 0
            for index in 0..<itemCount {
                if let data = dataSource?.pieChartComponentData(at: index) {
                    sum += data.value
                }
            }
            
            var startAngle: CGFloat = 0
            
            if itemCount > 0 {
                if let data = dataSource?.pieChartComponentData(at: 0) {
                    startAngle = (sum / data.value).toRadian
                }
            }
            
            for index in 0..<itemCount {
                if let data = dataSource?.pieChartComponentData(at: index) {
                    let degree: Double = data.value / sum * 360
                    let endAngle = startAngle + degree.toRadian
                    
                    var componentColor: UIColor?
                    if let componentColorsCount = dataSource?.numberOfComponentColors() {
                        let compoenetColorIndex = index % componentColorsCount
                        componentColor = dataSource?.pieChartComponentColor(at: compoenetColorIndex) ?? .white
                    }
                    
                    var lineColor: UIColor?
                    if let lineColorsCount = dataSource?.numberOfLineColors?() {
                        let lineColorIndex = index % lineColorsCount
                        lineColor = dataSource?.pieChartLineColor?(at: lineColorIndex) ?? .black
                    }
                    
                    var subView: UIView?
                    if let subViewsCount = dataSource?.numberOfComponentSubViews?() {
                        let subViewIndex = index % subViewsCount
                        subView = dataSource?.pieChartComponentSubView?(at: subViewIndex) ?? UIView()
                    }
                    
                    let component = CSPieChartComponent(frame: pieChartFrame, startAngle: startAngle, endAngle: endAngle, data: data, index: index, radiusRate: pieChartRadiusRate)
                    component.componentColor = componentColor
                    component.subView = subView
                    component.lineColor = lineColor
                    component.lineLength = pieChartLineLength
                    
                    pieChartView?.addSubview(component)
                    
                    startAngle = endAngle
                }
            }
        }
        
        if let pieChart = pieChartView {
            view.addSubview(pieChart)
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: pieChartView) else {
            return
        }
        
        pieChartView!.subviews.forEach {
            if let component = $0 as? CSPieChartComponent {
                if component.containsPoint(point: location) {
                    if selectedComponent != component {
                        selectedComponent?.stopAnimation(animationType: seletingAnimationType)
                        selectedComponent = nil
                    }
                    
                    if !component.isAnimated! {
                        component.startAnimation(animationType: seletingAnimationType)
                        selectedComponent = component
                        delegate?.didSelectedPieChartComponent?(at: component.index!)
                    } else {
                        component.stopAnimation(animationType: seletingAnimationType)
                        selectedComponent = nil
                    }
                    
                    return
                }
            }
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let component = selectedComponent, let location = touches.first?.location(in: component) else { return }
        if component.containsPoint(point: location) {
            selectedComponent?.stopAnimation(animationType: seletingAnimationType)
            selectedComponent = nil
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedComponent?.stopAnimation(animationType: seletingAnimationType)
        selectedComponent = nil
    }
}
