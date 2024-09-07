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
  //dequeueReusableCell(withReuseIdentifier:for:): 컬렉션 뷰에서 화면에서 벗어난 셀을 재사용할 때 사용
  //for indexpath : 요청한 셀의 인덱스 번호
  //as! ProfileFilterCell : 재사용된 셀을 내가 커스텀해 준 셀로 지정을 해주겠다! ->컬렉션 뷰에 등록된 클래스와 일치해야 오류가 발생하지 않는다.
  //as! 는 왜 사용하지? dequeueReusableCell(withReuseIdentifier:for:) 메서드가 기본적으로 UICollectionViewCell 타입의 객체를 반환하기 때문 여기에서는 내가 커스터마이징 해준 Cell로 반환을 해주고 있음
  //as! : 타입 캐스팅을 할 때 사용하는 강제 캐스팅 연산자 / 기대하고 있는 타입이 ProfileFilterCell이라고 확신할 때 사용. 만약 셀이 실제로 ProfileFilterCell이 아니라면 앱이 실행 중에 크래시가 발생, 컬렉션 뷰에서는 보장이 되어있다고 생각하자. 
  
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
