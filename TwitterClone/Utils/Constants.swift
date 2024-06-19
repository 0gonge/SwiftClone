//
//  Constants.swift
//  TwitterClone
//
//  Created by 송여경 on 6/20/24.
//

import Firebase
import FirebaseStorage

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let DB_REF = Database.database().reference()
//글로벌 변수 이면서도 글로벌이 아니다. 응용 프로그램들은 글로벌 변수를 멀리 하고자 한다.
//얘는 상수이기 때문에 내가 이 상수 파일을 만들어 준 이유는 이 상수들을 글로벌 처럼 사용하고자 했기 때문이다.
let REF_USERS = DB_REF.child("users")
//user에 접근하고 싶을 때 마다 사용될 수 있겠다.
//나는 _ 로 단어들을 분리해주고자 한다. - 변수명

