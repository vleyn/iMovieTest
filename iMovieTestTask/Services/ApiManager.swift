//
//  ApiManager.swift
//  iMovieTestTask
//
//  Created by Владислав Мазуров on 26.02.24.
//

import Foundation

//MARK: - ApiManager -

enum DataError: Error {
    case invalidData
    case invalidResponse
    case message(_ error: Error?)
}

protocol ApiManager {
    func fetchData(page: Int, completion: @escaping (Result<FilmData, Error>) -> Void)
}

class KpApiManager: ApiManager {
    
    func fetchData(page: Int, completion: @escaping (Result<FilmData, Error>) -> Void) {
        
        var urlComponents = URLComponents(string: "https://api.kinopoisk.dev/v1.4/movie")
        urlComponents?.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
        ]
        guard let url = urlComponents?.url else { return }
        var request = URLRequest(url: url)
        request.setValue("NJF6PPK-STR4Y6K-QCSAZRV-1AH0923", forHTTPHeaderField: "X-API-KEY")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {
                completion(.failure(DataError.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
                completion(.failure(DataError.invalidResponse))
                return
            }
            
            do {
                let products = try JSONDecoder().decode(FilmData.self, from: data)
                completion(.success(products))
            }
            catch {
                completion(.failure(DataError.message(error)))

            }
        }.resume()
    }
}
