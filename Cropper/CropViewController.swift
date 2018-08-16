//
//  CropViewController.swift
//  Cropper
//
//  Created by Manuela Garcia on 6/08/18.
//  Copyright © 2018 Manuela Garcia. All rights reserved.
//

import IGRPhotoTweaks
import UIKit

class CropViewController: IGRPhotoTweakViewController {

//    @IBOutlet weak fileprivate var angleSlider: UISlider?
//    @IBOutlet weak fileprivate var angleLabel: UILabel?
 
    var vc = ViewController(nibName: "ViewController", bundle: nil)
    var tap1 = 0
    var mmPorPixel: Float = 0
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
            print("bbbbb")
            self.mmPorPixel = pixelsX()
            UserDefaults.standard.set(self.mmPorPixel, forKey: "mmPP")
            print("Los mm en un pixel son \(mmPorPixel)")
        } else {
            print("aaaaa")
            print("Los mm en un pixel son \(UserDefaults.standard.float(forKey: "mmPP"))")
            let mmEnImagen = mmEnImagenCortada(mmxPixel: UserDefaults.standard.float(forKey: "mmPP"))
            let mmX = mmEnImagen.0
            let mmY = mmEnImagen.1
//            UserDefaults.standard.set(mmEnImagen, forKey:"mmEnImagen")
            print(mmX)
            print(mmY)
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
