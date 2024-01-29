//
//  SearchViewController.swift
//  SeSAC Shopping(CodeBase)
//
//  Created by 남현정 on 2024/01/28.
//

import UIKit

class SearchViewController: UIViewController {

    let inputSearchBar = UISearchBar()
    
    let emptyImageView = UIImageView()
    let emptyLabel = UILabel()

    let topUIView = UIView()
    let currentSearchLabel = UILabel()
    let removeAllButton = UIButton()
    let recentSearchTableView = UITableView()
    
    var recentSearchList: [Any] = []
    
    // 유저디폴트에서 닉네임가져오기
    var userName: String? = UserDefaultManager.shared.ud.string(forKey: "UserNickname")
    
    /// xButton이 눌린 tableViewCell 의 row
    var selectedDeleteButton = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        configureTableView() // delegate, dataSource
        configureSearchbar() // delegate
        
        configureHierarchy()
        configureView()
        configureConstraints()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        userName = UserDefaultManager.shared.ud.string(forKey: "UserNickname")
        navigationItem.title = "떠나고 싶은 \(userName ?? "이름없음")님의 새싹쇼핑"
        
        hideTableView()
    }
    
    @objc func removeAllButtonClicked() {
        UserDefaultManager.shared.ud.set([], forKey: "RecentSearch")
        recentSearchTableView.reloadData()
    }

    
    /// 최근검색어가 없으면 tableview숨기기 / 아니면 나오도록
    func hideTableView() {
        // 최근 검색어 가져오기
        let currentSearchList = UserDefaultManager.shared.ud.array(forKey: "RecentSearch")
        
        if let current = currentSearchList {
            if current.count == 0 { // 비어있어도 숨기기
                topUIView.isHidden = true
                recentSearchTableView.isHidden = true
            } else {
                self.recentSearchList = current
                topUIView.isHidden = false
                recentSearchTableView.isHidden = false
            }
            
        } else { // 최근 검색어가 없다면 uiview와 tableview 숨기기
            topUIView.isHidden = true
            recentSearchTableView.isHidden = true
        }
    }
    
    @objc func xButtonClicked(_ sender: UIButton) {
        print(#function)
        var recentSearchList = UserDefaultManager.shared.ud.array(forKey: "RecentSearch")!
    
        // 받아온 xButton의 태그를 인덱스로 가지는 리스트 삭제
        recentSearchList.remove(at: sender.tag)
        
        // 유저디폴트에 다시 저장
        UserDefaultManager.shared.ud.set(recentSearchList, forKey: "RecentSearch")
        
        recentSearchTableView.reloadData() // 넘겨받은 tableview 다시 로드 -> 다시 로드하면서 tag값도 차례대로 다시 지정해준다.와 머임!!!! & remove(at:)하면 알아서 앞으로 땡겨쥼ㅎㅎ
    }

}

extension SearchViewController {
    func configureHierarchy() {
        view.addSubview(inputSearchBar)
        view.addSubview(emptyImageView)
        view.addSubview(emptyLabel)
        view.addSubview(topUIView)
        topUIView.addSubview(currentSearchLabel)
        topUIView.addSubview(removeAllButton)
        view.addSubview(recentSearchTableView)
        
        
    }
    func configureView() {
        inputSearchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        
        configureEmptyView() // 최근 검색어가 없을 때 보여지는 뷰
        
        currentSearchLabel.text = "최근 검색"
        currentSearchLabel.textColor = CustomColor.textColor
        currentSearchLabel.font = .boldSystemFont(ofSize: 13)
        removeAllButton.setTitle("모두 지우기", for: .normal)
        removeAllButton.setTitleColor(CustomColor.pointColor, for: .normal)
        removeAllButton.titleLabel?.font = .boldSystemFont(ofSize: 13)
        removeAllButton.addTarget(self, action: #selector(removeAllButtonClicked), for: .touchUpInside)
    }
    
    /// 최근 검색어 없을 때 보이는 뷰 구성
    func configureEmptyView() {
        emptyImageView.image = UIImage(named: "empty")
        emptyImageView.contentMode = .scaleAspectFill
        
        emptyLabel.text = "최근 검색어가 없어요"
        emptyLabel.textColor = CustomColor.textColor
        emptyLabel.textAlignment = .center
    }
    
    func configureConstraints() {
        inputSearchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        topUIView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(44)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(60)
            
        }
        
        currentSearchLabel.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.centerY.equalTo(topUIView)
            
        }
        
        removeAllButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.centerY.equalTo(topUIView)
        }
        
        emptyImageView.snp.makeConstraints { make in
            make.centerY.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(216)
            
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView).inset(236)
            make.height.equalTo(22)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        recentSearchTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(104)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func configureSearchbar() {
        inputSearchBar.delegate = self
    }
    
    // 서치바 return눌렀을 때 함수
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 화면전환 나중에 추가

        print(#function)
        // 유저디폴트에 저장
        let list = UserDefaultManager.shared.ud.array(forKey: "RecentSearch")
        var recentList: [Any] = []
        if let list {
            recentList = list
            // 유저디폴트에 저장되지 않은 단어만 넣기
            if !recentList.contains(where: { word in
                word as! String == searchBar.text!
            }) {
                recentList.append(searchBar.text!)
            }
        }

        UserDefaultManager.shared.ud.set(recentList, forKey: "RecentSearch")

        recentSearchTableView.reloadData()
    }
    
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        recentSearchTableView.delegate = self
        recentSearchTableView.dataSource = self
        // 코드베이스로 tableviewcell을 연결해줘야함
        recentSearchTableView.register(RecentSearchTableViewCell.self, forCellReuseIdentifier: RecentSearchTableViewCell.identifier)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        hideTableView() // 유저디폴트확인
        return recentSearchList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 유저디폴트 분기문
        let cell = recentSearchTableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.identifier, for: indexPath) as! RecentSearchTableViewCell
        
        cell.xButton.tag = indexPath.row // tag지정
        
        cell.configureCell(text: recentSearchList[indexPath.row], tableview: recentSearchTableView)
        
        cell.xButton.addTarget(self, action: #selector(xButtonClicked), for: .touchUpInside)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 화면전환
//        let vc = storyboard?.instantiateViewController(withIdentifier: SearchResultViewController.identifier) as! SearchResultViewController
// 
//        vc.searchText = recentSearchList[indexPath.row] as! String
//        
//        navigationController?.pushViewController(vc, animated: true)
    }
    
}

