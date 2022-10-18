//
//  ImagesListViewController.swift
//  SearchPhotosApp
//
//  Created by Vaishnavi Rathod on 17/10/22.
//

import Foundation
import UIKit
class ImageListViewController: UIViewController {
    
    @IBOutlet weak var imageListCollectionView: UICollectionView!
    
    //var photoResponse:PhotosResponse?
    var imageViewModal  = ImagesViewModel()
    var cellId = "ImageCellView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //imageViewModal = ImagesViewModel()
        //imageViewModal?.photosArray?.photos = photoResponse?.photos
        imageListCollectionView.reloadData()
    }
    
}
extension ImageListViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // return imagesModel.count
       // return imageViewModal.photosArray?.photos?.count ?? 0
        
        return imageViewModal.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageListCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImageCell
        cell.configureCell(info: imageViewModal.photosArray?.photos?[indexPath.row])
       // cell.url = "https://i.imgur.com/i79rJHd.jpg"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let fullScreenImageViewController = storyBoard.instantiateViewController(withIdentifier: "FullScreenImageViewController") as! FullScreenImageViewController
        fullScreenImageViewController.photo = imageViewModal.photosArray?.photos?[indexPath.row]
        //fullScreenImageViewController.url = 
        self.navigationController?.pushViewController(fullScreenImageViewController, animated:true)
    }
    
    
}
//MARK:- UICollectionViewDelegateFlowLayout
extension ImageListViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.height/5)
    }
}
