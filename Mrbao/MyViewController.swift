//
//  MyViewController.swift
//  Mrbao
//
//  Created by jinpeng on 2017/6/16.
//  Copyright © 2017年 金鹏. All rights reserved.
//

import UIKit
import FirebaseAuth

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createIcon()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOut(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.out()
            print("退出成功")
        } catch {
            print("退出失败，请重试")
            print(error.localizedDescription)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func createIcon(){
        let iconImageView = UIImageView(frame: CGRect(x: kScreenWidth/2 - 40, y: 60, width: 80, height: 80))
        iconImageView.backgroundColor = UIColor.red
        iconImageView.image = UIImage(named: "icon.jpeg")
        self.view.addSubview(iconImageView)
        let label = UILabel(frame: CGRect(x: kScreenWidth/2 - 80, y: 140, width: 160, height: 40))
        label.text = "头疼离婚的小包"
        label.textAlignment = .center
        self.view.addSubview(label)
        //用圆角设置头像为圆形
        let imageLayer: CALayer = iconImageView.layer
        imageLayer.masksToBounds = true
        imageLayer.cornerRadius = iconImageView.frame.size.height/2
        imageLayer.borderWidth = 2
        
    }

    @IBAction func unwindToMyView(sender: UIStoryboardSegue) {
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
