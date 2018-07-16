//
//  ViewController.swift
//  DOR
//
//  Created by Muhammad Ali on 06/05/2018.
//  Copyright © 2018 Muhammad Ali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var string  = ""
    @IBOutlet weak var imv: UIImageView!
    var imagee = UIImage()
    @IBOutlet weak var views : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        networking.loadimage(string) { (image) in
            DispatchQueue.main.async {
                self.imv.image = image
               self.imagee = image
            }
            
        }
        views.layer.cornerRadius = 10
        views.backgroundColor = .gray
    }
    @IBAction func save(){
        UIImageWriteToSavedPhotosAlbum(imagee, nil, nil, nil)
        UIView.animate(withDuration: 0.5) {
            self.views.isHidden = false
            self.view.layoutIfNeeded()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
