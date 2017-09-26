//
//  ViewController.swift
//  ImageLab
//
//  Created by Eric Larson
//  Copyright © 2016 Eric Larson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var imageView: UIImageView!
    var filter : CIFilter! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlPath = Bundle.main.path(forResource: "smu-campus", ofType: "jpg")
        let fileURL = NSURL.fileURL(withPath: urlPath!)
        
        let beginImage = CIImage(contentsOf: fileURL)
        
        filter = CIFilter(name: "CIBloom")!
        filter.setValue(beginImage, forKey: kCIInputImageKey)
        filter.setValue(0.5, forKey: kCIInputIntensityKey)
        filter.setValue(20, forKey: "inputRadius")
        
        let newImage = UIImage(ciImage: filter.outputImage!)
        self.imageView.image = newImage
    
    }
    
    
    @IBAction func loadImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        
        let image = info["UIImagePickerControllerOriginalImage"] as! UIImage
        let beginImage = CIImage(image: image)
        filter.setValue(beginImage, forKey: kCIInputImageKey)
        let newImage = UIImage(ciImage: filter.outputImage!, scale: CGFloat(1.0), orientation: image.imageOrientation)
        self.imageView.image = newImage
        
    }

}

