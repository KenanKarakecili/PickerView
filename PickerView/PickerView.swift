//
//  PickerView.swift
//  PickerView
//
//  Created by Kenan Karakecili on 18/04/16.
//  Copyright © 2016 Kenan Karakecili. All rights reserved.
//

import UIKit

class PickerView: UIView {
  
  let picker = UIPickerView()
  let toolBar = UIToolbar()
  var dataArray = [String]()
  var field: UITextField!
  
  func setPicker() {
    picker.backgroundColor = UIColor.groupTableViewBackgroundColor()
    picker.showsSelectionIndicator = true
    picker.delegate = self
    picker.dataSource = self
    
    toolBar.barStyle = UIBarStyle.Default
    toolBar.tintColor = .blackColor()
    toolBar.sizeToFit()
    
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(PickerView.donePicker))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(PickerView.cancelPicker))
    
    toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolBar.userInteractionEnabled = true
    field.inputView = picker
    field.inputAccessoryView = toolBar
    field.tintColor = UIColor.clearColor()
    
    if field.text?.characters.count > 0 {
      let row = dataArray.indexOf(field.text!)
      picker.selectRow(row!, inComponent: 0, animated: false)
    } else {
      picker.selectRow(0, inComponent: 0, animated: false)
    }
  }
  
  func donePicker(){
    let row = (picker.selectedRowInComponent(0))
    field.text = dataArray[row]
    field.resignFirstResponder()
  }
  
  func cancelPicker(){
    field.resignFirstResponder()
  }
}

extension PickerView: UIPickerViewDataSource, UIPickerViewDelegate {
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return dataArray.count
  }
  
  func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
    let view2 = UIView(frame: CGRectMake(0, 0, 320, 44))
    let label = UILabel(frame: view2.frame)
    label.textAlignment = .Center
    label.text = dataArray[row]
    view2.addSubview(label)
    return view2
  }
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return dataArray[row]
  }
  
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    field.text = dataArray[row]
  }
  
}

class NonPerformField: UITextField {
  
  override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
    return false
  }
  
}
