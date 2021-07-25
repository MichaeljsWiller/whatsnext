//
//  MainView.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 11/11/2020.
//

import UIKit

class MainView: UIViewController {
    var viewModel: MainViewModel?
    private var createListButton: UIButton!
    private var headerImageView: UIImageView!
    private var headerLogo: UIImageView!
    private var headerTitle: UILabel!
    private var headerSubtitle: UILabel!
    private var noListsImageView: UIImageView!
    private var noListTitle: UILabel!
    private var noListSubtitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
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
        
        createListButton = UIButton(type: .custom)
        createListButton.setBackgroundImage(UIImage(named: "addButton"), for: .normal)
        createListButton.setImage(UIImage(named: "addButtonIcon"), for: .normal)
        
        createListButton.setTitle("Create New List", for: .normal)
        createListButton.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 20)
        createListButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -50, bottom: 16, right: 0)
        createListButton.titleEdgeInsets = UIEdgeInsets(top: 1, left: 1, bottom: 18, right: 1)
        createListButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(createListButton)
        
        noListsImageView = UIImageView()
        noListsImageView.image = UIImage(named: "noListsBackground")
        view.addSubview(noListsImageView)
        
        noListTitle = UILabel()
        noListTitle.text = "Your saved lists will appear here..."
        noListTitle.font = UIFont(name: "NewsGothicMT-Bold", size: 15)
        noListTitle.textColor = .lightGray
        noListTitle.alpha = 0.55
        noListsImageView.addSubview(noListTitle)
        
        noListSubtitle = UILabel()
        noListSubtitle.text = "You currently have no saved lists."
        noListSubtitle.font = UIFont(name: "NewsGothicMT-Bold", size: 14)
        noListSubtitle.textColor = .lightGray
        noListSubtitle.alpha = 0.55
        noListsImageView.addSubview(noListSubtitle)
    }
    
    @objc func didTapButton() {
        viewModel?.coordinator?.navigateToShoppingView()
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
            make.trailing.equalTo(headerTitle.snp.leading).multipliedBy(0.7)
        }
        
        createListButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.25)
            make.bottom.equalToSuperview().multipliedBy(0.98)
        }
        
        if viewModel?.savedLists != nil {
            noListsImageView.contentMode = .scaleAspectFit
            noListsImageView.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
                make.size.equalToSuperview().dividedBy(1.5)
            }
            
            noListTitle.snp.makeConstraints { make in
                make.centerY.equalToSuperview().offset(-10)
                make.centerX.equalToSuperview()
            }
            
            noListSubtitle.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(noListTitle.snp.bottom).offset(5)            }
        }
    }
}
