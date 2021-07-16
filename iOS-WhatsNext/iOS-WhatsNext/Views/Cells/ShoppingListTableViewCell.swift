//
//  ShoppingListTableViewCell.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 14/07/2021.
//

import Foundation
import UIKit
import SnapKit

protocol ShoppingListDelegate: AnyObject {
    func moveItem(at indexPath: IndexPath)
}

class ShoppingListTableViewCell: UITableViewCell {
    
    weak var delegate: ShoppingListDelegate?
    /// Identifies the cell for reusability
    static let identifier = "ShoppingListTableViewCell"
    /// The index path of the cell
    var indexPath: IndexPath?
    /// Button to tick off the item from the list
    var tickButton: UIButton = UIButton(type: .custom)
    /// Label for the item name
    var itemLabel: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(tickButton)
        addSubview(itemLabel)
        setupConstraints()
        tickButton.addTarget(self, action: #selector(callDelegate), for: .touchUpInside)
    }
    
    /// Populates the cell with a button and an item name
    func configureCell(with itemName: String) {
        if let image = UIImage(systemName: "circle") {
            tickButton.setImage(image, for: .normal)
            tickButton.setImage(UIImage(systemName: "circle.fill"), for: .highlighted)
            tickButton.tintColor = .primaryBlue
            tickButton.isUserInteractionEnabled = true
        }
        itemLabel.text = itemName
        itemLabel.font = UIFont(name: "NewsGothicMT", size: 15)
        itemLabel.textColor = .primaryBlue
    }
    
    /// Calls the delegate to handle the button tap
    @objc func callDelegate(sender: UIButton!) {
        guard let indexPath = indexPath else { return }
        self.delegate?.moveItem(at: indexPath)
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
