//
//  PointColorButton.swift
//  SeSAC Shopping(CodeBase)
//
//  Created by 남현정 on 2024/01/29.
//

import UIKit

class PointColorButton: UIButton {
    
    var title: String = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        setTitle(title, for: .normal)
        backgroundColor = CustomColor.pointColor
        layer.cornerRadius = 10
        setTitleColor(CustomColor.textColor, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 17)
    }

}
