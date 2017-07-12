//
//  SignInVC.swift
//  Mrbao
//
//  Created by boomboooom0v0 on 2017/6/17.
//  Copyright © 2017年 金鹏. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInVC: UIViewController,UITextFieldDelegate {
    let AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var myAuth: MyAuth!
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var forgetBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTxt.delegate = self
        self.passwordTxt.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        myAuth = AppDelegate.myAuth
        //myAuth.addAuthListener()

    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        myAuth.removeAuthListener()
//    }
    
    @IBAction func signInBtn_clicked(_ sender: UIButton) {
        print("登录按钮被单击")
        
        //隐藏键盘
        self.view.endEditing(true)
        
        if emailTxt.text!.isEmpty || passwordTxt.text!.isEmpty {
            let alert = UIAlertController(title: "请注意", message: "请填写好所有的字段", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
//        myAuth.signInWithEmail(email: emailTxt.text!, password: passwordTxt.text!)
        Auth.auth().signIn(withEmail: emailTxt.text!, password: passwordTxt.text!) { (user, error) in
            if let error = error {
                if let errorCode = AuthErrorCode(rawValue: error._code) {
                    var errorMsg: String?
                    switch errorCode {
                    case AuthErrorCode.invalidEmail:
                        errorMsg = "登录失败，邮箱无效"
                        print("登录失败，邮箱无效")
                    case AuthErrorCode.wrongPassword:
                        errorMsg = "登录失败，密码错误"
                        print("登录失败，密码错误")
                    default:
                        errorMsg = "登录失败请重试"
                        print("登录失败，请重试")
                        print(error.localizedDescription)
                    }
                    let alert = UIAlertController(title: "请注意", message: errorMsg!, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else {
                UserDefaults.standard.set(self.emailTxt.text!, forKey: "emailTxt")
                UserDefaults.standard.synchronize()
                let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.login()
                print("登录成功")
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.emailTxt.resignFirstResponder();
        self.passwordTxt.resignFirstResponder()
        return true;
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
