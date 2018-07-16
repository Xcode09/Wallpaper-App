//
//  CollectionViewCell.swift
//  DOR
//
//  Created by Muhammad Ali on 06/05/2018.
//  Copyright © 2018 Muhammad Ali. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imagev: UIImageView!
    @IBOutlet weak var activity:UIActivityIndicatorView!
    override func awakeFromNib() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "code"), object: nil, queue: OperationQueue.main) { (notification) in
            self.activity.stopAnimating()
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
