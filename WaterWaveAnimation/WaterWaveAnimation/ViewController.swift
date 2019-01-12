//
//  ViewController.swift
//  WaterWaveAnimation
//
//  Created by J K on 2019/1/12.
//  Copyright © 2019 Kims. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var secondView: SecondView?
    private var display: CADisplayLink!
    
    private var isClick: Bool = false
    
    private var btn: UIButton!
    
    //隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = #colorLiteral(red: 1, green: 0.7028968267, blue: 0.487562094, alpha: 1)
        
        //配置按钮
        btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        btn.center = CGPoint(x: self.view.center.x, y: self.view.frame.height - 100)
        btn.setTitle("Pause", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.setTitleColor(#colorLiteral(red: 1, green: 0.7028968267, blue: 0.487562094, alpha: 1), for: .normal)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = #colorLiteral(red: 1, green: 0.3862727072, blue: 0.4121730719, alpha: 1)
        btn.addTarget(self, action: #selector(ViewController.buttonClick), for: .touchUpInside)
        self.view.addSubview(btn)
        
        secondView = SecondView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 160, height: self.view.frame.height/2 - 30))
        secondView!.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
        self.view.addSubview(secondView!)
        
        display = CADisplayLink(target: self, selector: #selector(ViewController.displayFunc))
        display.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
    }
    
    //暂停/播放动画按钮
    @objc func buttonClick() {
        if !isClick {
            btn.setTitle("Start", for: .normal)
            display.isPaused = true
            isClick = true
        }else {
            btn.setTitle("Pause", for: .normal)
            display.isPaused = false
            isClick = false
        }
    }
    
    @objc func displayFunc() {
        secondView!.waterWave()
    }
    
    deinit {
        display.invalidate()
    }
    
}

