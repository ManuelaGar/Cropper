//
//  CropViewController.swift
//  Cropper
//
//  Created by Manuela Garcia on 6/08/18.
//  Copyright © 2018 Manuela Garcia. All rights reserved.
//

import IGRPhotoTweaks
import UIKit

//extension CGImage {
//    let aspect: CGFloat = cropSize.height / cropSize.width
//    let outputSize = CGSize(width: outputWidth, height: (outputWidth * aspect))
//
//    print("outputSize w \(outputSize.width)")
//    print("outputSize h \(outputSize.height)")
//    print("cropSize w \(cropSize.width)")
//    print("cropSize h \(cropSize.height)")
//}

extension IGRPhotoTweakViewController {
    
    public func pixels(marker: Float) -> (mmxPixelX: Float, mmxPixelY: Float) {
        var transform = CGAffineTransform.identity
        // translate
        let translation: CGPoint = self.photoView.photoTranslation
        transform = transform.translatedBy(x: translation.x, y: translation.y)
        // scale
        
        let t: CGAffineTransform = self.photoView.photoContentView.transform
        let xScale: CGFloat = sqrt(t.a * t.a + t.c * t.c)
        let yScale: CGFloat = sqrt(t.b * t.b + t.d * t.d)
        transform = transform.scaledBy(x: xScale, y: yScale)
        
        print(xScale)
        print(yScale)
        print("Transform \(transform)")
        
        let pixelsXInCroppedImage = Float(image.size.width/xScale)
        let pixelsYInCroppedImage = Float(image.size.height/yScale)
        
        let mmPorPixelX = Float(marker/pixelsXInCroppedImage)
        let mmPorPixelY = Float(marker/pixelsYInCroppedImage)
        
        print("Pixels x: \(pixelsXInCroppedImage), mm por pixel: \(mmPorPixelX)")
        print("Pixels y: \(pixelsYInCroppedImage), mm por pixel: \(mmPorPixelY)")
        
        return (mmPorPixelX, mmPorPixelY)
    }
    
    public func mmEnImagenCortada(mmxPixelX: Float, mmxPixelY: Float) -> (mmTotalesX: Float, mmTotalesX: Float) {
        var transform = CGAffineTransform.identity
        // translate
        let translation: CGPoint = self.photoView.photoTranslation
        transform = transform.translatedBy(x: translation.x, y: translation.y)
        let t: CGAffineTransform = self.photoView.photoContentView.transform
        let xScale: CGFloat = sqrt(t.a * t.a + t.c * t.c)
        let yScale: CGFloat = sqrt(t.b * t.b + t.d * t.d)
        
        let pixelsInCroppedImageX = Float(image.size.width/xScale)
        let pixelsInCroppedImageY = Float(image.size.height/yScale)
        
        var mmTotalesX: Float = 0
        var mmTotalesY: Float = 0
        
        let aspect = UserDefaults.standard.float(forKey: "aspect")
        
        if aspect < 1 {
            mmTotalesX = pixelsInCroppedImageX * mmxPixelX
            mmTotalesY = mmTotalesX*aspect
        } else if aspect == 1 {
            mmTotalesX = pixelsInCroppedImageX * mmxPixelX
            mmTotalesY = mmTotalesX
            //pixelsInCroppedImageY * mmxPixelX
        } else {
            mmTotalesY = pixelsInCroppedImageY * mmxPixelX
            mmTotalesX = mmTotalesY/aspect
        }
        
        UserDefaults.standard.set(mmTotalesX, forKey:"mmEnX")
        print(mmTotalesX)
        UserDefaults.standard.set(mmTotalesY, forKey:"mmEnY")
        print(mmTotalesY)
        
        print("translation \(translation)")
        print("xScale \(xScale)")
        print("yScale \(yScale)")
        print("height \(image.size.height)")
        print("width \(image.size.width)")
        print(pixelsInCroppedImageX)
        print(pixelsInCroppedImageY)
        
//        print(self.photoView.cropView.frame.size.width)
//        print(self.photoView.cropView.frame.size.height)
//        print("aspect2 \(aspect)")
        return (mmTotalesX, mmTotalesY)
    }
}

class CropViewController: IGRPhotoTweakViewController {

//    @IBOutlet weak fileprivate var angleSlider: UISlider?
//    @IBOutlet weak fileprivate var angleLabel: UILabel?
 
    //var vc = ViewController(nibName: "ViewController", bundle: nil)
    var tap1 = 0
    var medidaText = ""
    var mmPorPixelX: Float = 0
    var mmPorPixelY: Float = 0
    var mmX: Float = 0
    var mmY: Float = 0
    
    let marcador: Float = 30.0
    
    // MARK: - Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCropAspectRect(aspect: "1:1")
        
        //self.setupSlider()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //FIXME: Themes Preview
    override open func setupThemes() {
        
        //        IGRCropLine.appearance().backgroundColor = UIColor.green
        //        IGRCropGridLine.appearance().backgroundColor = UIColor.yellow
        //        IGRCropCornerView.appearance().backgroundColor = UIColor.purple
        //        IGRCropCornerLine.appearance().backgroundColor = UIColor.orange
        //        IGRCropMaskView.appearance().backgroundColor = UIColor.blue
        //        IGRPhotoContentView.appearance().backgroundColor = UIColor.gray
        //        IGRPhotoTweakView.appearance().backgroundColor = UIColor.brown
    }
    
//    fileprivate func setupSlider() {
//        self.angleSlider?.minimumValue = -Float(IGRRadianAngle.toRadians(45))
//        self.angleSlider?.maximumValue = Float(IGRRadianAngle.toRadians(45))
//        self.angleSlider?.value = 0.0
//
//        setupAngleLabelValue(radians: CGFloat((self.angleSlider?.value)!))
//    }
    
//    fileprivate func setupAngleLabelValue(radians: CGFloat) {
//        let intDegrees: Int = Int(IGRRadianAngle.toDegrees(radians))
//        self.angleLabel?.text = "\(intDegrees)°"
//    }
    
    // MARK: - Rotation
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context) in
            self.view.layoutIfNeeded()
        }) { (context) in
            //
        }
    }
    
    // MARK: - Actions
    
//    @IBAction func onChandeAngleSliderValue(_ sender: UISlider) {
//        let radians: CGFloat = CGFloat(sender.value)
//        setupAngleLabelValue(radians: radians)
//        self.changedAngle(value: radians)
//
//    }
    
//    @IBAction func onEndTouchAngleControl(_ sender: UIControl) {
//        self.stopChangeAngle()
//    }
    
    @IBAction func cancelBtn(_ sender: UIBarButtonItem) {
        self.dismissAction()
    }
    
    @IBAction func resetBtn(_ sender: UIBarButtonItem) {
        self.resetView()
    }
    
    @IBAction func cropBtn(_ sender: UIBarButtonItem) {
        cropAction()
        print("\(self.tap1)")
        if self.tap1 == 0 {
            let pixelsEnImagenCortada = pixels(marker: marcador)
            self.mmPorPixelX = pixelsEnImagenCortada.0
            self.mmPorPixelY = pixelsEnImagenCortada.1
            UserDefaults.standard.set(self.mmPorPixelX, forKey: "mmPPX")
            UserDefaults.standard.set(self.mmPorPixelY, forKey: "mmPPY")
            print("Los mm en un pixel en x son \(self.mmPorPixelX) y en y son \(self.mmPorPixelY)")
        } else {
            let mmPPX = UserDefaults.standard.float(forKey: "mmPPX")
            let mmPPY = UserDefaults.standard.float(forKey: "mmPPY")
            print("Los mm en un pixel en x son \(mmPPX) y en y son \(mmPPY)")
            
            let mmEnImagen = mmEnImagenCortada(mmxPixelX: mmPPX, mmxPixelY: mmPPY)
            self.mmX = mmEnImagen.0
            self.mmY = mmEnImagen.1
            
            print("Los mm x: \(mmX), y son: \(mmY)")
        
            UserDefaults.standard.set(mmX, forKey:"mmEnX")
            UserDefaults.standard.set(mmY, forKey:"mmEnY")
        }
    }
    
//    @IBAction func aspectBtn(_ sender: UIBarButtonItem) {
//        let actionSheet = UIAlertController(title: nil,
//                                            message: nil,
//                                            preferredStyle: .actionSheet)
//        
//        
////        actionSheet.addAction(UIAlertAction(title: "Original", style: .default) { (action) in
////            self.resetAspectRect()
////        })
//        
//        actionSheet.addAction(UIAlertAction(title: "Square", style: .default) { (action) in
//            self.setCropAspectRect(aspect: "1:1")
//        })
//        
////        actionSheet.addAction(UIAlertAction(title: "2:3", style: .default) { (action) in
////            self.setCropAspectRect(aspect: "2:3")
////        })
////
////        actionSheet.addAction(UIAlertAction(title: "3:5", style: .default) { (action) in
////            self.setCropAspectRect(aspect: "3:5")
////        })
////
////        actionSheet.addAction(UIAlertAction(title: "3:4", style: .default) { (action) in
////            self.setCropAspectRect(aspect: "3:4")
////        })
////
////        actionSheet.addAction(UIAlertAction(title: "5:7", style: .default) { (action) in
////            self.setCropAspectRect(aspect: "5:7")
////        })
////
////        actionSheet.addAction(UIAlertAction(title: "9:16", style: .default) { (action) in
////            self.setCropAspectRect(aspect: "9:16")
////        })
//        
//        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        
//        present(actionSheet, animated: true, completion: nil)
//    }

}
