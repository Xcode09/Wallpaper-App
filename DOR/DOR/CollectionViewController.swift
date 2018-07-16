//
//  CollectionViewController.swift
//  DOR
//
//  Created by Muhammad Ali on 06/05/2018.
//  Copyright © 2018 Muhammad Ali. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class CollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout{
    
    var selectedIndexPath: IndexPath!
      var refersher : UIRefreshControl!
    var arrayphoto = [photo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Api { (photo) in
            self.arrayphoto = photo
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
        refersher = UIRefreshControl()
        refersher.addTarget(self, action: #selector(pullrequest), for: .valueChanged)
        collectionView?.addSubview(refersher)
        let connection = networking.InternetConnection()
        if connection == true{
            print("connected")
        }
        else{
            print("Not connected")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return arrayphoto.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        let urls = self.arrayphoto[indexPath.item].name
        DispatchQueue.global().async {
            let url = URL(string: urls)!
            do{
                let data = try Data(contentsOf: url)
                let images = UIImage(data: data)
                DispatchQueue.main.async {
                    cell.activity.stopAnimating()
                    cell.activity.hidesWhenStopped = true
                    cell.imagev.image = images
                }
                
            }catch{
                print("error")
            }
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "vc") as? ViewController
        vc?.string = arrayphoto[indexPath.item].name
        self.selectedIndexPath = indexPath
        navigationController?.pushViewController(vc!
        , animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberofcloum:CGFloat = 2
        let widht = collectionView.frame.size.width
        let Xinext:CGFloat=10
        let cellspacing:CGFloat = 5
        let width = widht/numberofcloum - Xinext + cellspacing
        let hifht = widht/numberofcloum - Xinext + cellspacing
        return CGSize(width: width, height: hifht)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
