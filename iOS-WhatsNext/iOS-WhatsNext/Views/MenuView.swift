//
//  MenuView.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 25/07/2021.
//

import UIKit

class MenuView: UIViewController {
  
  var viewModel: MenuViewModel?
  var hasPointOrigin = false
  var pointOrigin: CGPoint?
  private var dismissMenuImageView: UIImageView!
  private var tableView: UITableView!
  private let reuseId = "reuseId"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .primaryBlue
    setupViews()
    setupConstraints()
  }
  
  override func viewDidLayoutSubviews() {
    if !hasPointOrigin {
      hasPointOrigin = true
      pointOrigin = self.view.frame.origin
    }
  }
  
  /// Allows the user to swipe the menu down to dismiss it
  @objc func swipeToDismiss(sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: view)
    
    guard translation.y >= 0 else { return }
    
    // Allows the view to only be moved vertically
    view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
    
    if sender.state == .ended {
      let dragVelocity = sender.velocity(in: view)
      if dragVelocity.y >= 1300 {
        viewModel?.closeMenu()
      } else {
        // set back to original position in view
        UIView.animate(withDuration: 0.3) {
          self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
        }
      }
    }
  }
  
  private func setupViews() {
    dismissMenuImageView = UIImageView()
    dismissMenuImageView.image = UIImage(named: "MenuDismissBar")
    view.addSubview(dismissMenuImageView)
    
    tableView = UITableView()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.backgroundColor = .clear
    tableView.tableHeaderView?.backgroundColor = .clear
    tableView.separatorColor = .white
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
    view.addSubview(tableView)
    
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(swipeToDismiss))
    view.addGestureRecognizer(panGesture)
  }
  
  private func setupConstraints() {
    dismissMenuImageView.contentMode = .scaleAspectFit
    dismissMenuImageView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(15)
    }
    
    tableView.snp.makeConstraints { make in
      make.top.equalTo(dismissMenuImageView.snp.bottom).multipliedBy(2)
      make.bottom.trailing.equalToSuperview()
      make.leading.equalTo(dismissMenuImageView.snp.centerX).dividedBy(2.5)
    }
  }
}

// MARK: - UITableViewDelegate methods
extension MenuView: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let viewModel = viewModel else { return 0 }
    
    return viewModel.menuItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
    cell.textLabel?.text = viewModel?.menuItems[indexPath.row].name
    cell.textLabel?.font = UIFont(name: "NewsGothicMT-Bold", size: 20)
    cell.textLabel?.textColor = .white
    cell.selectionStyle = .none
    cell.backgroundColor = .clear
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel?.menuItems[indexPath.row].action()
  }
}
