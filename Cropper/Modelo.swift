//
//  Modelo.swift
//  Cropper
//
//  Created by Manuela Garcia on 17/08/18.
//  Copyright © 2018 Manuela Garcia. All rights reserved.
//

import Foundation
import UIKit
import IGRPhotoTweaks

class Modelo {
    var tap = 0
    var medida: Float = 0.0
    var xScale: Float = 0.0
    var yScale: Float = 0.0
    var tamañoMarcador : Float = 30.0
    public var image: UIImage!
    
    init (TamañoMar: Float) {
        tamañoMarcador = TamañoMar
    }
}

//extension IGRPhotoTweakViewController {
//    
//    public func pixels() -> (mmxPixelX: Float, mmxPixelY: Float) {
//        var transform = CGAffineTransform.identity
//        // translate
//        let translation: CGPoint = self.photoView.photoTranslation
//        transform = transform.translatedBy(x: translation.x, y: translation.y)
//        let t: CGAffineTransform = self.photoView.photoContentView.transform
//        let xScale: CGFloat = sqrt(t.a * t.a + t.c * t.c)
//        let yScale: CGFloat = sqrt(t.b * t.b + t.d * t.d)
//        
//        print(xScale)
//        print(yScale)
//        
//        let pixelsXInCroppedImage = Float(image.size.width/xScale)
//        let pixelsYInCroppedImage = Float(image.size.height/yScale)
//        
//        let mmPorPixelX = Float(tamañoMarcador/pixelsXInCroppedImage)
//        let mmPorPixelY = Float(tamañoMarcador/pixelsYInCroppedImage)
//        
//        print("Pixels x: \(pixelsXInCroppedImage), mm por pixel: \(mmPorPixelX)")
//        print("Pixels y: \(pixelsYInCroppedImage), mm por pixel: \(mmPorPixelY)")
//        
//        return (mmPorPixelX, mmPorPixelY)
//    }
//    
//    public func mmEnImagenCortada(mmxPixelX: Float, mmxPixelY: Float) -> (mmTotalesX: Float, mmTotalesX: Float) {
//        var transform = CGAffineTransform.identity
//        // translate
//        let translation: CGPoint = self.photoView.photoTranslation
//        transform = transform.translatedBy(x: translation.x, y: translation.y)
//        let t: CGAffineTransform = self.photoView.photoContentView.transform
//        let xScale: CGFloat = sqrt(t.a * t.a + t.c * t.c)
//        let yScale: CGFloat = sqrt(t.b * t.b + t.d * t.d)
//        
//        let pixelsInCroppedImageX = Float(image.size.width/xScale)
//        let pixelsInCroppedImageY = Float(image.size.height/yScale)
//        
//        let mmTotalesX = pixelsInCroppedImageX * mmxPixelX
//        let mmTotalesY = pixelsInCroppedImageY * mmxPixelY
//        
//        print(xScale)
//        print(yScale)
//        print(pixelsInCroppedImageX)
//        print(pixelsInCroppedImageY)
//        
//        print(mmTotalesX)
//        print(mmTotalesY)
//        UserDefaults.standard.set(mmTotalesX, forKey:"mmEnX")
//        UserDefaults.standard.set(mmTotalesY, forKey:"mmEnY")
//        return (mmTotalesX, mmTotalesY)
//    }
//}
