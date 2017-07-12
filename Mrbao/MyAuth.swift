//
//  MyFAuth.swift
//  MyFirebaseSwift
//
//  Created by Albert Ray on 2017/6/5.
//  Copyright © 2017年 Albert Ray. All rights reserved.
//

import UIKit
import FirebaseAuth

class MyAuth {
    
    var user: User? = nil
    var authListenerHandle: AuthStateDidChangeListenerHandle? = nil
    
    // Attach the listener in the view controller's viewWillAppear method
    func addAuthListener() {
        authListenerHandle = Auth.auth().addStateDidChangeListener { (auth, user) in
            self.user = user
            if user != nil {
                print("用户已登陆")
            } else {
                print("用户未登录")
            }
        }
    }
    
    // Detach the listener in the view controller's viewWillDisappear method
    func removeAuthListener() {
        if authListenerHandle != nil {
            Auth.auth().removeStateDidChangeListener(authListenerHandle!)
        }
    }
    
    func signUpWithEmail(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                if let errorCode = AuthErrorCode(rawValue: error._code) {
                    switch errorCode {
                    case AuthErrorCode.invalidEmail:
                        print("注册失败，邮箱无效")
                    case AuthErrorCode.emailAlreadyInUse:
                        print("注册失败，邮箱已被使用")
                    case AuthErrorCode.weakPassword:
                        print("注册失败，密码强度太弱")
                    default:
                        print("注册失败，请重试")
                        print(error.localizedDescription)
                    }
                }
            } else {
                print("注册成功")
            }
        }
    }
    
    func signInWithEmail(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                if let errorCode = AuthErrorCode(rawValue: error._code) {
                    switch errorCode {
                    case AuthErrorCode.invalidEmail:
                        print("登录失败，邮箱无效")
                    case AuthErrorCode.wrongPassword:
                        print("登录失败，密码错误")
                    default:
                        print("登录失败，请重试")
                        print(error.localizedDescription)
                    }
                } else {
                    print("登录成功")
                }
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            print("退出成功")
        } catch {
            print("退出失败，请重试")
            print(error.localizedDescription)
        }
    }
    
    func getUserInformation() {
        if let user = user {
            print("User ID: \(user.uid)")
            print("User Name: \(String(describing: user.displayName))")
            print("User Email: \(String(describing: user.email))")
            print("User PhotoURL: \(String(describing: user.photoURL))")
        }
    }
    
    func updateUserEmail(email: String) {
        if let user = user {
            user.updateEmail(to: email) { (error) in
                if let error = error {
                    if let errorCode = AuthErrorCode(rawValue: error._code) {
                        switch errorCode {
                        case AuthErrorCode.emailAlreadyInUse:
                            print("更新失败，邮箱已被使用")
                        case AuthErrorCode.invalidEmail:
                            print("更新失败，邮箱无效")
                        case AuthErrorCode.requiresRecentLogin:
                            print("敏感操作更改需要重新登录一次，请先退出并重新登录")
                        default:
                            print("更新失败，请重试")
                            print(error.localizedDescription)
                        }
                    }
                } else {
                    print("更新成功")
                }
            }
        }
    }
    
    func updateUserPassword(password: String) {
        if let user = user {
            user.updatePassword(to: password) { (error) in
                if let error = error {
                    if let errorCode = AuthErrorCode(rawValue: error._code) {
                        switch errorCode {
                        case AuthErrorCode.weakPassword:
                            print("更新失败，密码强度太弱")
                        case AuthErrorCode.requiresRecentLogin:
                            print("敏感操作更改需要重新登录一次，请先退出并重新登录")
                        default:
                            print("登录失败，请重试")
                            print(error.localizedDescription)
                        }
                    }
                } else {
                    print("更新成功")
                }
            }
        }
    }
    
    func updateUserName(name: String) {
        if let user = user {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = name
            changeRequest.commitChanges { (error) in
                if let error = error {
                    print("登录失败，请重试")
                    print(error.localizedDescription)
                } else {
                    print("更新成功")
                }
            }
        }
    }
    
    func updateUserPhotoURL(photoURL: URL) {
        if let user = user {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.photoURL = photoURL
            changeRequest.commitChanges { (error) in
                if let error = error {
                    print("登录失败，请重试")
                    print(error.localizedDescription)
                } else {
                    print("更新成功")
                }
            }
        }
    }
    
    func deleteUser() {
        if let user = user {
            user.delete { (error) in
                if let error = error {
                    if let errorCode = AuthErrorCode(rawValue: error._code) {
                        switch errorCode {
                        case AuthErrorCode.requiresRecentLogin:
                            print("敏感操作需要重新登录一次，请先退出并重新登录")
                        default:
                            print("删除账号失败，请重试")
                            print(error.localizedDescription)
                        }
                    }
                } else {
                    print("删除账号成功")
                }
            }
        }
    }
    
    func sendEmailVerification() {
        if let user = user {
            user.sendEmailVerification { (error) in
                if let error = error {
                    print("发送邮件失败")
                    print(error.localizedDescription)
                } else {
                    print("发送邮件成功")
                }
            }
        }
    }
}
