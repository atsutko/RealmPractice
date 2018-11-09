//
//  AddMemoViewController.swift
//  RealmPractice
//
//  Created by TakaoAtsushi on 2018/10/21.
//  Copyright © 2018 TakaoAtsushi. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import NYXImagesKit

class AddMemoViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate {

    
    let placeholderImage = UIImage(named: "photo-placeholder")
    
    var resizedImage: UIImage!
    
    @IBOutlet weak var memoTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        memoTextField.delegate = self
        detailTextView.delegate = self
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imageView.image = selectedImage
        
        picker.dismiss(animated: true, completion: nil)
        
        confirmContent()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        confirmContent()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
    
    func confirmContent() {
        if detailTextView.text.characters.count > 0 && imageView.image != nil {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }

    @IBAction func selectImage() {
        let alertController = UIAlertController(title: "画像選択", message: "シェアする画像を選択して下さい。", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        let cameraAction = UIAlertAction(title: "カメラで撮影", style: .default) { (action) in
            // カメラ起動
            if UIImagePickerController.isSourceTypeAvailable(.camera) == true {
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            } else {
                print("この機種ではカメラが使用出来ません。")
            }
        }
        
        let photoLibraryAction = UIAlertAction(title: "フォトライブラリから選択", style: .default) { (action) in
            // アルバム起動
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == true {
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            } else {
                print("この機種ではフォトライブラリが使用出来ません。")
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func save() {
        
        let customMemo = CustomMemo.create()
        customMemo.memo = memoTextField.text!
        customMemo.detail = detailTextView.text
        let image = imageView.image
        let resizeImage = image?.scale(byFactor: 0.1)
        customMemo.image = resizeImage
        
        let alertController = UIAlertController(title: "保存",message: "メモを保存します。よろしいですか？", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            customMemo.save()
            self.dismiss(animated: true, completion: nil)
        }
        let cancelButton = UIAlertAction(title: "CANCEL", style: .cancel) { (action) in
            
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelButton)
        present(alertController,animated: true,completion: nil)
    }
    
   

}
