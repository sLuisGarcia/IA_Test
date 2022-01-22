//
//  MoviesResponse.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import Foundation

struct MoviesResponse: Initable {
    var movies: [MovieData]
    var routes: [Routes]
    
    enum CodingKeys: String, CodingKey {
        case movies
        case routes
    }
    
    init() {
        movies = [MovieData()]
        routes = [Routes()]
    }
}

struct MovieData: Initable {
    var rating: String
    var media: [MediaData]
    var genre: String
    var synopsis: String
    var length: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case rating
        case media
        case genre
        case synopsis
        case length
        case name
    }
    
    init() {
        rating = ""
        media = [MediaData()]
        genre = ""
        synopsis = ""
        length = ""
        name = ""
    }
}

struct MediaData: Initable {
    var resource: String
    var code: String

    enum CodingKeys: String, CodingKey {
        case resource
        case code
    }

    init() {
        resource = ""
        code = ""
    }
}

struct Routes: Initable {
    var code: String
    var sizes: Sizes
    
    enum CodingKeys: String, CodingKey {
        case code
        case sizes
    }
    
    init() {
        code = ""
        sizes = Sizes()
    }
}

struct Sizes: Initable {
    var small: String?
    var medium: String?
    var large: String?
    
    enum CodingKeys: String, CodingKey {
        case small
        case medium
        case large
    }
    
    init() {
        small = ""
        medium = ""
        large = ""
    }
}
