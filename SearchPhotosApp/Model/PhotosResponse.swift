//
//  SearchModel.swift
//  SearchPhotosApp
//
//  Created by Vaishnavi Rathod on 17/10/22.
//

import Foundation
struct PhotosResponse : Codable {
    var photos : [Photo]?
    let id : String?
    let title : String?

    enum CodingKeys: String, CodingKey {
        case photos = "images"
        case id = "id"
        case title = "title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        photos = try values.decodeIfPresent([Photo].self, forKey: .photos)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }

}
