//
//  HomeModels.swift
//  LBG Test
//
//  Created by Raman Kant on 07/12/22.
//

import Foundation

struct ArtResponse : Codable {
    
    let pagination : Pagination?
    let data : [ArtInfo]?
    let info : Info?
    let config : Config?

    enum CodingKeys: String, CodingKey {

        case pagination = "pagination"
        case data = "data"
        case info = "info"
        case config = "config"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
        data = try values.decodeIfPresent([ArtInfo].self, forKey: .data)
        info = try values.decodeIfPresent(Info.self, forKey: .info)
        config = try values.decodeIfPresent(Config.self, forKey: .config)
    }
}

struct Pagination : Codable {
    
    let total : Int?
    let limit : Int?
    let offset : Int?
    let total_pages : Int?
    let current_page : Int?
    let next_url : String?

    enum CodingKeys: String, CodingKey {

        case total = "total"
        case limit = "limit"
        case offset = "offset"
        case total_pages = "total_pages"
        case current_page = "current_page"
        case next_url = "next_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        current_page = try values.decodeIfPresent(Int.self, forKey: .current_page)
        next_url = try values.decodeIfPresent(String.self, forKey: .next_url)
    }
}

struct Info : Codable {
    
    let license_text : String?
    let license_links : [String]?
    let version : String?

    enum CodingKeys: String, CodingKey {

        case license_text = "license_text"
        case license_links = "license_links"
        case version = "version"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        license_text = try values.decodeIfPresent(String.self, forKey: .license_text)
        license_links = try values.decodeIfPresent([String].self, forKey: .license_links)
        version = try values.decodeIfPresent(String.self, forKey: .version)
    }

}

struct ArtInfo : Codable {
    
    let id : Int?
    let title : String?
    let image_id : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case image_id = "image_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        image_id = try values.decodeIfPresent(String.self, forKey: .image_id)
    }
}

struct Config : Codable {
    
    let iiif_url : String?
    let website_url : String?

    enum CodingKeys: String, CodingKey {
        case iiif_url = "iiif_url"
        case website_url = "website_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iiif_url = try values.decodeIfPresent(String.self, forKey: .iiif_url)
        website_url = try values.decodeIfPresent(String.self, forKey: .website_url)
    }
}
