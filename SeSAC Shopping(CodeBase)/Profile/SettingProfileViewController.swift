//
//  SettingProfileViewController.swift
//  SeSAC Shopping(CodeBase)
//
//  Created by 남현정 on 2024/01/28.
//

import UIKit
import TextFieldEffects
import SnapKit

class SettingProfileViewController: UIViewController {

    let profileImageButton = PointColorButton()
    let cameraImageView = UIImageView()
    
    let nicknameTextField = HoshiTextField()
    let statusLabel = UILabel() // 닉네임을 잘 입력했는지 알려주는 문구
    let finishProfileButton = PointColorButton()
    
    enum CheckNickname: String {
        case notFitLen = "2글자 이상 10글자 미만으로 설정해주세요"
        case containSpecificChar = "닉네임에 @,#,$,% 는 포함할 수 없어요"
        case containNum = "닉네임에 숫자는 포함할 수 없어요"
        
        static let specificChar = ["@","#","$","%"] // 포함하면 안되는 문자들
        
    }
    // 유저디폴트에 저장된게 없다면 랜덤으로 보여지도록 하기(디폴트)
    var imageName = "profile\(Int.random(in: 1...14))"
    // 유저디폴트에 저장된게 없다면 아무것도 안쓰여있음
    var nickName = ""
    
    /// 완료버튼을 누를 수 있는지 / 오토레이아웃연습때는 일단 true로
    var isAbleButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureHierarchy()
        configureView()
        configureConstraints()
        configureTextField()
    }
    
    /// 완료 버튼 눌렀을 때
    @objc func finishButtonClicked(_ sender: UIButton) {
        print(#function)
        // isAbleButton이 true일때만 화면전환가능하도록 , UserDefault저장
        if isAbleButton {
            // 유저디폴트 저장
            UserDefaultManager.shared.ud.set(nicknameTextField.text!, forKey: "UserNickname")
            // 프로필이미지 진짜 유저디폴트에 저장
            UserDefaultManager.shared.ud.set(imageName, forKey: "UserProfileImage")

            let navi = UINavigationController(rootViewController: SearchViewController())
            navi.modalPresentationStyle = .fullScreen // 뒤로 갈 일이 없다.
            present(navi, animated: true)
            
        }
    }
    
    /// false : 길이가 맞지 않는 경우
    func checkLen(text: String) -> Bool {
        return text.count < 2 || text.count >= 10 ? false : true
    }
    /// false : 포함하면 안되는 문자 포함할 경우
    func checkChar(text: String) -> Bool {
        return text.contains("@") || text.contains("#") || text.contains("$") || text.contains("%") ? false : true

    }
    /// false : 숫자 포함할 경우
    func checkNum(text: String) -> Bool {
        for t in text {
            if t.isNumber { return false }
        }
        
        return true
    }

}
extension SettingProfileViewController: UITextFieldDelegate {
    
    func configureTextField() {
        nicknameTextField.delegate = self
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        // 글자수 조건에 맞지 않을 때
        print(#function)
        let text = nicknameTextField.text!
        
        isAbleButton = false // 입력했으면 false로 초기화
        
        if !checkLen(text: text) {
            statusLabel.text = CheckNickname.notFitLen.rawValue
        } else if !checkChar(text: text) { // 특수문자 조건에 안맞으면
            
            statusLabel.text = CheckNickname.containSpecificChar.rawValue
            
        } else if !checkNum(text: text) {
            statusLabel.text = CheckNickname.containNum.rawValue
        } else { // 모든 조건을 만족할 때
            print("correct")
            statusLabel.text = "사용할 수 있는 닉네임이에요"
            isAbleButton = true
        }
        statusLabel.reloadInputViews() // 안배웠는데 써봤다...(있는줄몰랐움)
    }
}

extension SettingProfileViewController {
    func configureHierarchy() {
        view.addSubview(profileImageButton)
        view.addSubview(cameraImageView)
        view.addSubview(nicknameTextField)
        view.addSubview(statusLabel)
        view.addSubview(finishProfileButton)
    }
    func setRandomImage() {

        profileImageButton.setImage(UIImage(named: imageName), for: .normal)
        profileImageButton.isSelected = true
        profileImageButton.configureView()
        
    }
    
    func configureView() {
        navigationItem.title = "프로필 설정"
        // 이미지
        setRandomImage()
//        profileImageView.isUserInteractionEnabled = true // imageView클릭 가능하도록
        cameraImageView.image = UIImage(named: "camera")
        
        // textfieldeffects
        
        nicknameTextField.text = nickName
        nicknameTextField.placeholder = " 닉네임을 입력해주세요 :)"
        nicknameTextField.borderInactiveColor = CustomColor.textColor
        nicknameTextField.borderActiveColor = CustomColor.pointColor
        nicknameTextField.placeholderColor = .systemGray
        
        statusLabel.text = ""
        statusLabel.textColor = CustomColor.pointColor
        statusLabel.font = .systemFont(ofSize: 13)
        
        
        // 버튼
        finishProfileButton.title = "완료"
        finishProfileButton.configureView()
        finishProfileButton.addTarget(self, action: #selector(finishButtonClicked), for: .touchUpInside)
    }
    
    func configureConstraints() {
        profileImageButton.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.trailing.equalTo(profileImageButton)
            make.bottom.equalTo(profileImageButton)
            
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaInsets).inset(20)
            make.height.equalTo(55)
            make.top.equalTo(profileImageButton).inset(130)
            
        }
        
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(20)
            make.top.equalTo(nicknameTextField).inset(65)
        }
        
        finishProfileButton.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(statusLabel).inset(50)
        }
    }
}


