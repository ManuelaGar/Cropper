//
//  ViewController.swift
//  Cropper
//
//  Created by Manuela Garcia on 6/08/18.
//  Copyright © 2018 Manuela Garcia. All rights reserved.
//

import UIKit
import IGRPhotoTweaks

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageMeasure: UIImageView!
    
    @IBOutlet weak var editItem: UIBarButtonItem!
    @IBOutlet weak var libraryItem: UIBarButtonItem!
    
    @IBOutlet weak var medidaLabel: UILabel!
    fileprivate var image: UIImage!
    
    var imageWasTapped = false
    var tap = 0
    var mmPerPixelCtant: CGFloat = 0
    //var text:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //medidaLabel?.text = text
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (self.image == nil) {
            openLibrary()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc1 = segue.destination as! CropViewController
        vc1.tap1 = self.tap
        if segue.identifier == "showCrop" {
            let exampleCropViewController = segue.destination as! CropViewController
            exampleCropViewController.image = sender as! UIImage
            exampleCropViewController.delegate = self
        }
    }
    
    // MARK: - Funcs
    
    @objc func openLibrary() {
        let pickerView = UIImagePickerController.init()
        pickerView.delegate = self
        pickerView.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(pickerView, animated: true, completion: nil)
    }
    
    
    @IBAction func openLibraryPressed(_ sender: UIBarButtonItem) {
        let pickerView = UIImagePickerController.init()
        pickerView.delegate = self
        pickerView.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(pickerView, animated: true, completion: nil)
    }
    
    func edit(image: UIImage) {
        self.performSegue(withIdentifier: "showCrop", sender: image)
    }
    
    @IBAction func editPressed(_ sender: UIBarButtonItem) {
        self.edit(image: self.image)
    }
    
    @IBAction func imageClicked(_ sender: Any){
        print("image tapped")
        imageWasTapped = true
        self.tap = 1
        print("\(imageWasTapped)")
        self.performSegue(withIdentifier: "showCrop", sender: image)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        self.image = image
        let imageSize1 = image.size
        let imageWidth: CGFloat = image.size.width
        let imageHeight: CGFloat = image.size.height
        
        print("Original Image")
        print(imageSize1)
        print(imageWidth)
        print(imageHeight)
        
        picker.dismiss(animated: true) {
            self.edit(image: image)
        }
    }
}

extension ViewController: IGRPhotoTweakViewControllerDelegate {
    func photoTweaksController(_ controller: IGRPhotoTweakViewController, didFinishWithCroppedImage croppedImage: UIImage) {
        let mmX = UserDefaults.standard.float(forKey: "mmEnX")
        let mmY = UserDefaults.standard.float(forKey: "mmEnY")
        if imageWasTapped == true {
            imageWasTapped = false
            self.imageMeasure?.image = croppedImage
            medidaLabel?.text = "mmX: \(mmX) y mmY: \(mmY)"
        } else {
            self.imageView?.image = croppedImage
        }
        
        _ = controller.navigationController?.popViewController(animated: true)
    }
    
    func photoTweaksControllerDidCancel(_ controller: IGRPhotoTweakViewController) {
        _ = controller.navigationController?.popViewController(animated: true)
    }
}

