# CSPieChart

![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)
[![Version](https://img.shields.io/cocoapods/v/CSPieChart.svg?style=flat)](http://cocoapods.org/pods/CSPieChart)
[![License](https://img.shields.io/cocoapods/l/CSPieChart.svg?style=flat)](http://cocoapods.org/pods/CSPieChart)
![iOS 8.3+](https://img.shields.io/badge/iOS-8.3%2B-blue.svg)
![Swift 4.2+](https://img.shields.io/badge/Swift-4.2%2B-orange.svg)

![](Example/ReadMeResource/gif1.gif)
![](Example/ReadMeResource/gif2.gif)
![](Example/ReadMeResource/gif3.gif)
![](Example/ReadMeResource/gif4.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

CSPieChart is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CSPieChart"
```

## Useage

![](Example/ReadMeResource/view1.png)
![](Example/ReadMeResource/view2.png)
![](Example/ReadMeResource/view3.png)

First Step  - `import CSPieChart` to your project

Second Step - You should `CSPieChartData`. This is model for piechart.
```Swift
  let data = CSPieChartData(key: "test", value: 70)
```

Third Step - Add a delegate `CSPieChartDataSource` & `CSPieChartDelegate` to your class & add two delegate methods 
```Swift
public protocol CSPieChartDataSource {

    ///  Component data
    func numberOfComponentData() -> Int
    func pieChart(_ pieChart: CSPieChart, dataForComponentAt index: Int) -> CSPieChartData

    ///  Component colors
    func numberOfComponentColors() -> Int
    func pieChart(_ pieChart: CSPieChart, colorForComponentAt index: Int) -> UIColor

    ///  If you are implement this, you can show subView. example) 'UIImageView' or 'UILable'
    @objc optional func numberOfComponentSubViews() -> Int
    @objc optional func pieChart(_ pieChart: CSPieChart, viewForComponentAt index: Int) -> UIView

    ///  If you are implement this, you apply color to line path
    ///  Otherwish line color is applied default 'black'
    @objc optional func numberOfLineColors() -> Int
    @objc optional func pieChart(_ pieChart: CSPieChart, lineColorForComponentAt index: Int) -> UIColor
}
```
```Swift
public protocol CSPieChartDelegate {

    /// Component select
    @objc optional func pieChart(_ pieChart: CSPieChart, didSelectComponentAt index: Int)
}
```

You can set some options

```Swift
    //  Pie chart radius rate that is percentage of frames in the superview. default is 0.7
    public var pieChartRadiusRate: CGFloat = 0.7
    
    // Pie chart line length between component and subview. default is 10
    public var pieChartLineLength: CGFloat = 10
    
    //  This is piechart component selecting animation. default is none
    public var seletingAnimationType: SelectingAnimationType = .none
}
```

Last Step - You must call `show`.
### Example
```Swift
  func ViewDidLoad(...) {
      ....
      pieChart.show(animated: true)
  }
```


If you need more information, check example

## Author

chansim.youk, dbrckstla@naver.com

## License

CSPieChart is available under the MIT license. See the LICENSE file for more info.
