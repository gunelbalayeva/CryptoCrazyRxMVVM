//
//  CryptoViewModel.swift
//  CryptoCrazyRxMVVM
//
//  Created by User on 17.05.25.
//

import Foundation
import RxSwift
import RxCocoa
final class CryptoViewModel{
    
    let cryptos:PublishSubject<[Crypto]> = PublishSubject()
    let error:PublishSubject<String> = PublishSubject()
    let loading:PublishSubject<Bool> = PublishSubject()
    
    func requestdata(){
        self.loading.onNext(true)
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        NetworkService().downloadCurrencies(url: url) { result in
            self.loading.onNext(false)
            switch result {
            case .success(let cryptos):
                self.cryptos.onNext(cryptos)
                
            case .failure(let error) :
                switch error {
                case .parsingError :
                    self.error.onNext("Parsing Error")
                case .serverError:
                    self.error.onNext("Server Error")
                    
                }
            }
        }
    }
}
