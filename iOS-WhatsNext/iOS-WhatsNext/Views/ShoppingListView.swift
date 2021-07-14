//
//  ShoppingListView.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 18/12/2020.
//

import UIKit
import Combine

class ShoppingListView: UIViewController {
    weak var coordinator: AppCoordinator?
    var viewModel: ShoppingListViewModel?
    private var addItemButton: UIButton!
    private var headerImageView: UIImageView!
    private var headerLogo: UIImageView!
    private var headerTitle: UILabel!
    private var headerSubtitle: UILabel!
    private var tableView: UITableView!
    private let reuseId = "reuseId"
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    
    private func setupViews() {
        headerImageView = UIImageView()
        headerImageView.image = UIImage(named: "header")
        view.addSubview(headerImageView)
        
        headerTitle = UILabel()
        headerTitle.text = "WhatsNext?"
        headerTitle.font = UIFont(name: "NewsGothicMT-Bold", size: 25)
        headerTitle.textColor = .white
        headerImageView.addSubview(headerTitle)
        
        headerSubtitle = UILabel()
        headerSubtitle.text = "Shopping list"
        headerSubtitle.font = UIFont(name: "NewsGothicMT-Bold", size: 15)
        headerSubtitle.textColor = .lightGray
        headerImageView.addSubview(headerSubtitle)
        
        headerLogo = UIImageView()
        headerLogo.image = UIImage(named: "logoForHeader")
        headerImageView.addSubview(headerLogo)
        
        addItemButton = UIButton(type: .custom)
        addItemButton.setBackgroundImage(UIImage(named: "addButton"), for: .normal)
        addItemButton.setImage(UIImage(named: "addButtonIcon"), for: .normal)
        
        addItemButton.setTitle("Add New Item", for: .normal)
        addItemButton.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 20)
        addItemButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -50, bottom: 16, right: 0)
        addItemButton.titleEdgeInsets = UIEdgeInsets(top: 1, left: 1, bottom: 18, right: 1)
        addItemButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(addItemButton)
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.tableHeaderView?.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        headerImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(1.05)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.top.equalToSuperview().offset(-1)
        }
        
        headerTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.9)
        }
        
        headerSubtitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerTitle.snp.bottom).offset(5)
        }
        
        headerLogo.contentMode = .scaleAspectFit
        headerLogo.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(headerTitle.snp.left).multipliedBy(0.7)
        }
        
        addItemButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.25)
            make.bottom.equalToSuperview().multipliedBy(0.98)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerImageView.snp.bottom).offset(-15)
            make.bottom.equalTo(addItemButton.snp.top)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    @objc func didTapButton() {
        let alert = UIAlertController(title: "New Item", message: "Enter a new Item:", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Add", style: .cancel, handler: { [weak self] _ in
            if let textField = alert.textFields?.first,
               let item = textField.text {
                self?.viewModel?.addNewItem(item: item)
                self?.tableView.reloadData()
            }
        }))
        present(alert, animated: true)
        
    }
}

// MARK: - UITableViewDelegate methods
extension ShoppingListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        switch section {
        case 0 :
            return viewModel.currentList.items.count
        case 1:
            return viewModel.currentList.tickedItems.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        let currentItem = viewModel?.currentList.items[indexPath.row].name
        cell.textLabel?.text = currentItem
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return viewModel?.currentList.title
        case 1:
            return "Ticked off items"
        default:
            return "This shouldn't happen lol"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        if viewModel.currentList.tickedItems.isEmpty {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = .clear
        (view as! UITableViewHeaderFooterView).textLabel?.font = UIFont(name: "NewsGothicMT-Bold", size: 16)
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor(red: 70/255, green: 91/255, blue: 105/255, alpha: 1)
        (view as! UITableViewHeaderFooterView).frame(forAlignmentRect: CGRect(x: 0,y: 40,width: self.view.bounds.width,height: 1))
    }
}

extension ShoppingListView: UIGestureRecognizerDelegate { }
