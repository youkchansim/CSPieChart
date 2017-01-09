//
//  CSPieChartViewController.swift
//  Pods
//
//  Created by Youk Chansim on 2017. 1. 5..
//
//

import UIKit

public class CSPieChartViewController: UIViewController {
    
    public var dataSource: CSPieChartDataSource?
    public var delegate: CSPieChartDelegate?
    
    //  Pie chart radius rate that is percentage of frames in the superview
    public var pieChartRadiusRate: CGFloat = 0.7
    
    // Pie chart line length between component and subview
    public var pieChartLineLength: CGFloat = 10
    
    // If this is true, component is animated when it is selected
    public var isSelectedAnimation: Bool = false
    
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
                if let data = dataSource?.pieChartComponentData(at: IndexPath(item: index, section: 0)) {
                    sum += data.value
                }
            }
            
            var startAngle: CGFloat = 0
            
            if itemCount > 0 {
                let indexPathForRandomStartAngle = IndexPath(item: 0, section: 0)
                if let data = dataSource?.pieChartComponentData(at: indexPathForRandomStartAngle) {
                    startAngle = (sum / data.value).toRadian
                }
            }
            
            for index in 0..<itemCount {
                let indexPath = IndexPath(item: index, section: 0)
                if let data = dataSource?.pieChartComponentData(at: indexPath) {
                    let degree: Double = data.value / sum * 360
                    let endAngle = startAngle + degree.toRadian
                    
                    let componentColorsCount = dataSource?.numberOfComponentColors() ?? 0
                    let compoenetColorIndexPath = IndexPath(item: index % componentColorsCount, section: 0)
                    let componentColor = dataSource?.pieChartComponentColor(at: compoenetColorIndexPath) ?? UIColor.white
                    let component = CSPieChartComponent(frame: pieChartFrame, startAngle: startAngle, endAngle: endAngle, data: data, color: componentColor, radiusRate: self.pieChartRadiusRate)
                    component.indexPath = indexPath
                    
                    let lineColorsCount = dataSource?.numberOfLineColors?() ?? 0
                    let lineColorIndexPath = IndexPath(item: index % lineColorsCount, section: 0)
                    let lineColor = dataSource?.pieChartLineColor?(at: lineColorIndexPath) ?? UIColor.black
                    
                    if let subViewsCount = dataSource?.numberOfComponentSubViews?() {
                        let subViewIndexPath = IndexPath(item: index % subViewsCount, section: 0)
                        let subView = dataSource?.pieChartComponentSubView?(at: subViewIndexPath) ?? UIView()
                        let foregroundView = CSPieChartForegroundView(frame: pieChartFrame, startAngle: startAngle, endAngle: endAngle, lineColor: lineColor, radiusRate: self.pieChartRadiusRate, subView: subView, lineLength: self.pieChartLineLength)
                        
                        pieChartView?.addSubview(component)
                        pieChartView?.addSubview(foregroundView)
                    } else {
                        pieChartView?.addSubview(component)
                    }
                    
                    startAngle = endAngle
                }
            }
        }
        
        if let pieChart = pieChartView {
            view.addSubview(pieChart)
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isSelectedAnimation {
            guard let location = touches.first?.location(in: pieChartView) else {
                return
            }
            
            for subView in pieChartView!.subviews {
                if let component = subView as? CSPieChartComponent, let layer = subView.layer.mask as? CAShapeLayer {
                    if let path = layer.path, path.contains(location) {
                        if selectedComponent != component {
                            selectedComponent?.stopPieceAnimation()
                            selectedComponent = nil
                        }
                        
                        if !component.isAnimated! {
                            component.startPieceAnimation()
                            selectedComponent = component
                            delegate?.didSelectedPieChartComponent?(at: component.indexPath!)
                        } else {
                            component.stopPieceAnimation()
                            selectedComponent = nil
                        }
                        
                        return
                    }
                }
            }
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let component = selectedComponent, let location = touches.first?.location(in: component) else { return }
        if let layer = component.layer.mask as? CAShapeLayer, let path = layer.path, !path.contains(location) {
            selectedComponent?.stopPieceAnimation()
            selectedComponent = nil
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedComponent?.stopPieceAnimation()
        selectedComponent = nil
    }
}
