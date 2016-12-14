//
//  DetailViewController.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/13/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet weak var nameField: ItemDetailTextField!
  @IBOutlet weak var serialNumberField: ItemDetailTextField!
  @IBOutlet weak var valueField: ItemDetailTextField!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  
  // MARK: Actions
  @IBAction func takePicture(_ sender: UIBarButtonItem) {
    
    let imagePicker = UIImagePickerController()
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      imagePicker.sourceType = .camera
    } else {
      imagePicker.sourceType = .photoLibrary
    }
    
    imagePicker.delegate = self
    
    imagePicker.allowsEditing = true
    
    present(imagePicker, animated: true, completion: nil)
  }
  
  @IBAction func removePhotoButtonTapped(_ sender: UIBarButtonItem) {
    imageStore.deleteImage(forKey: item.itemKey)
    imageView.image = nil
  }
  
  @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
    view.endEditing(true)
  }
  
  // MARK: Properties
  var item: Item! {
    didSet {
      navigationItem.title = item.name
    }
  }
  
  var imageStore: ImageStore!
  
  let numberFormatter: NumberFormatter = {
    let nf = NumberFormatter()
    nf.numberStyle = .decimal
    nf.minimumFractionDigits = 2
    nf.maximumFractionDigits = 2
    return nf
  }()
  
  let dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateStyle = .medium
    df.timeStyle = .none
    return df
  }()
  
}

// MARK: - View Life Cycle
extension DetailViewController {
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    nameField.text = item.name
    serialNumberField.text = item.serialNumber
    valueField.text =
      numberFormatter.string(from: item.valueInDollars as NSNumber)
    dateLabel.text =
      dateFormatter.string(from: item.dateCreated)
    imageView.image =
      imageStore.image(forKey: item.itemKey)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    view.endEditing(true)
    
    item.name = nameField.text ?? ""
    item.serialNumber = serialNumberField.text
    
    if let valueText = valueField.text,
      let value = numberFormatter.number(from: valueText) {
      item.valueInDollars = value.intValue
    } else {
      item.valueInDollars = 0
    }
  }
}

// MARK: - UITextFieldDelegate
extension DetailViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

// MAR: - UIImagePickerControllerDelegate
extension DetailViewController:
  UINavigationControllerDelegate,
  UIImagePickerControllerDelegate {
  
  func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [String : Any]) {
    
    let image = info[UIImagePickerControllerOriginalImage] as! UIImage
    imageStore.setImage(image, forKey: item.itemKey)
    
    dismiss(animated: true, completion: nil)
  }
  
}
