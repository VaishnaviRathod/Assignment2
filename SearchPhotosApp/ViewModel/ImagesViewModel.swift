//
//  ImagesCellViewModel.swift
//  SearchPhotosApp
//
//  Created by Vaishnavi Rathod on 17/10/22.
//

import Foundation
import UIKit

struct ImagesViewModel {
    //MARK:- Properties
    var photosArray: PhotosResponse?
    
    var numberOfRows:Int {
        photosArray?.photos?.count ?? 0
    }
}

