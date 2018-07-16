//
//  Extensions.swift
//  DOR
//
//  Created by Muhammad Ali on 07/05/2018.
//  Copyright © 2018 Muhammad Ali. All rights reserved.
//

import UIKit
extension CollectionViewController{
  
    func Api(_ complicationhandler: @escaping ([photo])->Void)
    {
        let url_For_API = "https://apiwallpaper.herokuapp.com/getuser"
        //let urlstring:String="http://localhost:3000/getuser" // for local
        let url:URL=URL(string: url_For_API)!
        let resquest:URLRequest=URLRequest(url: url)
        let tesk:URLSessionDataTask=URLSession.shared.dataTask(with: resquest) { (data, respone, error) in
            if error != nil{
                self.alert((error?.localizedDescription)!)
            }
            let httpresponse = respone as? HTTPURLResponse
            if httpresponse?.statusCode == 200{
                do{
                    let json = try JSONDecoder().decode([photo].self, from: data!)
                    complicationhandler(json)
                }
                catch let err{
                    self.alert(err.localizedDescription)
                }
            }else if httpresponse?.statusCode == 404{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "code"), object: nil)
            }
            
        }
        tesk.resume()
        
    }
    fileprivate func alert(_ message:String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    @objc func pullrequest(){
        Api { (photo) in
            for photos in photo{
                self.arrayphoto.index(0, offsetBy: 0, limitedBy: 5)
            }
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
                
            }
        }
        self.refersher.endRefreshing()
    }
}
