//
//  SecondView.swift
//  WaterWaveAnimation
//
//  Created by J K on 2019/1/12.
//  Copyright © 2019 Kims. All rights reserved.
//

import UIKit

class SecondView: UIView {

    private var size: CGSize!
    
    private var heightOfWave: CGFloat = 5 //波纹高度
    private var rateOfWave: CGFloat = 0.01 //宽度系数
    private var waveOffset: CGFloat = 0 //移速
    
    private var waveBezier: UIBezierPath!
    private var waveBezier2: UIBezierPath!
    
    private var waveShape: CAShapeLayer!
    private var waveShape2: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.size = frame.size
        self.backgroundColor = UIColor.clear
        
        //配置第一个波纹
        waveShape = CAShapeLayer()
        waveShape.frame = CGRect(x: 0, y: size.height/2 - 20, width: size.width, height: 10)
        waveShape.backgroundColor = UIColor.clear.cgColor
        
        //配置第二个波纹
        waveShape2 = CAShapeLayer()
        waveShape2.frame = CGRect(x: 0, y: size.height/2 - 20, width: size.width, height: 10)
        waveShape2.backgroundColor = UIColor.clear.cgColor
        
        self.layer.addSublayer(theWater())
        self.layer.addSublayer(waterWave().1)
        self.layer.addSublayer(waterWave().0)
        self.layer.addSublayer(cupBody())
    }

    //水杯body
    func cupBody() -> CAShapeLayer {
        let cupBezier = UIBezierPath()
        cupBezier.move(to: CGPoint(x: 0, y: 0))
        cupBezier.addLine(to: CGPoint(x: 0, y: size.height))
        cupBezier.addLine(to: CGPoint(x: size.width, y: size.height))
        cupBezier.addLine(to: CGPoint(x: size.width, y: 0))
        
        let cupShape = CAShapeLayer()
        cupShape.lineWidth = 7
        cupShape.strokeColor = UIColor.white.cgColor
        cupShape.fillColor = UIColor.clear.cgColor
        cupShape.lineCap = .round
        cupShape.lineJoin = .round
        cupShape.path = cupBezier.cgPath
        
        return cupShape
    }
    
    //水
    func theWater() -> CAShapeLayer {
        let waterBezier = UIBezierPath(rect: CGRect(x: 0, y: size.height/2 - 10, width: size.width, height: size.height/2 + 10))
        
        let waterShape = CAShapeLayer()
        waterShape.fillColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        waterShape.path = waterBezier.cgPath
        
        return waterShape
    }
    
    //水的波浪
    func waterWave() -> (CAShapeLayer, CAShapeLayer) {
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        waveOffset += 0.01
        
        waveBezier = UIBezierPath()
        waveBezier.move(to: CGPoint(x: 0, y: size.height/2 - 10))
        
        waveBezier2 = UIBezierPath()
        waveBezier2.move(to: CGPoint(x: 0, y: size.height/2 - 10))
        
        while x <= size.width {
            y = heightOfWave * sin(x * rateOfWave + waveOffset)
            waveBezier.addLine(to: CGPoint(x: x, y: y))
            waveBezier2.addLine(to: CGPoint(x: x, y: -y))
            x += 0.1
        }
        waveBezier.addLine(to: CGPoint(x: size.width, y: 10))
        waveBezier.addLine(to: CGPoint(x: 0, y: 10))
        waveBezier.close()
        
        waveBezier2.addLine(to: CGPoint(x: size.width, y: 10))
        waveBezier2.addLine(to: CGPoint(x: 0, y: 10))
        waveBezier2.close()
        
        waveShape.path = waveBezier.cgPath
        waveShape.fillColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        waveShape2.path = waveBezier2.cgPath
        waveShape2.fillColor = #colorLiteral(red: 0.1375016786, green: 0.3914764667, blue: 0.6023180261, alpha: 1)
        
        return (waveShape, waveShape2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
