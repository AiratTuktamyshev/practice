//
//  ImageDetailViewController.swift
//  MediaSoft
//
//  Created by Айрат Туктамышев on 01/07/2019.
//  Copyright © 2019 Айрат Туктамышев. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController, UIScrollViewDelegate{
    
    
    
    @IBAction func BackB(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
    @IBOutlet weak var ScrollVIEW: UIScrollView!
    @IBOutlet weak var backimage: UIImageView!{
        didSet
        {
            let url = URL(string: imageinfo! )
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                
                DispatchQueue.main.async {
                    self.backimage.image = UIImage(data: data!)
                }
            }
        }
    }
    
    
    var imageinfo: String?
    
    
    override func viewDidLoad() {
        ScrollVIEW.delegate=self
        self.ScrollVIEW.minimumZoomScale = 1.0
        self.ScrollVIEW.maximumZoomScale = 6.0
        
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Title", style: .plain, target: self, action: #selector(backAction))
        
        // Do any additional setup if required.
    }
    
    @objc func backAction(){
        //print("Back Button Clicked")
        dismiss(animated: true, completion: nil)
    }

    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.backimage
    }
    
}
