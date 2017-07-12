//
//  TableDetailViewController.swift
//  Mrbao
//
//  Created by jinpeng on 2017/6/15.
//  Copyright © 2017年 金鹏. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class TableDetailViewController: UIViewController {
    
    @IBOutlet weak var detailTxt: UITextView!
    
    @IBOutlet weak var collectionTxt: UIBarButtonItem!

    @IBOutlet var leftBarButton: UIBarButtonItem!
    
    @IBOutlet var content: UITextView!
    
    @IBOutlet var detail: UITextView!
    
    @IBOutlet var hiddenbutton: UIBarButtonItem!
    var myTableList : tablelist? = nil
    
    @IBAction func hidden(_ sender: Any) {
        if detail.isHidden == true{
            detail.isHidden = false
            hiddenbutton.image = UIImage(named: "icon21")
        }
        else{
            detail.isHidden = true
            hiddenbutton.image = UIImage(named: "icon22")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        leftBarButton.title = " < " + (myTableList?.title)!
        content.text = myTableList?.content
        detail.text = myTableList?.detail
        self.view.bringSubview(toFront: detail)
        // Do any additional setup after loading the view.
//        hiddenbutton.addTarget(self, action: #selector(hiddenBtnClick(sender:)), for:
//            .touchUpInside)
        customEditMenu()
    }
    
    var ref: DatabaseReference? = Database.database().reference(withPath: "notes") // 路径的引用

    func hiddenBtnClick(sender:UIButton?){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //添加笔记
    func customEditMenu() {
        let menuItem = UIMenuItem(title: "记笔记", action: #selector(addNote))
        UIMenuController.shared.menuItems = [menuItem]
    }
    
    func addNote() {
        if let range = detailTxt.selectedTextRange, let selectedText = detailTxt.text(in: range) {
            if let ref = ref {
                let user = Auth.auth().currentUser
                ref.child((user?.uid)!).child("\(Int(Date().timeIntervalSince1970))").setValue(selectedText)
            }
            print(selectedText)
        }
    }
    
    var refCollection: DatabaseReference? = Database.database().reference(withPath: "collection") // 路径的引用
    @IBAction func collection(_ sender: UIBarButtonItem) {
            if let refCollection = refCollection, let title = collectionTxt.title {
                let user = Auth.auth().currentUser
                refCollection.child((user?.uid)!).child(title.substring(from: title.index(title.startIndex, offsetBy: 3))).setValue("\(Int(Date().timeIntervalSince1970))")
            }
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
