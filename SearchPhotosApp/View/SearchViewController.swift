//
//  ViewController.swift
//  SearchPhotosApp
//
//  Created by Vaishnavi Rathod on 13/10/22.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var collectionViewPhotos: UICollectionView!
    @IBOutlet var viewNoRecord: UIView!
    
   
    var cellId = "SearchCellView"
    let searchController = UISearchController(searchResultsController: nil)
    
    var photosViewModel :SearchViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        photosViewModel = SearchViewModel(apiManager: APIManager())
        //apiCall()
        self.setupSearchController()
        
        self.handleApiErrorResponse()
        self.handleApiSuccessResponse()

    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Photos"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func handleApiErrorResponse() {
        photosViewModel.bindAPIErrorResponse = { [weak self] in
            DispatchQueue.main.async {
                if let self = self {
                    AlertManager.showErrorAlert(with: self.photosViewModel.error?.localizedDescription ?? "", view: self)
                }
            }
        }
    }
    
    func handleApiSuccessResponse() {
        photosViewModel.bindAPISuccessResponse = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionViewPhotos.reloadData()
                self?.handleEmptyData()
            }
        }
    }
    
    func handleEmptyData() {
        
        if photosViewModel.response?.searchedData?.isEmpty == true  {
            self.collectionViewPhotos.backgroundView = self.viewNoRecord
        }
        else {
            self.collectionViewPhotos.backgroundView = nil
        }
    }
    
    func fetchPhotos(_ text:String) {
        
        var pendingRequestWorkItem: DispatchWorkItem?
        pendingRequestWorkItem?.cancel()
        let requestWorkItem = DispatchWorkItem { [weak self] in
            if pendingRequestWorkItem?.isCancelled == false {
                self?.photosViewModel.getPhotosBySearch( searchText: text)
            }
        }
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1),
                                      execute: requestWorkItem)
    }

    /*func apiCall () {
        guard let url = URL(string: "https://api.imgur.com/3/gallery/search/?q=dogs"),
            let payload = "{\"Authorization\": \"4442d2bb442f675\"}".data(using: .utf8) else
        {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Client-ID 4442d2bb442f675", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }

            if let str = String(data: data, encoding: .utf8) {
                print(str)
            }
        }.resume()
    }*/

}
//MARK:- UISearchResultsUpdating, UISearchControllerDelegate
extension SearchViewController: UISearchResultsUpdating,UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            if searchText.isEmpty == false {
                fetchPhotos(searchText)
            }
        }
    }
}
//MARK:- UICollectionViewDataSource,UICollectionViewDelegate
extension SearchViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosViewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewPhotos.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
        cell.configureCell(info: photosViewModel.response?.searchedData?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let imagesListViewController = storyBoard.instantiateViewController(withIdentifier: "ImagesListViewController") as! ImageListViewController
        imagesListViewController.imageViewModal.photosArray = photosViewModel.response?.searchedData?[indexPath.row]
        self.navigationController?.pushViewController(imagesListViewController, animated:true)
        
    }
    
}
//MARK:- UICollectionViewDelegateFlowLayout
extension SearchViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.height/5)
    }
}
