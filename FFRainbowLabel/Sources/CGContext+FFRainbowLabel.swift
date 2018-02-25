//
//  CGContext+FFRainbowLabel.swift
//  FFRainbowLabel
//
//  Created by JonyFang on 2018/2/24.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

import UIKit

extension CGContext {
    //MARK: - Public Methods
    func mask(with option: FFillOption) -> CGImage? {
        guard let image = makeImage() else {
            return nil
        }
        
        switch option {
        case .Background:
            guard let imageMask = imageMask(from: image) else {
                return image
            }
            return imageMask
        case .Text:
            return image
        }
    }
    
    func fill(_ rect: CGRect, with color: UIColor) {
        setFillColor(color.cgColor)
        fill(CGRect(x: 0.0, y: 0.0, width: rect.width, height: rect.height))
    }
    
    func drawGradient(colorComponents components: [CGFloat],
                      locations: [CGFloat]?,
                      startPoint: CGPoint,
                      endPoint: CGPoint) {
        guard let gradient = CGGradient(colorSpace: CGColorSpaceCreateDeviceRGB(),
                                        colorComponents: components,
                                        locations: locations,
                                        count: components.count/4) else {
            return
        }
        
        drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
    }
    
    //MARK: - Private Methods
    fileprivate func imageMask(from image: CGImage) -> CGImage? {
        guard
            let dataProvider = image.dataProvider,
            let imageMask = CGImage(maskWidth: image.width,
                                    height: image.height,
                                    bitsPerComponent: image.bitsPerComponent,
                                    bitsPerPixel: image.bitsPerPixel,
                                    bytesPerRow: image.bytesPerRow,
                                    provider: dataProvider,
                                    decode: image.decode,
                                    shouldInterpolate: true) else {
            return nil
        }
        return imageMask
    }
}
