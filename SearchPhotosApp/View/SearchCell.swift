//
//  PhotosCell.swift
//  FlickrMVVMDemo
//
//  Created by Gourav on 03/03/22.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!

    var imagesViewModel: ImagesViewModel? {
        didSet {
          // let activityIndicator: UIActivityIndicatorView =  UIActivityIndicatorView.init(style: .large)
            
  //          let searchCellViewModel = SearchCellViewModel(images: Images)
           
 //           let url = photoCellViewModel.url
//            imageViewPhoto.addSubview(activityIndicator)
//            activityIndicator.startAnimating()
//            activityIndicator.frame = self.bounds
 

//            ImageDownloadManager.shared.downloadImage(with: url, completionHandler: { (image, cached) in
//              //  activityIndicator.stopAnimating()
//              //  activityIndicator.removeFromSuperview()
//                self.imageViewPhoto.image = image
//
//            }, placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    func configureCell(info: PhotosResponse?) {
        self.titleLabel.text = info?.title
    }
    
    override func prepareForReuse() {
        //imageViewPhoto.image = #imageLiteral(resourceName: "placeHolder")
    }
}
