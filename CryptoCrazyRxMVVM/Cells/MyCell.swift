//
//  MyCell.swift
//  CryptoCrazyRxMVVM
//
//  Created by User on 17.05.25.
//

import Foundation
import SnapKit
import UIKit

final class MyCell : UITableViewCell {
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .white
        subtitleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        subtitleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.right.equalToSuperview().inset(16)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}
