//
//  Categories.swift
//  AppScripsTest
//
//  Created by Rajeev Vekta on 10/3/20.
//  Copyright © 2020 Adil Mir. All rights reserved.
//

import Foundation
struct Category : Codable {
    let name : String?
    var items : [Items]?
    var isListExpanded = true

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case items = "items"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        items = try values.decodeIfPresent([Items].self, forKey: .items)
    }

}
