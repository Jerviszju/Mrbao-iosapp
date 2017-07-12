//
//  SignUpVC.swift
//  Mrbao
//
//  Created by boomboooom0v0 on 2017/6/17.
//  Copyright © 2017年 金鹏. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var avaImg: UIImageView!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var repeatPasswordTxt: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    let AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var myAuth: MyAuth!
    
    //根据需要，设置滚动视图的高度
    var scrollViewHeight: CGFloat = 0
    
    //获取虚拟键盘的大小
    var keyboard: CGRect = CGRect()

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxt.delegate = self
        passwordTxt.delegate = self
        repeatPasswordTxt.delegate = self
        //滚动视图的窗口尺寸
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        //定义滚动视图的内容视图尺寸与窗口尺寸一样
        scrollView.contentSize.height = self.view.frame.height
        scrollViewHeight = self.view.frame.height
        
        //检测键盘出现或消失的状态
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        //声明隐藏虚拟键盘的操作
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardTap))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        myAuth = AppDelegate.myAuth
    }
    @IBAction func signUpBtn_clicked(_ sender: Any) {
        print("注册按钮被按下")
        
        //隐藏keyboard
        self.view.endEditing(true)
        
        if emailTxt.text!.isEmpty || passwordTxt.text!.isEmpty || repeatPasswordTxt.text!.isEmpty {
            //弹出提示对话框
            let alert = UIAlertController(title: "请注意", message: "请填写好所有的字段", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //如果两次输入的密码不同
        if passwordTxt.text != repeatPasswordTxt.text {
            let alert = UIAlertController(title: "请注意", message: "两次输入的密码不一致", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
//        myAuth.signUpWithEmail(email: emailTxt.text!, password: passwordTxt.text!)

        Auth.auth().createUser(withEmail: emailTxt.text!, password: passwordTxt.text!) { (user, error) in
            if let error = error {
                if let errorCode = AuthErrorCode(rawValue: error._code) {
                    var errorMsg: String?
                    switch errorCode {
                    case AuthErrorCode.invalidEmail:
                        errorMsg = "注册失败，邮箱无效"
                        print("注册失败，邮箱无效")
                    case AuthErrorCode.emailAlreadyInUse:
                        errorMsg = "注册失败，邮箱已被使用"
                        print("注册失败，邮箱已被使用")
                    case AuthErrorCode.weakPassword:
                        errorMsg = "注册失败，密码强度太弱"
                        print("注册失败，密码强度太弱")
                    default:
                        errorMsg = "注册失败，请重试"
                        print("注册失败，请重试")
                        print(error.localizedDescription)
                    }
                    let alert = UIAlertController(title: "请注意", message: errorMsg!, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                UserDefaults.standard.set(self.emailTxt.text!, forKey: "emailTxt")
                UserDefaults.standard.synchronize()
                let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.login()
                print("注册成功")
            }
        }
//        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        AppDelegate.
    }
    
    @IBAction func cancelBtn_clicked(_ sender: Any) {
        print("取消按钮被按下")
        
        //以动画的方式除去通过modally方式添加进来的控制器
        self.dismiss(animated: true, completion: nil)
    }
    
    //当键盘出现或消失时调用的方法
    func showKeyboard(notification: Notification) {
        //定义keyboard大小
        let rect = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        keyboard = rect.cgRectValue
        
        //当虚拟键盘出现以后，将滚动视图的实际高度缩小为屏幕高度减去键盘的高度
        UIView.animate(withDuration: 0.4){
            self.scrollView.frame.size.height = self.scrollViewHeight - self.keyboard.size.height
        }
    }
    
    func hideKeyboard(notification: Notification) {
        //当虚拟键盘消失后，将滚动视图的实际高度改变为屏幕的高度值
        UIView.animate(withDuration: 0.4){
            self.scrollView.frame.size.height = self.view.frame.height
        }
    }
    
    //隐藏视图中的虚拟键盘
    func hideKeyboardTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.emailTxt.resignFirstResponder();
        self.passwordTxt.resignFirstResponder()
        self.repeatPasswordTxt.resignFirstResponder()
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
