//
//  CaseDetailViewController.swift
//  Mrbao
//
//  Created by Albert Ray on 2017/5/18.
//  Copyright © 2017年 金鹏. All rights reserved.
//

import UIKit

class CaseDetailViewController: UIViewController {

    @IBOutlet var leftBarButton: UIBarButtonItem!
    
    @IBOutlet var mytitle: UILabel!

    @IBOutlet var img: UIImageView!
    
    @IBOutlet var content: UITextView!

    var mycase :Case? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mytitle.text = mycase?.title
        img.image = mycase?.img
        content.text = mycase?.content
        
    }
    

}
