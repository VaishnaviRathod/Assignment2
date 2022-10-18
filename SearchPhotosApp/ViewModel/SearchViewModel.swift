//
//  SearchViewModel.swift
//  SearchPhotosApp
//
//  Created by Vaishnavi Rathod on 14/10/22.
//

import Foundation

protocol  PhotosViewModelProtocol {
    func getPhotosBySearch(searchText text:String)
}

class SearchViewModel:PhotosViewModelProtocol {
    

    private let apiManager : APIManager?
    
    typealias BindingClouser = (() -> ())
    
    //MARK: - Public properties
    //var imagesViewModel:ImagesViewModel?
    
    
    var response : SearchResponse? {
        didSet {
            bindAPISuccessResponse()
        }
    }
    
    var error:Error? {
        didSet {
            bindAPIErrorResponse()
        }
    }
    
    
    //https://i.imgur.com/i79rJHd.jpg
    //bind values to controller using closure
    var bindAPISuccessResponse: BindingClouser = { }
    var bindAPIErrorResponse: BindingClouser = { }
    
    init(apiManager:APIManager) {
        self.apiManager = apiManager
    }
    
    func numberOfRows() -> Int {
        response?.searchedData?.count ?? 0
    }
    
    /*func getRowData(_ index:Int)-> PhotosResponse? {
        response?.searchedData?[index]
    }
    
    func getImagesModel(_ index:Int)-> PhotosResponse? {
        response?.searchedData?[index]
    }*/
    
    func getPhotosBySearch(searchText text:String) {
        
       let url = URL(string: "https://api.imgur.com/3/gallery/search/?q=\(text)")
        self.apiManager?.getApiData(requestUrl: url!, completionHandler: { (response: NetworkResponse<SearchResponse, NetworkError>) in
            switch response{
            case .success(let result):
                self.response = result

            case .failure(let error):
                self.error = error
            }
        })
    }

}
