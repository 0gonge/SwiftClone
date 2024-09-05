//
//  ProfileFilterView.swift
//  TwitterClone
//
//  Created by 송여경 on 9/6/24.
//

import UIKit

private let reuseIdentifier = "ProfileFilterCell"

class ProfileFilterView: UIView {
  //MARK: - Properties
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .white
    cv.delegate = self
    cv.dataSource = self
    return cv
  }()
  //lazy var : collection뷰에 접근할 때 초기화 될 것임. 낭비 줄임
  //UICollectionViewFlowLayout 생성 기본적으로 이 레이아웃은 그리드 형식으로 셀을 배친하며, 셀의 크기, 간격같은 요소들을 설정할 수 있다.
  // flow는 셀이 왼쪽에서 오른쪽으로, 그리드 형식으로 차례로 배치된다는 것을 의미한다.
  // frame:.zero 는 초기 프레임 크기를 설정하지 않고 레이아웃에 의해 나중에 결정한다는 의미이다. 그리고 collectionViewLayout : layout을 통해 앞서 생성한 UICollectionViewFlowLayout을 레이아웃으로 지정해 준 모습이다.
  //delegate ": 컬렉션뷰의 행동을 결정 ( 예 : 컬렉션 뷰를 선택했을 때 ) 즉, UICollectionViewDelegate 프로토콜을 따르는 메서드들은 이 클래스 안에서 구현이 되어야 한다.
  // dataSource는 현재 컬렉션 뷰에 어떤 데이터가 표시될지를 제어한다.
  //클로저는 리턴 필수
  
  //MARK: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    collectionView.register(ProfileFilterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    addSubview(collectionView)
    collectionView.addConstraintsToFillView(self)
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

//MARK - UICollectionViewDataSource
extension ProfileFilterView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfileFilterCell
    return cell
  }
}
//MARK - UICollectionViewDelegate

extension ProfileFilterView: UICollectionViewDelegate {
  
}

//MARK - UICollectionViewDelegateFlowLayout

extension ProfileFilterView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: frame.width / 3, height: frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
