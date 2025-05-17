//
//  ViewController.swift
//  CryptoCrazyRxMVVM
//
//  Created by User on 17.05.25.


import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController{
    
    let tableView = UITableView()
    var cryptoList = [Crypto] ()
    let refreshControl = UIRefreshControl()
    let cryptoVM = CryptoViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        call()
        setUpBingings()
        cryptoVM.requestdata()
    }
    
    private func setUpBingings(){
        //loading
        cryptoVM.loading.bind(to: self.refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        // error
        cryptoVM.error.observe(on: MainScheduler.asyncInstance)
            .subscribe { error in
                print(error)
            }
            .disposed(by: disposeBag)
        // cryptos
        cryptoVM.cryptos.observe(on: MainScheduler.asyncInstance)
            .subscribe { cryptos in
                self.cryptoList = cryptos
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
            .disposed(by: disposeBag)
        
    }
    
    func call(){
        view.backgroundColor = .black
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        //        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.register(MyCell.self, forCellReuseIdentifier: "MyCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.refreshControl = refreshControl
        tableView.backgroundColor = .black
        refreshControl.tintColor = .white
        
        refreshControl.attributedTitle = NSAttributedString(string: "Loading...", attributes: [.foregroundColor: UIColor.black])
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    @objc
    private func refreshData() {
        cryptoVM.requestdata()
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? MyCell else {
            return UITableViewCell()
        }
        
        let item = cryptoList[indexPath.row]
        cell.titleLabel.text = item.currency
        cell.subtitleLabel.text = item.price
        cell.backgroundColor = .black
        return cell
    }
}

