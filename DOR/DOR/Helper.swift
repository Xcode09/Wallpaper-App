//
//  Helper.swift
//  DOR
//
//  Created by Muhammad Ali on 06/05/2018.
//  Copyright © 2018 Muhammad Ali. All rights reserved.
//

import UIKit
import  SystemConfiguration
struct photo:Decodable{
    let _id : String
    let name: String
}

struct networking{
    
    static func InternetConnection()->Bool{
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired
        
        return isReachable && !needsConnection
    }
    static func loadimage(_ URLSTRING:String, Compilactionhandler: @escaping (UIImage)-> Void){
        if let url = URL(string: URLSTRING)
        {
            let task : URLSessionDataTask = URLSession.shared.dataTask(with: url) { (data, respon, error) in
                if error != nil{
                    print("eror")
                }
                guard let databufer = data else{return}
                let image = UIImage(data: databufer)!
                Compilactionhandler(image)
            }
            task.resume()
        }
    }
    
}




extension CollectionViewController : ZoomingViewController
{
    func zoomingBackgroundView(for transition: ZoomTransitioningDelegate) -> UIView? {
        return nil
    }
    
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView?
    {
        if let indexPath = selectedIndexPath {
            let cell = collectionView?.cellForItem(at: indexPath) as! CollectionViewCell
            return cell.imagev
        } else {
            return nil
        }
    }
}
extension ViewController : ZoomingViewController
{
    func zoomingBackgroundView(for transition: ZoomTransitioningDelegate) -> UIView? {
        return views
    }
    
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        views.isHidden = true
        return imv
    }
}
