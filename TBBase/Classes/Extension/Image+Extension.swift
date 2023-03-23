//
//  Image.swift
//  lib_basic
//
//  Created by syc on 2021/1/27.
//  Copyright © 2021 lubansoft. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    
    /// svg加载图片
    /// - Parameters:
    ///   - name: svg的名字
    ///   - bundle: bundle
    ///   - size: 大小
    /// - Returns: UIImage
    static func svgImageNamed(_ name: String, _ bundle: Bundle, _ size: CGSize) -> UIImage{
        let image: SVGKImage = SVGKImage(named: name, in: bundle)
        image.size = size
        return image.uiImage
    }
    
    /// svg加载图片
    /// - Parameters:
    ///   - name: svg完整名字
    ///   - bundle: bundle
    ///   - size: size
    ///   - tintColor: 颜色
    /// - Returns: uiimage
    static func svgImageNamed(_ name: String, _ bundle: Bundle, _ size: CGSize, _ tintColor: UIColor) -> UIImage {
        let svgImage: SVGKImage = SVGKImage(named: name, in: bundle)
        svgImage.size = size
        svgImage.fillColor(color: tintColor, opacity: 1.0)
        return svgImage.uiImage
    }
    
}


extension SVGKImage {
    func fillColor(color: UIColor, opacity: Float) {
        if let layer = caLayerTree {
            fillColorForSubLayer(layer: layer, color: color, opacity: opacity)
        }
    }
    private func fillColorForSubLayer(layer: CALayer, color: UIColor, opacity: Float) {
        if layer is CAShapeLayer {
            let shapeLayer = layer as! CAShapeLayer
            shapeLayer.fillColor = color.cgColor
            shapeLayer.opacity = opacity
        }
        
        if let sublayers = layer.sublayers {
            for subLayer in sublayers {
                fillColorForSubLayer(layer: subLayer, color: color, opacity: opacity)
            }
        }
    }
}
