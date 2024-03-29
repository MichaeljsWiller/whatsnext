//
//  ShoppingListView.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 18/12/2020.
//

import UIKit

/// A view that configures and displays a shopping list
class ShoppingListView: UIViewController, ShoppingListItemDelegate {
  
  /// The viewModel supporting the view
  var viewModel: ShoppingListViewModel?
  private var addItemButton: UIButton!
  private var headerImageView: UIImageView!
  private var headerLogo: UIImageView!
  private var headerTitle: UILabel!
  private var headerSubtitle: UILabel!
  private var tableView: UITableView!
  private var menuButton: UIButton!
  private let reuseId = "reuseId"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    navigationController?.interactivePopGestureRecognizer?.delegate = self
    setupViews()
    setupConstraints()
  }
  
  /// Called when items in the list have changed and reloads the table view
  func listHasChanged() {
    tableView.reloadData()
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
    addItemButton.addTarget(viewModel, action: #selector(viewModel?.didTapButton), for: .touchUpInside)
    view.addSubview(addItemButton)
    
    menuButton = UIButton(type: .custom)
    menuButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
    menuButton.tintColor = .white
    menuButton.addTarget(viewModel, action: #selector(viewModel?.openMenu), for: .touchUpInside)
    view.addSubview(menuButton)
    
    tableView = UITableView()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.backgroundColor = .clear
    tableView.tableHeaderView?.backgroundColor = .clear
    tableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: ShoppingListTableViewCell.identifier)
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
    
    menuButton.contentMode = .scaleAspectFit
    menuButton.snp.makeConstraints { make in
      make.trailing.equalToSuperview().multipliedBy(0.95)
      make.bottom.equalTo(headerImageView).multipliedBy(0.85)
      make.size.equalTo(25)
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
}

// MARK: - UITableViewDelegate methods
extension ShoppingListView: UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let viewModel = viewModel else { return 0 }
    switch section {
    case 0 :
      return viewModel.currentList.itemsArray.count
    case 1:
      return viewModel.currentList.itemsInBasket.count
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.identifier, for: indexPath) as! ShoppingListTableViewCell
    switch indexPath.section {
    case 0:
      if let currentItem = viewModel?.currentList.itemsArray[indexPath.row] {
        cell.configureCell(with: currentItem.name)
        cell.delegate = viewModel
        cell.indexPath = indexPath
      }
      return cell
      
    case 1:
      let basketCell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
      if let currentItem = viewModel?.currentList.itemsInBasket[indexPath.row].name {
        let attributedString = NSMutableAttributedString(string: currentItem)
        attributedString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
        basketCell.textLabel?.attributedText = attributedString
        basketCell.textLabel?.font = UIFont(name: "NewsGothicMT", size: 15)
        basketCell.textLabel?.textColor = .primaryBlue
        return basketCell
      }
    default:
      return UITableViewCell()
    }
    return UITableViewCell()
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    guard let viewModel = viewModel else { return 0 }
    if viewModel.currentList.itemsInBasket.isEmpty {
      return 1
    } else {
      return 2
    }
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      return viewModel?.currentList.title
    case 1:
      return "Items in basket"
    default:
      return nil
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    true
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    // Edit swipe action
    let editAction = UIContextualAction(style: .normal,
                                        title: "edit",
                                        handler: { (action,
                                                    view,
                                                    completionHandler) in
                                          self.viewModel?.editItemName(at: indexPath)
                                          completionHandler(true)
                                        })
    editAction.image = UIImage(systemName: "pencil")
    editAction.backgroundColor = .primaryBlue
    
    // Delete swipe action
    let deleteAction = UIContextualAction(style: .destructive,
                                          title: "delete",
                                          handler: { (action,
                                                      view,
                                                      completionHandler) in
                                            if indexPath.section == 0 {
                                              if let itemToRemove = self.viewModel?.currentList.itemsArray[indexPath.row] {
                                                self.viewModel?.currentList.removeFromItems(itemToRemove)
                                              }
                                            } else if indexPath.section == 1 {
                                              if let itemToRemove = self.viewModel?.currentList.itemsInBasket[indexPath.row] {
                                                self.viewModel?.currentList.removeFromItems(itemToRemove)
                                              }
                                            }
                                            tableView.reloadData()
                                            completionHandler(true)
                                          })
    deleteAction.image = UIImage(systemName: "xmark.bin.fill")
    deleteAction.backgroundColor = .systemRed
    
    // Undo swipe action
    let undoAction = UIContextualAction(style: .normal,
                                        title: "undo",
                                        handler: { (action,
                                                    view,
                                                    completionHandler) in
                                          self.viewModel?.undoItemMove(at: indexPath)
                                          self.tableView.reloadData()
                                          completionHandler(true)
                                        })
    undoAction.image = UIImage(systemName: "arrow.uturn.backward")
    undoAction.backgroundColor = .systemOrange
    
    if indexPath.section == 0 {
      let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
      return configuration
    }
    if indexPath.section == 1 {
      let configuration = UISwipeActionsConfiguration(actions: [deleteAction, undoAction])
      return configuration
    }
    return nil
  }
  
  func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    if indexPath.section == 0 {
      let basketAction = UIContextualAction(style: .destructive,
                                            title: "add",
                                            handler: { (action,
                                                        view,
                                                        completionHandler) in
                                              self.viewModel?.moveItemToBasket(from: indexPath)
                                              self.tableView.reloadData()
                                              completionHandler(true)
                                            })
      basketAction.image = UIImage(systemName: "checkmark")
      basketAction.backgroundColor = .primaryBlue
      let configuration = UISwipeActionsConfiguration(actions: [basketAction])
      return configuration
    }
    return nil
  }
  
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    (view as! UITableViewHeaderFooterView).contentView.backgroundColor = .clear
    (view as! UITableViewHeaderFooterView).textLabel?.font = UIFont(name: "NewsGothicMT-Bold", size: 16)
    (view as! UITableViewHeaderFooterView).textLabel?.textColor = .primaryBlue
    (view as! UITableViewHeaderFooterView).frame(forAlignmentRect: CGRect(x: 0,y: 40,width: self.view.bounds.width,height: 1))
  }
  
  // MARK: - UIViewControllerTransitioningDelegate methods
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    PresentationController(presentedViewController: presented, presenting: presenting)
  }
}

extension ShoppingListView: UIGestureRecognizerDelegate { }
