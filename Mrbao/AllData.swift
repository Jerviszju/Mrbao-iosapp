//
//  AllData.swift
//  test？
//
//  Created by jinpeng on 2017/6/14.
//  Copyright © 2017年 金鹏. All rights reserved.
//

import UIKit

class scene{
    var title :String = ""
    var detailscenes = [detailscene]()
    init(){
        
    }
    init?(title :String,detailscenes:[detailscene]){
        self.title=title
        self.detailscenes=detailscenes
    }
}

class detailscene{
    var title :String = ""
    var tablelists = [tablelist]()
    init(){
        
    }
    init?(title:String,tablelists:[tablelist]){
        self.title=title
        self.tablelists=tablelists
    }
}
class tablelist{
    var title :String = ""
    var content: String = ""
    var detail: String = ""
    init(){
        
    }
    init?(title:String, content:String, detail:String){
        self.title = title
        self.content = content
        self.detail = detail
    }
    
}
