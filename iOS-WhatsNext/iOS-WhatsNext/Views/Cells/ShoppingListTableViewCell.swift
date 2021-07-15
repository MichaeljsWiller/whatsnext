//
//  ShoppingListTableViewCell.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 14/07/2021.
//

import Foundation
import UIKit
import Combine
import SnapKit

class ShoppingListTableViewCell: UITableViewCell {
    
    static let identifier = "ShoppingListTableViewCell"
    var tickButton: UIButton = UIButton(type: .custom)
    var itemLabel: UILabel = UILabel()
    @Published var isItemSelected: Bool? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(tickButton)
        addSubview(itemLabel)
        setupConstraints()
    }
    
    func configureCell(with itemName: String) {
        if let image = UIImage(systemName: "circle") {
            tickButton.setImage(image, for: .normal)
            tickButton.setImage(UIImage(systemName: "circle.fill"), for: .highlighted)
            tickButton.tintColor = .primaryBlue
            tickButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            tickButton.isUserInteractionEnabled = true
        }
        itemLabel.text = itemName
        itemLabel.font = UIFont(name: "NewsGothicMT", size: 15)
        itemLabel.textColor = .primaryBlue
    }
    
    @objc func buttonAction(sender: UIButton!) {
        isItemSelected = true
       }
    
    private func setupConstraints() {
        tickButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        itemLabel.snp.makeConstraints { make in
            make.centerY.equalTo(tickButton)
            make.leading.equalTo(tickButton.snp.trailing).offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
