//
//  CameraViewController.swift
//  ThreePercent
//
//  Created by 一ノ瀬琉聖 on 18/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import Alamofire

class CameraViewController: BaseViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var imagePicker : UIImagePickerController!
    @IBOutlet weak var imageView: UIImageView!
    
    
    // MARK : - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK : - IBAction
    @IBAction func takePicture(_ sender: Any) {
        TakePicture()
    }
    
    // MARK : - ImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        
        guard let img = info[.originalImage] as? UIImage else {
            return
        }
        
        imageView.image = img
        
        self.upload(image: img)
        performSegue(withIdentifier: "showSegue", sender: self)
    }
    
    
    
    // MARK : - Alamofire
    func upload(image: UIImage) {
        
        Alamofire.request(requestURL, method: .post).validate().responseJSON { response in
            
            guard response.result.isSuccess else {
                return
            }
            
            guard let value = response.result.value as? [String: Any] else {
                return
            }
            
            guard let id = value["id"] as? String else {
                return
            }
            guard let upload = value["upload"] as? [String: Any] else {
                return
            }
            guard let fields = upload["fields"] as? [[String]] else {
                return
            }
            guard let upload_url = upload["url"] as? String else {
                return
            }
            guard let imgData = image.jpegData(compressionQuality: 90) else {
                return
            }
            
            Alamofire.upload(multipartFormData: {(multipartFormData) in
                for field in fields {
                    let key = field[0], value = field[1]
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
                multipartFormData.append(imgData, withName: "file", mimeType: "image/jpg")
            }, to: upload_url) { (encodingResult) in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.response { response in
                        if let data = response.data {
                            let s = String(data: data, encoding: String.Encoding.utf8)
                        }
//                         self.present(MatchingViewController(), animated: true, completion: nil)
                    }
                case .failure(let encodingError):
                    print("....\(encodingError)")
                }
            }
        }
    }
    
    // MARK : - Private Method
    func TakePicture() {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = .front
        
        present(imagePicker, animated: true, completion: nil)
    }
    
}

