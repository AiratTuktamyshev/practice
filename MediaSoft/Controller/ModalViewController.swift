//
//  ModalViewController.swift
//  MediaSoft
//
//  Created by Айрат Туктамышев on 04/07/2019.
//  Copyright © 2019 Айрат Туктамышев. All rights reserved.
//

import UIKit



protocol FilterProtocol: class {
    
    func SendInfo(category:String, imageType:String, orient:String)
    
}

class ModalViewController: UIViewController {

    var req:JsonReqStr=JsonReqStr()//структура запроса

    weak var delegate:FilterProtocol?
    
    var typeimage:String="all"
    var numcategory:String=" "
    var orientation:String="all"
    
    let category = [" ","fashion", "nature", "backgrounds", "science", "education", "people", "feelings", "religion", "health", "places", "animals", "industry", "food", "computer", "sports", "transportation", "travel", "buildings", "business", "music"]
    
    
    
    @IBOutlet weak var typeimSC: UISegmentedControl!
    
    @IBOutlet weak var orientationSC: UISegmentedControl!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // mydef()
        
        
         // Do any additional setup after loading the view.
    }
    
    
//    private func mydef()
//    {
//        switch req.orientation {
//    case "all":
//        orientationSC.selectedSegmentIndex=0
//    case "horizontal":
//        orientationSC.selectedSegmentIndex=1
//
//    case "vertical":
//        orientationSC.selectedSegmentIndex=2
//
//    default:
//        orientationSC.selectedSegmentIndex=0
//        }
//
//
//        switch req.image_type {
//        case "all":
//            orientationSC.selectedSegmentIndex=0
//        case "vector":
//            orientationSC.selectedSegmentIndex=1
//
//        case "photo":
//            orientationSC.selectedSegmentIndex=2
//        case "illustration":
//            orientationSC.selectedSegmentIndex=3
//
//        default:
//            orientationSC.selectedSegmentIndex=0
//        }
//
//
//        let count = category.count
//
//        for i in 0...count{
//            if req.category==category[i]{
//                pickerView.selectedRow(inComponent: i)
//                break
//            }
//
//        }
//
//
//    }
    @IBAction func cancelButton(_ sender: UIButton) {
        typeimage="all"
        numcategory=" "
        orientation="all"
        delegate?.SendInfo(category: numcategory , imageType: typeimage,orient: orientation)
        dismiss(animated: true, completion: nil)    }
    
    @IBAction func applyButton(_ sender: UIButton) {
        delegate?.SendInfo(category: numcategory , imageType: typeimage,orient: orientation)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func OrientationImage(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            orientation="all"
        case 1:
            orientation="horizontal"
        case 2:
            orientation="vertical"
        default:
            orientation="all"
        }
    }
    @IBAction func TypeImageSegCon(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            typeimage="all"
        case 1:
            typeimage="photo"
        case 2:
            typeimage="vector"
        case 3:
            typeimage="illustration"
        default:
            typeimage=" "
        }
    }
    
    
    
}
    
    
    
    
extension ModalViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return category[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         numcategory = category[row]
    }
        
        
    }


