//
//  ProfileHeader.swift
//  TwitterClone
//
//  Created by 송여경 on 8/19/24.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
  //MARK: - Properties
  
  var user: User? {
    didSet { configure() }
  }
  //user는 사용자의 데이터를 보유하는 중요한 역할을 한다.
  //사용자 프로필 정보를 업데이트 할 때 사용한다.
  //user속성의 값이 설정되거나 변경될 때마다 didSet실행되어 configure()메서드를 호출한다.
  //즉, user의 값이 변경될 때마다 자동으로 뷰를 업데이트 하는 것이 가능해진다.
  //configure - 유저 속성의 데이터를 뷰에 반영해준다.
  //내가 ViewModel에서 적용해준 것 들을 follwerString, 과 같은 데이터들을 이 메서드에서 사용해줄 수 있는 것이다.
  
  private let filterBar = ProfileFilterView()
  
  private lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .twitterBlue
    
    view.addSubview(backButton)
    backButton.anchor(top: view.topAnchor, left: view.leftAnchor,
                      paddingTop: 42, paddingLeft: 16)
    backButton.setDimensions(width: 30, height: 30)
    
    return view
  }()
  //네비게이션 바를 없애주기로 햇기 때문에 커스텀 해서 만들어줘야 한다.
  
  private lazy var backButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "baseline_arrow_back_white_24dp")?.withRenderingMode(.alwaysOriginal), for: .normal)
    button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
    return button
  }()
  
  private let profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.clipsToBounds = true
    iv.backgroundColor = .lightGray
    iv.layer.borderColor = UIColor.white.cgColor
    iv.layer.borderWidth = 4
    return iv
  }()
  //초기화는 클로저를 통해 실행이 되고 클로저의 결과가 porfileImageView에 할당된다.
  // iv는 클로저 내에서 사용해 줄 임의의 변수
  // clipsToBounds는 이미지뷰의 경계를 넘는 부분을 자를지의 여부다.
  // 이미지가 로드되지 않았을 때를 위한 backgroundColor
  // layer.borderColor는 cgColor를 요구한다.
  private lazy var editProfileFollowButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Loading", for: .normal)
    //상태에 따라서 바뀌어야 함
    button.layer.borderColor = UIColor.twitterBlue.cgColor
    button.layer.borderWidth = 1.25
    button.setTitleColor(.twitterBlue, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.addTarget(self, action: #selector(handleEditProfileFollow), for: .touchUpInside)
    return button
  }()
  
  private let fullnameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.text = "Song YeoGyeong"
    return label
  }()
  
  private let usernameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .lightGray
    label.text = "@0gonge"
    return label
  }()
  
  private let bioLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    label.numberOfLines = 3
    //세줄 이상 XX
    label.text = "This is a user bio that will span more than one line for test purposes"
    return label
  }()
  
  private let underlineView: UIView = {
    let view = UIView()
    view.backgroundColor = .twitterBlue
    return view
  }()
  
  private let followingLabel: UILabel = {
    let label = UILabel()
    
    label.text = "0 Following"
    
    let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowesTapped))
    label.isUserInteractionEnabled = true
    //이부분은 레이블이 사용자의 인터랙션을 받을 수 있도록 허용해주는 것이다.
    //기본적으로 UILabel은 사용자의 인터렉션을 받지 않기 때문에 이를 활성화 시켜주려면 이렇게 허용을 해 주어야 한다.
    //Gesture인식이 가능해진다.
    label.addGestureRecognizer(followTap)
    //앞에서 생성해준 followTab을 followingLabel에 추가를 해준다.
    //사용자가 레이블 탭햇을 때 followTap이 동작, 버튼 정의해준 액션이 실행됨
    return label
  }()
//UITapGestureRecongnizer: 사용자가 특정 부분을 탭했을 때 이를 감지해준다.
  //동작이 발생했을 때 호출할 메서드가 속한 객체 저장. self
  //사용자가 레이블을 탭했을 때 실행될 메서드 지정
  
  private let followersLabel: UILabel = {
    let label = UILabel()
    
    label.text = "2 Followers"
    
    let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFolloingTapped))
    label.addGestureRecognizer(followTap)
    
    return label
  }()
  
  //MARK: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    filterBar.delegate = self
    
    addSubview(containerView)
    containerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 108)
    
    addSubview(profileImageView)
    profileImageView.anchor(top: containerView.bottomAnchor, left: leftAnchor, paddingTop: -24, paddingLeft: 8)
    profileImageView.setDimensions(width: 80, height: 80)
    profileImageView.layer.cornerRadius = 80/2
    
    addSubview(editProfileFollowButton)
    editProfileFollowButton.anchor(top: containerView.bottomAnchor, right: rightAnchor, paddingTop: 12, paddingRight: 12)
    editProfileFollowButton.setDimensions(width: 100, height: 36)
    editProfileFollowButton.layer.cornerRadius = 36 / 2
    
    let userDetailsStack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel, bioLabel])
    userDetailsStack.axis = .vertical
    userDetailsStack.distribution = .fillProportionally
    //distribution = 남는 공간 어떻게 할래?
    //fillProportionally = 하위 뷰들이 자신들의 비율에 맞춰서 공간을 차지하게 만듬
    //각각의 뷰가 자신의 고유 크기에 비례해서 스택뷰에서 공간을 지정해주는 느낌이라고 생각하자.
    // 각각 뷰의 텍스트 길이가 다르기 때문에 설정해주는 옵션이라고 생각하자. 같은 크기 X
    userDetailsStack.spacing = 4
    
    addSubview(userDetailsStack)
    userDetailsStack.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop:8, paddingLeft: 12, paddingRight: 12)
    
    let followStack = UIStackView(arrangedSubviews: [followingLabel, followersLabel])
    followStack.axis = .horizontal
    followStack.spacing = 8
    followStack.distribution = .fillEqually
    
    addSubview(followStack)
    followStack.anchor(top: userDetailsStack.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 12)
    
    addSubview(filterBar)
    filterBar.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
    
    addSubview(underlineView)
    underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, width: frame.width/3, height: 2)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  //MARK: -
  @objc func handleDismissal() {
    
  }
  
  @objc func handleEditProfileFollow() {
    
  }
  
  @objc func handleFollowesTapped() {
    
  }
  @objc func handleFolloingTapped() {
    
  }
  
  //MARK: - Helpers
  
  func configure() {
    guard let user = user else { return }
    //user가 있는지 없는지를 판단.
    //user가 nil이면 실행을 중단하고, nil이 아니면 아래 코드 계속
    //user가 nil일 경우, 더이상 UI업데이트가 필요하지 않으므로 return으로 함수 그냥 종료
    let viewModel = ProfileHeaderViewModel(user: user)
    //user데이터를 사용해서 profileHeaderViewModel 인스턴스를 생성해주는 부분이다.
    //viewModel을 사용하면, ProfileHeader에서 user데이터를 직접 처리하지 않고, 뷰모델을 통해서 간접적으로 데이터를 처리해준다.
    
    followingLabel.attributedText = viewModel.followerString
    followersLabel.attributedText = viewModel.followerString
    //viewModel에서 생성한 followingString을 attrivutedText에 할당해줌.
  }
  
}
//MARK: - ProfileFilterViewDelegate

extension ProfileHeader: ProfileFilterViewDelegate {
  func filterView(_ view: ProfileFilterView, didSelect IndexPath: IndexPath) {
    guard let cell = view.collectionView.cellForItem(at: IndexPath) as? ProfileFilterCell else {return}
    //사용자가 ProfileFilterView에서 특정 셀을 선택했을 때 호출
    //guard : 조건이 충족되지 않으면 메서드를 종료해줌. 그렇기 때문에 profileFilterCell이 캐스팅되지 않으면, nil을 반환을 해주고 else블록이 실행되면서 return으로 매서드를 종료한다.
    //프로토콜과 extension의 조합!!
    
    let xPosition = cell.frame.origin.x
    UIView.animate(withDuration: 0.3) {
      self.underlineView.frame.origin.x = xPosition
    }
    //선택된 셀을 가져와서 그 셀의 정보를 활용
    //선택된 셀의 x축 좌표를 가져온다.
    //cell.frame.origin.x: 선택된 셀의 프레임에서 X축의 시작 위치를 가져옴 즉, 셀의 좌측 상단이 화면에서 어느 위치에 있는지 반환
    //이 값을 이용해 나중에 underlineView의 위치를 해당 셀의 아래로 이동
    //underlineView의 X축 위치를 선택된 셀 아래로 부드럽게 이동시키는 애니메이션을 실행
    //0.3초의 간격으로 셀 아래로 부드럽게 이동.
    //underlineView를 x축 위치를 선택된 셀의 x축 좌표로 설정한다. 즉, 선택된 셀 바로 아래로 underlineView가 이동. 
    //self가 뭐지 ㅋㅋ 클로저 내부에서 현재 클래스의 속성에 접근 할 때 self를 명시적으로 사용해야 한다. 인스턴스가 클로저 내부에서 사용이 됨을 명확이 해주는 것임!
    //클래스 내부에서 속성과 메서드가 이름 충돌할 때: 메서드 내부에서 메서드 파라미터 이름과 클래스 속성 이름이 동일할 때, self를 사용하여 클래스의 속성임을 구분
    //self.underlineView라고 명시하지 않으면, 컴파일러는 이 속성이 현재 인스턴스의 속성임을 알지 못함
  }
  //profileFilterView에서 셀이 선택되었을 때의 동작을 정의해주고 있는 부분이다.
  // ProfileHeader 클래스에 ProfileFilterViewDelegate 프로토콜(이건 FilterView에 프로토콜을 구현해두었음)을 채택하고, 그 프로토콜의 메서드를 구현
}

