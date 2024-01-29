//
//  ProfileImageVIew.swift
//  SeSAC Shopping(CodeBase)
//
//  Created by 남현정 on 2024/01/29.
//

import UIKit

class ProfileImageVIew: UIImageView {
    
    var isSelected: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        clipsToBounds = true // cornerRadius 가능하도록
        if isSelected {
            layer.borderWidth = 6
            layer.borderColor = CustomColor.pointColor?.cgColor
        } else {
            layer.borderWidth = .zero
        }
        
        DispatchQueue.main.async { // dispatch안해주면 이상하게 나옴(UI그리는 거는 main에서 해줘야함)
            self.layer.cornerRadius = self.frame.width / 2
        }
        self.contentMode = .scaleAspectFill
        
    }

}

