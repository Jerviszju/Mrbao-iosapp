//
//  bannerViewController.swift
//  Mrbao
//
//  Created by jinpeng on 2017/5/3.
//  Copyright © 2017年 金鹏. All rights reserved.
//

import UIKit
import FirebaseAuth

@IBDesignable
class bannerViewController: UIViewController {


    let imageCount = 3
    var scrollView: UIScrollView!
    var pageView: UIPageControl!
    
    override func viewDidLoad() {
       // button.backgroundColor = UIColor.black
        super.viewDidLoad()
        //enterButton.backgroundColor = UIColor.black
        setupViews()
        //enterButton.frame = CGRect(x: (kScreenWidth * 2 + 100), y: 100, width: 100, height: 100)
        
    }
    
    func setupViews() {
        automaticallyAdjustsScrollViewInsets = false
        
        do {
            scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
            scrollView.delegate = self
            view.addSubview(scrollView)
        }
        
        do {
            pageView = UIPageControl(frame: CGRect(x: 0, y: kScreenHeight - 30, width: kScreenWidth, height: 30))
            //pageView.isHidden = true
            view.addSubview(pageView)
            pageView.numberOfPages = imageCount
            pageView.currentPage = 0
            pageView.pageIndicatorTintColor = UIColor.white
            pageView.currentPageIndicatorTintColor = UIColor.blue
        }
        
        do {
            /// 只使用3个UIImageView
            let imageView0 = UIImageView(frame: CGRect(x: CGFloat(0) * kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight))
            imageView0.image = UIImage(named: "0.png")
            
            scrollView.addSubview(imageView0)
            
            let imageView1 = UIImageView(frame: CGRect(x: CGFloat(1) * kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight))
            imageView1.image = UIImage(named: "1.png")
            scrollView.addSubview(imageView1)
            
            
            //最后一个imageview中添加一个button用于跳转到主页面
            let imageView2 = UIImageView(frame: CGRect(x: CGFloat(2) * kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight))
            imageView2.image = UIImage(named: "2.png")
            //button位置和大小
            let button = UIButton(frame: CGRect(x:kScreenWidth/2 - 50, y:kScreenHeight - 150, width: 100, height:40))
            //button背景颜色
            button.backgroundColor = UIColor(red: 0.53, green: 0.63, blue: 0.76, alpha: 1)
            button.setTitle("立即体验", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            //为button添加动作
            button.addTarget(self, action:#selector(tapped), for:.touchUpInside)
            //设置圆角
            button.layer.cornerRadius = 10
            imageView2.addSubview(button)
            imageView2.isUserInteractionEnabled = true
            scrollView.addSubview(imageView2)
            
        }
        
        do {
            //三个屏幕的宽度
            scrollView.contentSize = CGSize(width: kScreenWidth * 3, height: 0)
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
            scrollView.isPagingEnabled = true
            //隐藏滚动条
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
        }
    }
    func tapped(){
        // print("hello")
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let user = Auth.auth().currentUser
        var vc: UIViewController!
        if user == nil{
            vc = sb.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        } else{
            vc = sb.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        }
        //let vc = sb.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        
        self.present(vc, animated: true, completion: nil)
//        self.presentedViewController(TabViewController(), animated: true, completion: nil)
    }
}

extension bannerViewController: UIScrollViewDelegate {
    
    /// 开始滑动的时候，
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    /// 停止拖拽，判断当前位置，再判断offset位置，进行view切换
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if pageView.currentPage == 0{
            if scrollView.contentOffset.x > 0{
                scrollView.setContentOffset(CGPoint(x: kScreenWidth, y: 0), animated: true)
                pageView.currentPage = 1
                // print("page 0 - 1")
            }
        }
        else if pageView.currentPage == 1{
            if scrollView.contentOffset.x > kScreenWidth{
                scrollView.setContentOffset(CGPoint(x: kScreenWidth * 2, y: 0), animated: true)
                pageView.currentPage = 2
                // print("page 1 - 2")
            }
            else{
                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                pageView.currentPage = 0
                // print("page 1 - 0")
            }
        }
        else{
            if scrollView.contentOffset.x < 2*kScreenWidth{
                scrollView.setContentOffset(CGPoint(x: kScreenWidth, y: 0), animated: true)
                pageView.currentPage = 1
                // print("page 2 - 1")
            }
        }
       }
}
