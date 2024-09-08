//
//  ProfileFilterView.swift
//  TwitterClone
//
//  Created by 송여경 on 9/6/24.
//

import UIKit

private let reuseIdentifier = "ProfileFilterCell"

protocol ProfileFilterViewDelegate: AnyObject {
  func filterView(_ view: ProfileFilterView, didSelect IndexPath: IndexPath)
}
//특정 클래스가 필터뷰에서 발생하는 이벤트(셀선택과 같은게 있겠지)를 처리할 수 있도록 하기 위한 약속을 정의해주는 거라고 이해하자.
//protocol: 클래스나 구조체가 반드시 구현해야 하는 매서드나 속성 등을 정의한 일종의 청사진이다.
//프로토콜을 준수하는 클래스는 프로토콜에 정의된 메서드를 반드시 구현해야 한다.
//AnyObject: 프로토콜이 클래스 타입에서만 채택될 수 있음을 나타냄
//즉, 구조체나 열거형은 이 프로토콜을 채택할 수 없다!
//이를 통해 weak 참조를 사용할 수 있게 함. 프로토콜을 클래스 타입으로 제한하는 이유? 순환참조 문제를 방지하기 위함이다.
//프로토콜 안 메서드 : 셀을 선택했을 때 호출된다. 그래서 결론적으로는 이 프로토콜을 준수하는 클래스가 이 메서드를 구현함으로써, 필터 선택을 할 때 발생하는 동작을 정의해 줄 수 있는 것이다.
//그러면 프로토콜을 왜 쓰지? 다형성 때문이다. 다양한 클래스에서 이 동작을 처리할 수 있게 된다.그러면 어떻게 되겠나? 다른 클래스간의 결합도가 낮아지겠지!(다양한 클래스나 구조체에서 공통적인 작업을 요구할 때!!)


class ProfileFilterView: UIView {
  //MARK: - Properties
  
  weak var delegate: ProfileFilterViewDelegate?
  // 약한참조 weak : 참조하고 있는 객체를 소유하는 개념이 아니라서 참조하고 있는 객체가 메모리에서 해제가 되어도 자동으로 nil로 설정이 된다.
  //순환참조 문제를 방지하기 위해 사용
  //순환참조란? 두 객체가 참조를 할 때 메모리에서 해제되지 않고 계속해서 남아있게 되는 상황이다. 이를 방지하기 위해 weak를 해서 메모리 관리를 안전하게 한다.
  //nil처리: weak으로 선언된 속성은 가리키고 있던 객체가 메모리에서 해제가 되면, 자동으로 nil로 변환이 되기 때문에 옵셔널로 선언을 해준다.
  //그래서 delegate는 옵셔널 타입으로 선언을 해 준 것이다!
  //delegate를 통해서 다른 객체에거 특정한 작업을 위임할 수 있도록 설정.
  
  
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
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.filterView(self, didSelect: indexPath)
  }
}

//아이템이 선택되었을 때의 동작이나 스크롤등을 처리할 때 사용.
//didSelectItemAt : 아이템이 선택되었을 때 호출
//willDisplay:forItemAt: 셀이나 헤더/푸터가 화면에 나타나기 직전에 호출

//MARK - UICollectionViewDelegateFlowLayout
//컬렉셤 뷰 레이아웃을 커스터마이징 할 수 있는 부분이다.
//아이템 셀의 크기나 간격 등등을 설정해주는 것이 가능하다.
extension ProfileFilterView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: frame.width / 3, height: frame.height)
  }
  //각 컬렉션뷰 셀의 크기를 설정해주고 있다. IndexPath : 현재 크기를 설정할 아이템의 위치 정보.
  //frame.width의 3등분. 높이는 화면 전체.
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  //같은 행에 있는 셀들 사이의 최소 간격 설정.
  
}
