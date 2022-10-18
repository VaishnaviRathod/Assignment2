//
//  ImagesCell.swift
//  SearchPhotosApp
//
//  Created by Vaishnavi Rathod on 17/10/22.
//

import Foundation
import UIKit


class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewPhoto: UIImageView!
    
    var url: String? {
        didSet {
          // let activityIndicator: UIActivityIndicatorView =  UIActivityIndicatorView.init(style: .large)
            
           // let imagesCellViewModel = ImagesCellViewModel(image: image)
           
//            imageViewPhoto.addSubview(activityIndicator)
//            activityIndicator.startAnimating()
//            activityIndicator.frame = self.bounds
           // self.imageViewPhoto.image = #imageLiteral(resourceName: "placeHolder")

            ImageManager.shared.downloadImage(with: url, completionHandler: { (image, cached) in
              //  activityIndicator.stopAnimating()
              //  activityIndicator.removeFromSuperview()
                self.imageViewPhoto.image = image
               
            }, placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    func configureCell(info: Photo?) {
        self.url = info?.link
    }
    
    override func prepareForReuse() {
        imageViewPhoto.image = #imageLiteral(resourceName: "placeHolder")
    }
}
