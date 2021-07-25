//
//  MenuView.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 25/07/2021.
//

import UIKit

class MenuView: UIViewController {
    
    private var dismissMenuImageView: UIImageView!
    private var tableView: UITableView!
    private let reuseId = "reuseId"
    var hasPointOrigin = false
    var pointOrigin: CGPoint?
    
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
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func panGestureAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        guard translation.y >= 0 else { return }
        
        // Allows the view to only be moved vertically
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // set back to original position in view
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
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

extension MenuView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        cell.textLabel?.text = "Rename List"
        cell.textLabel?.font = UIFont(name: "NewsGothicMT-Bold", size: 20)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }
    
    
}
