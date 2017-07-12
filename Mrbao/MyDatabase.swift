//
//  MyDatabase.swift
//  MyFirebaseSwift
//
//  Created by Albert Ray on 2017/6/5.
//  Copyright © 2017年 Albert Ray. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MyDatabase {
    // MARK: 属性
    
    var ref: DatabaseReference? = nil // 路径的引用
    
    // MARK: 构造函数
    
    init(path: String) { // 获取引用的路径
        ref = Database.database().reference(withPath: path)
    }
    
    // MARK: 事件监听
    
    func addListenerForValue(path: String = "/") { // 添加监听器（监听所有变化）
        if let ref = ref {
            ref.child(path).observe(DataEventType.value, with: { (snapshot) in
                print(snapshot)
                // 处理数据
            })
        }
    }

    func addListenerForChange(path: String = "/") { // 添加监听器（监听值变化）
        if let ref = ref {
            ref.child(path).observe(DataEventType.childChanged, with: { (snapshot) in
                print(snapshot)
                // 处理数据
            })
        }
    }
    
    func addListenerForAdd(path: String = "/") { // 添加监听器（监听添加）
        if let ref = ref {
            ref.child(path).observe(DataEventType.childAdded, with: { (snapshot) in
                print(snapshot)
                // 处理数据
            })
        }
    }
    
    func addListenerForRemove(path: String = "/") { // 添加监听器（监听移除）
        if let ref = ref {
            ref.child(path).observe(DataEventType.childRemoved, with: { (snapshot) in
                print(snapshot)
                // 处理数据
            })
        }
    }
    
    func removeListener(path: String = "/") {// 移除所有监听器
        if let ref = ref {
            ref.child(path).removeAllObservers()
        }
    }
    
    func read(path: String = "/") { // 读取一次，不会保持监听
        if let ref = ref {
            ref.child(path).observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                print(snapshot)
                // 处理数据
            })
        }
    }
    
    // MARK: 更新数据
    
    func updateSinglePath(path: String, value: Any) { // 更新单路径
        if let ref = ref {
            ref.child(path).setValue(value)
        }
    }
    
    func updateMultiplePath(content: [String: Any]) { // 更新多路径
        if let ref = ref {
            ref.updateChildValues(content)
        }
    }
    
    // MARK: 排序和过滤
    /*
     默认升序
     ref.child(path).queryOrderByKey.observe
     ref.child(path).queryOrderByValue.observe
     ref.child(path).queryOrderByChild.observe
     过滤
     ref.child(path).queryLimitedToFirst.observe
     ref.child(path).queryLimitedToLast.observe
     ref.child(path).queryLimitedStartingAtValue.observe
     ref.child(path).queryLimitedEndingAtValue.observe
     ref.child(path).queryLimitedEqualToValue.observe
     */
}
