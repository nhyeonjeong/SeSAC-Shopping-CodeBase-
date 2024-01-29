//
//  OnboardingViewController.swift
//  SeSAC Shopping(CodeBase)
//
//  Created by 남현정 on 2024/01/28.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {

    let titleImageView = UIImageView()
    let mainImageView = UIImageView()
    let startAppButton = PointColorButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureView()
        configureConstraints() // configureHierarchy가 선행되어야한다.
        
    }
    
    @objc func startButtonClicked() {
        UserDefaultManager.shared.ud.removeObject(forKey: "TempProfileImage")

        navigationController?.pushViewController(SettingProfileViewController(), animated: true)
    }


}

extension OnboardingViewController {
    // addsubview
    func configureHierarchy() {
        view.addSubview(titleImageView)
        view.addSubview(mainImageView)
        view.addSubview(startAppButton)
    }
    // 속성
    func configureView() {
        titleImageView.image = UIImage(named: "sesacShopping")
        titleImageView.contentMode = .scaleAspectFill
        
        mainImageView.image = UIImage(named: "onboarding")
        mainImageView.contentMode = .scaleAspectFill
        
        startAppButton.title = "시작하기"
        startAppButton.configureView()
        startAppButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    // 제약조건
    func configureConstraints() {
        titleImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(80)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(103.67)
        }
        
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(203.67)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(313)
            
        }
        
        startAppButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(45)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
}
