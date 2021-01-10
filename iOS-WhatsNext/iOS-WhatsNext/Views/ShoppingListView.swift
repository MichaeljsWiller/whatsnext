//
//  ShoppingListView.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 18/12/2020.
//

import UIKit

class ShoppingListView: UIViewController {
    private let viewModel = ShoppingListViewModel()
    private var addItemButton: UIButton!
    private var headerImageView: UIImageView!
    private var headerLogo: UIImageView!
    private var headerTitle: UILabel!
    private var headerSubtitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        //setupSwipeGesture()
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
        //addItemButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(addItemButton)
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
    }
    
    private func setupSwipeGesture() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer) {
            navigationController?.popViewController(animated: true)
    }
}

extension ShoppingListView: UIGestureRecognizerDelegate { }
