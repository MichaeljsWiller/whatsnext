//
//  SplashScreen.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 07/11/2020.
//

import UIKit
import SnapKit

public protocol SplashScreenDelegate {
    func splashCompleted()
}

class SplashScreenVC: UIViewController {
    
    let splashScreenImage = UIImageView(image: UIImage(named: "NewLogo"))
    var delegate: SplashScreenDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(splashScreenImage)
        setUpImageView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.splashAnimation()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.splashCompleted()
    }
        
    func splashAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            self.splashScreenImage.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            
        }) { ( success ) in
            self.removeAnimation()
        }
    }
    
    func removeAnimation() {
        UIView.animate(withDuration: 2, delay: 0.1, options: .curveEaseOut, animations: {
            self.splashScreenImage.alpha = 0
            
        }) { ( success ) in
            self.viewWillDisappear(true)
        }
    }
    
    func setUpImageView() {
        splashScreenImage.contentMode = .scaleAspectFit
        splashScreenImage.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.width.equalTo(150)
        }
    }
}

extension SplashScreenVC: SplashScreenDelegate {
    func splashCompleted() {
    }
}
