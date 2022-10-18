//
//  Images.swift
//  SearchPhotosApp
//
//  Created by Vaishnavi Rathod on 14/10/22.
//

import Foundation
struct Photo : Codable {
    
    let id : String?
    let title : String?
    let description : String?
    let link : String?
    
    
     init(id: String?, title: String?, description: String?, link: String?) {
        self.id = id
        self.title = title
        self.description = description
        self.link = link
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case link = "link"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        link = try values.decodeIfPresent(String.self, forKey: .link)
    }

}
