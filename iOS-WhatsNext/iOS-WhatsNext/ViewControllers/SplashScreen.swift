//
//  SplashScreen.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 07/11/2020.
//

import UIKit
import SnapKit

class SplashScreenVC: UIViewController {
    
    let splashScreenImage = UIImageView(image: UIImage(named: "NewLogo"))
    weak var delegate : SplashScreenVCDelegate?

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
    
    func splashAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            self.splashScreenImage.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            
        }) { ( success ) in
            self.removeAnimation()
        }
    }
    
    func removeAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
            self.splashScreenImage.alpha = 0
            
        }) { ( success ) in
            self.navigationController?.popViewController(animated: true)
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

protocol SplashScreenVCDelegate: class {
    func splashCompleted(_ splash: SplashScreenVC)
}

