//
//  UserCountry.swift
//  Phi Wallet App
//
//  Created by Aijaz Ali on 22/01/2024.
//

import Foundation


struct Country: Decodable {
    let country: [UserCountry]
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case country
        case name
    }
    
    init(from decoder: Decoder) throws {
        let dataContainer = try decoder.container(keyedBy: CodingKeys.self)
        country = try dataContainer.decode([UserCountry].self, forKey: .country)
        name = try dataContainer.decode(String.self, forKey: .name)
    }
}

struct UserCountry: Decodable {
    let country_id: String
    
    
    enum CodingKeys: String, CodingKey {
        case country_id
    }
    
    init(from decoder: Decoder) throws {
        let dataContainer = try decoder.container(keyedBy: CodingKeys.self)
        country_id = try dataContainer.decode(String.self, forKey: .country_id)
    }
}
