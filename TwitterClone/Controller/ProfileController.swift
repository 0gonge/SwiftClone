//
//  ProfileController.swift
//  TwitterClone
//
//  Created by 송여경 on 7/26/24.
//

import UIKit

private let reuseIdentifier = "TweetCell"

class ProfileController: UICollectionViewController {
  //MARK: - Properties
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
  }
  //MARK: - Helpers
  
  func configureCollectionView() {
    collectionView.backgroundColor = .white
    collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
  }
}
//MARK: - UICollectionViewDataSource

extension ProfileController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
    return cell
  }
}
//MARK: - UICollectionViewDelegateFlowLayout
extension ProfileController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.width, height: 300)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 120)
  }
}
