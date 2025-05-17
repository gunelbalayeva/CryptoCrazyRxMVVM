//
//  NetworkService.swift
//  CryptoCrazyRxMVVM
//
//  Created by User on 17.05.25.
//

import Foundation
enum CryptoError:Error {
    case serverError
    case parsingError
}

final class NetworkService {
    func downloadCurrencies(url:URL, completion: @escaping (Result<[Crypto], CryptoError>) -> () ){
        let task =  URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.serverError))
            }else if let data = data {
                let cryptoList = try? JSONDecoder().decode([Crypto].self,from: data)
                if let cryptoList = cryptoList {
                    completion(.success(cryptoList))
                }else {
                    completion(.failure(.parsingError))
                    
                }
            }
        }
        task.resume()
    }
}

