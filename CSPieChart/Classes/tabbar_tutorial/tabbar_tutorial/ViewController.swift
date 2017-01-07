//
//  ViewController.swift
//  tabbar_tutorial
//
//  Created by Youk Chansim on 2017. 1. 7..
//  Copyright © 2017년 Youk Chansim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //  이름 없는 함수형 객체
    var closure: ((Int) -> (String))?
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // nil 값을 갖게할 수 있음.
        // 객체를 한번 더 랩핑한다.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //  Optinal
        //  Closure
        
        closure = test
        
    }
    
    func test(a: Int) -> String {
        return "\(a)"
    }
}

