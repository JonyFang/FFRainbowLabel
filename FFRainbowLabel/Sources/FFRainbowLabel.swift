//
//  FFRainbowLabel.swift
//  FFRainbowLabel
//
//  Created by JonyFang on 2018/2/24.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

import UIKit

public enum FFillOption {
    case Background
    case Text
}

open class FFRainbowLabel: UILabel {
    open var gradientColors: [UIColor]?
    open var gradientLocations: [CGFloat]?
    open var startPoint: CGPoint?
    open var endPoint: CGPoint?
    open var fillColor: UIColor = .black
    open var fillOption: FFillOption = .Text
    
    //MARK: - Public Methods
    public init() {
        super.init(frame: .zero)
        configureDefaultTextColor()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureDefaultTextColor()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureDefaultTextColor()
    }
    
    open override func drawText(in rect: CGRect) {
        super.drawText(in: rect)
        
        let context = UIGraphicsGetCurrentContext()
        
        defer {
            context?.restoreGState()
        }
        
        guard let mask = context?.mask(with: fillOption) else {
            return
        }
        
        context?.saveGState()
        context?.concatenate(CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: rect.height))
        context?.clear(rect)
        context?.clip(to: rect, mask: mask)
        
        guard let colorComponents = colorComponents else {
            context?.fill(rect, with: fillColor)
            return
        }
        
        let startPoint = self.startPoint ?? CGPoint(x: rect.minX, y: rect.minY)
        let endPoint = self.endPoint ?? CGPoint(x: rect.maxX, y: rect.maxY)
        
        context?.concatenate(CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: rect.height))
        context?.drawGradient(colorComponents: colorComponents, locations: gradientLocations, startPoint: startPoint, endPoint: endPoint)
    }
    
    //MARK: - Private Methods
    fileprivate func configureDefaultTextColor() {
        textColor = .white
    }
    
    fileprivate var colorComponents: [CGFloat]? {
        get {
            guard let colors = gradientColors, colors.count > 0 else {
                return nil
            }
            
            var colorComponents = [CGFloat]()
            
            for color in colors {
                var red: CGFloat = 0.0
                var green: CGFloat = 0.0
                var blue: CGFloat = 0.0
                var alpha: CGFloat = 0.0
                
                color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                colorComponents += [red, green, blue, alpha]
            }
            
            if colorComponents.count <= 4 {
                colorComponents += colorComponents
            }
            
            return colorComponents
        }
    }
}
