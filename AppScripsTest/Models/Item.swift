//
//  Item.swift
//  AppScripsTest
//
//  Created by Rajeev Vekta on 10/3/20.
//  Copyright © 2020 Adil Mir. All rights reserved.
//

import Foundation
import UIKit
struct Items : Codable {
    let name : String?
    let image : String?
    let itemDescription : String?
    var isSelected = false

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case image = "image"
        case itemDescription = "description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        itemDescription = try values.decodeIfPresent(String.self, forKey: .itemDescription)
    }

}
