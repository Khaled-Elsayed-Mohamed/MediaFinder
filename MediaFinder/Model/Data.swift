//
//  Data.swift
//  CustomTableView
//
//  Created by Khaled L Said on 2/17/20.
//  Copyright © 2020 Intake4. All rights reserved.
//

import Foundation
import UIKit

public enum MediaType: String {
    case music = "music"
    case movie = "movie"
    case tvShow = "tvShow"
    case all = "all"
}


struct parameters {
    static let term = "term"
    static var scope = "all"
    static let media = "media"

    
}



struct results: Decodable {
    let results: [resultsData]
    let resultCount: Int
}

struct resultsData: Decodable {
    var artworkUrl100: String
    var artistName: String
    var longDescription: String?
    var previewUrl: String?
    var kind: String?




func getType() -> MediaType {
    switch self.kind {
    case "song":
        return MediaType.music
    case "feature-movie":
        return MediaType.movie
    case "tv-episode":
        return MediaType.tvShow
    default:
        return MediaType.music
        }
    }
}
