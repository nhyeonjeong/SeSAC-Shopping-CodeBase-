//
//  RecentSearchTableViewCell.swift
//  SeSAC Shopping(CodeBase)
//
//  Created by 남현정 on 2024/01/28.
//

import UIKit

class RecentSearchTableViewCell: UITableViewCell {

    let systemImage = UIImageView()
    let recentLabel = UILabel()
    let xButton = UIButton()
    
    var tableView: UITableView = UITableView()
    // 코드로 할 때
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(text: Any, tableview: UITableView) {
        recentLabel.text = text as? String
        self.tableView = tableview
    }

}

extension RecentSearchTableViewCell {
    func configureHierarchy() {
        contentView.addSubview(systemImage)
        contentView.addSubview(recentLabel)
        contentView.addSubview(xButton)
        
    }
    
    func configureView() {
        systemImage.image = UIImage(systemName: "magnifyingglass")
        systemImage.tintColor = CustomColor.textColor
        
        recentLabel.font = .systemFont(ofSize: 13)
        recentLabel.textColor = CustomColor.textColor
        
        xButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        xButton.tintColor = CustomColor.textColor
        print("dfdf")

    }
    
    func configureConstraints() {
        systemImage.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(20)
            make.centerY.equalTo(contentView)
            make.size.equalTo(20)
            
        }
        
        recentLabel.snp.makeConstraints { make in
            make.leading.equalTo(systemImage).inset(40)
            make.centerY.equalTo(contentView)
            make.height.equalTo(20)
            
        }
        
        xButton.snp.makeConstraints { make in
            make.size.equalTo(10)
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).inset(10)
        }
    }
}
