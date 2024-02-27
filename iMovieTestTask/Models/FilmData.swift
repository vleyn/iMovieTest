//
//  FilmData.swift
//  iMovieTestTask
//
//  Created by Владислав Мазуров on 26.02.24.
//

import Foundation

//MARK: - Models for decoding JSON responce -

struct FilmData: Decodable {
    var docs: [Docs]?
    let page: Int?
    let pages: Int?
}

struct Docs: Decodable {
    let name: String?
    let description: String?
    let poster: Poster?
    let shortDescription: String?
    let logo: Logo?
}

struct Poster: Decodable {
    let url: String?
    let previewUrl: String?
}

struct Logo: Decodable {
    let url: String?
}
