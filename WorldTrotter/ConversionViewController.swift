//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Qiao Zhang on 12/10/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet weak var celsiusLabel: UILabel!
  @IBOutlet weak var textField: UITextField!
  
  // MARK: Actions
  @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
    if let text = textField.text,
       let number = numberFormatter.number(from: text) {
      fahrenheitValue = Measurement(value: number.doubleValue,
                                    unit: .fahrenheit)
    } else {
      fahrenheitValue = nil
    }
  }
  
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    textField.resignFirstResponder()
  }
  
  // MARK: properties
  private var fahrenheitValue: Measurement<UnitTemperature>? {
    didSet {
      updateCelsiusLabel()
    }
  }
  
  private var celsiusValue: Measurement<UnitTemperature>? {
    if let fahrenheitValue = fahrenheitValue {
      return fahrenheitValue.converted(to: .celsius)
    } else {
      return nil
    }
  }
  
  private let numberFormatter: NumberFormatter = {
    let nf = NumberFormatter()
    nf.numberStyle = .decimal
    nf.minimumFractionDigits = 0
    nf.maximumFractionDigits = 1
    return nf
  } ()
  
  fileprivate func updateCelsiusLabel() {
    if let celsiusValue = celsiusValue {
      celsiusLabel.text =
        numberFormatter.string(from: celsiusValue.value as NSNumber)
    } else {
      celsiusLabel.text = "???"
    }
  }
}

extension ConversionViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    updateCelsiusLabel()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let hour = Calendar.current.component(.hour, from: Date())
    if hour > 18 || hour < 6 {
      view.backgroundColor = UIColor.darkGray
    }
  }
}

extension ConversionViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    
    let currentLocale = Locale.current
    let decimalSeparator = currentLocale.decimalSeparator ?? "."
    
    let existingTextHasDecimalSeparator =
      textField.text?.range(of: decimalSeparator)
    let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
    
    if let _ = existingTextHasDecimalSeparator,
      let _ = replacementTextHasDecimalSeparator {
      return false
    }
    
    let letters = NSCharacterSet.letters
    let range = string.rangeOfCharacter(from: letters)
    
    if let _ = range { return false }
    
    return true
  }
}
