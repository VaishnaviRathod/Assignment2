//
//  FullScreenImageViewController.swift
//  SearchPhotosApp
//
//  Created by Vaishnavi Rathod on 17/10/22.
//

import Foundation
import UIKit

class FullScreenImageViewController:UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    //var url:String?
    var photo:Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseImage(url: photo?.link)
    }
    
    func parseImage(url: String?) {
        ImageManager.shared.downloadImage(with: url ?? "", completionHandler: { (image, cached) in
            //  activityIndicator.stopAnimating()
            //  activityIndicator.removeFromSuperview()
              self.photoImageView.image = image
           
        }, placeholderImage: UIImage(named: "placeholder"))
    }
}
