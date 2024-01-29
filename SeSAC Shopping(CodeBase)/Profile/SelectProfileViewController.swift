//
//  SelectProfileViewController.swift
//  SeSAC Shopping(CodeBase)
//
//  Created by 남현정 on 2024/01/29.
//

import UIKit
import SnapKit

class SelectProfileViewController: UIViewController {
    
    let profileImageview = ProfileImageVIew(frame: .zero)
//    let profileCollectionView = UICollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureView()
        configureConstraints()
            
    }
    

}

extension SelectProfileViewController {
    func configureHierarchy() {
        view.addSubview(profileImageview)
//        view.addSubview(profileCollectionView)
        
    }
    
    func configureView() {
        profileImageview.isSelected = true
        profileImageview.configureView()
        
        // profileCollectionView
    }
    
    func configureConstraints() {
        profileImageview.snp.makeConstraints { make in
            make.size.equalTo(170)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalToSuperview()
        }
        
//        profileCollectionView.snp.makeConstraints { make in
//            make.horizontalEdges.bottom.equalToSuperview()
//            make.top.equalTo(profileImageview.snp.bottom).inset(40)
//        }
        
        
    }
}
