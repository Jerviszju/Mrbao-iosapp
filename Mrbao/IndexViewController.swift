//
//  SearchViewController.swift
//  Mrbao
//
//  Created by jinpeng on 2017/5/5.
//  Copyright © 2017年 金鹏. All rights reserved.
//

import UIKit

class IndexViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var scenes = [scene]()
    
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var remen: UIButton!
    @IBOutlet weak var xinfa: UIButton!
    @IBOutlet weak var xinwen: UIButton!
    @IBAction func xinwenac(_ sender: UIButton) {
        let space:CGFloat = 2
        xinwen.setNeedsLayout()
        xinwen.layoutIfNeeded()
        
        let border = CALayer()
        border.backgroundColor = UIColor.black.cgColor
        border.frame = CGRect(x:0,y:(xinwen.titleLabel?.frame.size.height)!+space,width:(xinwen.titleLabel?.frame.size.width)!,height:1)
        xinwen.titleLabel?.layer.addSublayer(border)
        if (remen.titleLabel?.layer.sublayers?.count)! > 1{
            remen.titleLabel?.layer.sublayers?.remove(at: (remen.titleLabel?.layer.sublayers?.count)! - 1)
        }
        
        if (xinfa.titleLabel?.layer.sublayers?.count)! > 1{
            xinfa.titleLabel?.layer.sublayers?.remove(at: (xinfa.titleLabel?.layer.sublayers?.count)! - 1)
        }

        
    }
    @IBAction func xinfaac(_ sender: UIButton) {
        let space:CGFloat = 2
        xinfa.setNeedsLayout()
        xinfa.layoutIfNeeded()
        
        let border = CALayer()
        border.backgroundColor = UIColor.black.cgColor
        border.frame = CGRect(x:0,y:(xinfa.titleLabel?.frame.size.height)!+space,width:(xinfa.titleLabel?.frame.size.width)!,height:1)
        xinfa.titleLabel?.layer.addSublayer(border)
        
        if (remen.titleLabel?.layer.sublayers?.count)! > 1{
            remen.titleLabel?.layer.sublayers?.remove(at: (remen.titleLabel?.layer.sublayers?.count)! - 1)
        }
        if (xinwen.titleLabel?.layer.sublayers?.count)! > 1{
            xinwen.titleLabel?.layer.sublayers?.remove(at: (xinwen.titleLabel?.layer.sublayers?.count)! - 1)
        }
    }
    @IBAction func remenac(_ sender: UIButton) {
        let space:CGFloat = 2
        remen.setNeedsLayout()
        remen.layoutIfNeeded()
        
        let border = CALayer()
        border.backgroundColor = UIColor.black.cgColor
        border.frame = CGRect(x:0,y:(remen.titleLabel?.frame.size.height)!+space,width:(remen.titleLabel?.frame.size.width)!,height:1)
        remen.titleLabel?.layer.addSublayer(border)
        if (xinwen.titleLabel?.layer.sublayers?.count)! > 1{
            xinwen.titleLabel?.layer.sublayers?.remove(at: (xinwen.titleLabel?.layer.sublayers?.count)! - 1)
        }

        if (xinfa.titleLabel?.layer.sublayers?.count)! > 1{
            xinfa.titleLabel?.layer.sublayers?.remove(at: (xinfa.titleLabel?.layer.sublayers?.count)! - 1)
        }
    }
    //所有搜索结果
        //当前搜索结果
    var searchList = [tablelist?]()
    var result = [tablelist?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubview(toFront: tableView)
        // 搜索内容为空时，显示全部内容
        self.result = self.searchList
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //显示搜索栏默认文字
        self.searchBar.placeholder = "搜索"
        //初始状态下
        tableView.isHidden = true
        //显示取消按钮
        self.searchBar.showsCancelButton = true
        
        //右侧显示一本小书，可用于显示历史记录，暂且不用
        //self.searchBar.showsBookmarkButton = true
        
        // 注册tableviewCell
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //self.view.backgroundColor = UIColor.clear
        loadSamples()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print("[ViewController searchBar] searchText: \(searchText)")
        //开始搜索时显示table
        tableView.isHidden = false
        // 没有搜索内容时显示全部内容
        if searchText == "" {
            self.result = self.searchList
            tableView.isHidden = true
            
        } else {
            
            // 匹配用户输入的前缀，不区分大小写
            self.result = []
            
            for arr in self.searchList {
                
                if (arr?.title.lowercased().hasPrefix(searchText.lowercased()))! {
                    self.result.append(arr)
                }
            }
        }
        
        // 刷新tableView 数据显示
        self.tableView.reloadData()
    }
    
    // 搜索触发事件，点击虚拟键盘上的搜索按钮时触发此方法
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //隐藏键盘
        searchBar.resignFirstResponder()
    }
    
    // 书签按钮触发事件，暂时不用
//    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
//        
//        print("搜索历史")
//    }
    
    
    // 取消按钮触发事件
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // 搜索内容置空
        searchBar.text = ""
        self.result = self.searchList
        self.tableView.reloadData()
        self.tableView.isHidden = true
        //隐藏键盘
        searchBar.resignFirstResponder()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identify: String = "cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath) as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.text = self.result[indexPath.row]?.title
        
        return cell
    }
    
    func searchBarSearchButtonClicked() {
        print("7 searchBarSearchButtonClicked")
        
        searchBar.endEditing(true)
    }
    
    
    @IBAction func unwindToIndexView(sender: UIStoryboardSegue) {
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier ?? "" == "ShowSearchResult" {
            guard let selectedCell = sender as? UITableViewCell else{
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let mySearchResult = segue.destination as? TableDetailViewController else {
                fatalError("searchResult open wrong")
            }
            guard let indexPath = tableView.indexPath(for: selectedCell) else{
                fatalError("The selected cell is not being displayed by the table")
            }
            
            mySearchResult.myTableList? = result[indexPath.row]!
        }
        
        if segue.identifier ?? "" == "OpenScene1" {
            
            guard let mySceneViewController = segue.destination as? SceneViewController else {
                fatalError("Unexpected: 2")
            }
            mySceneViewController.myscene = scenes[0]
            
        }
        if segue.identifier ?? "" == "OpenScene2" {
            
            guard let mySceneViewController = segue.destination as? SceneViewController else {
                fatalError("Unexpected: 2")
            }
            mySceneViewController.myscene = scenes[0]
            
        }
        if segue.identifier ?? "" == "OpenScene3" {
            
            guard let mySceneViewController = segue.destination as? SceneViewController else {
                fatalError("Unexpected: 2")
            }
            mySceneViewController.myscene = scenes[0]
            
        }
        if segue.identifier ?? "" == "OpenScene4" {
            
            guard let mySceneViewController = segue.destination as? SceneViewController else {
                fatalError("Unexpected: 2")
            }
            mySceneViewController.myscene = scenes[0]
            
        }
        if segue.identifier ?? "" == "OpenScene5" {
            
            guard let mySceneViewController = segue.destination as? SceneViewController else {
                fatalError("Unexpected: 2")
            }
            mySceneViewController.myscene = scenes[0]
            
        }
        if segue.identifier ?? "" == "OpenScene6" {
            
            guard let mySceneViewController = segue.destination as? SceneViewController else {
                fatalError("Unexpected: 2")
            }
            mySceneViewController.myscene = scenes[0]
            
        }
        if segue.identifier ?? "" == "OpenScene7" {
            
            guard let mySceneViewController = segue.destination as? SceneViewController else {
                fatalError("Unexpected: 2")
            }
            mySceneViewController.myscene = scenes[0]
            
        }
        if segue.identifier ?? "" == "OpenScene8" {
            
            guard let mySceneViewController = segue.destination as? SceneViewController else {
                fatalError("Unexpected: 2")
            }
            mySceneViewController.myscene = scenes[0]
            
        }
        
        
    }
    
    private func loadSamples(){
        var 房产分割 = [tablelist?]()
        let 房产分割1 = tablelist(title: "离婚后房子归谁", content: "现在许多新婚夫妻或者已经结婚多年的夫妻，在买房时都很注意这个问题。当夫妻走到最后，有孩子的，除了孩子的抚养权问题，财产分割问题应该就是双方最关心的了，那么离婚财产分割遵循的原则是什么呢？\n 一、男女平等原则。\n 男女平等原则既反映在《婚姻法》的各条法律规范中，又是人民法院处理婚姻家庭案件的办案指南。该原则体现在离婚财产分割上，就是夫妻双方有平等地分割共同财产的权利，平等地承担共同债务的义务；\n 二、照顾子女和女方利益原则。\n 这里的“照顾”，既可以在财产份额上给予女方适当多分，也可以在财产种类上将某项生活特别需要的财产，比如住房，分配给女方。毕竟从习惯势力上、从传统因素的影响所造成的障碍上、从妇女的家务负担、生理特点上讲，离婚后一般妇女在寻找工作和谋生能力上也较男子要弱，更需要社会给予更多的帮助。同时，在分割夫妻共同财产时，要特别注意保护未成年人的合法财产权益。未成年人的合法财产不能列入夫妻共同财产进行分割；", detail: "三、有利生活，方便生活原则。\n 在离婚分割共同财产时，不应损害财产效用、性能和经济价值。在对共同财产中的生产资料进行分割时，应尽可能分给需要该生产资料、能更好发挥该生产资料效用的一方；在对共同财产中的生活资料进行分割时，要尽量满足个人从事专业或职业需要，以发挥物的使用价值。不可分物按实际需要和有利发挥效用原则归一方所有，分得方应依公平原则，按离婚时的实际价值给另一方相应的补偿；")
        let 房产分割2 = tablelist(title: "婚后一方父母全额出资给子女买房", content: "夫妻一方用婚前财产以个人名义按揭贷款购买房屋，并且已经取得产权证，结婚登记以后还贷或继续还贷的，其产权仍属于一方婚前个人财产，购房人对其所购房屋依法享有所有者权益。", detail: "值得说明的是，婚后还贷的部分，无论是由一方用自己的工资、收益还贷，还是用双方的工资、收益还贷，只要不能证明是用一方的婚前财产或者婚后专属于一方个人所有的财产还贷，都应视为以夫妻共同财产清偿贷款。因此，离婚时应将一方婚前购买的按揭房判归买房者所有，同时应当将夫妻所共同偿还贷款中属于配偶一方清偿的部分予以返还。\n 按揭贷款属于购房一方个人债务，婚后另一方参与还贷的行为也是在为房屋产权的取得做贡献，但从法律层面来分析，婚后双方共同还贷仅仅是在偿还银行的债务，属于用夫妻共同财产偿还了一方的个人债务，与房屋产权的归属是两个不同的法律关系，婚后双方共同还贷并不能改变按揭房屋属于个人财产的法律性质。")
        let 房产分割3 = tablelist(title: "婚前房产婚后共同还贷", content: "婚姻法第十九条规定，夫妻可以约定婚姻关系存续期间所得的财产以及婚前财产归各自所有、共同所有或部分各自所有、部分共同所有。约定应当采用书面形式。没有约定或约定不明确的，适用本法第十七条、第十八条的规定。", detail: "夫妻对婚姻关系存续期间所得的财产以及婚前财产的约定，对双方具有约束力。\n 夫妻对婚姻关系存续期间所得的财产约定归各自所有的，夫或妻一方对外所负的债务，第三人知道该约定的，以夫或妻一方所有的财产清偿。\n 婚前财产属于个人所有，离婚后，应当先区分财产是否属于共同财产，若是属于共同财产，则双方约定分配比例，一般原则上是一人一半。若确定了是个人财产，是不能要求分割的。")
        
        let 房产分割4 = tablelist(title: "家暴离婚财产分割有哪些方面？", content:"（一）双方协商决定。\n 依《婚姻法》第三十九条第一款的规定：离婚时，夫妻的共同财产由双方协商处理，也就是说，离婚时夫妻对财产的分割，双方应在协商一致的原则下进行，不能由一方决定。\n（二）男女平等。\n 依《婚姻法》第二条第一款的规定男女平等的原则，不能歧视妇女，不能认为妇女挣的少，就应少分，在离婚分割夫妻共同财产时，应尊重妇女的权利，保护妇女权利。\n（三）照顾子女和女方权益。\n 依《婚姻法》第三十九条第二款的规定协商不成时，由人民法院根据财产的具体情况，以照顾子女和女方权益的原则判决。" , detail: "依《婚姻法》第三十九条第二款的规定协商不成时，由人民法院根据财产的具体情况，以照顾子女和女方权益的原则判决。\n 根据我国婚姻法及其司法解释的规定，离婚财产分割时，参照照顾无过错方的原则分割财产。婚姻法规定，过错是指有重婚、有配偶者与他人同居的、家庭暴力的、虐待遗弃家庭成员的。在离婚诉讼中，因过错方的行为导致夫妻离婚时，过错方应对无过错方给予民事赔偿。")
        房产分割 += [房产分割1,房产分割2,房产分割3,房产分割4]
        
        
        let 房产分割scene = detailscene(title: "房产分割", tablelists: 房产分割 as! [tablelist])
        let 净身出户scene = detailscene(title: "房产分割", tablelists: 房产分割 as! [tablelist])
        let 婚前财产分割scene = detailscene(title: "房产分割", tablelists: 房产分割 as! [tablelist])
        let 共同财产scene = detailscene(title: "房产分割", tablelists: 房产分割 as! [tablelist])
        let 不愿意离婚scene = detailscene(title: "房产分割", tablelists: 房产分割 as! [tablelist])
        let 夫妻感情破裂scene = detailscene(title: "房产分割", tablelists: 房产分割 as! [tablelist])
        let 离婚赔偿scene = detailscene(title: "房产分割", tablelists: 房产分割 as! [tablelist])
        let 彩礼返还scene = detailscene(title: "房产分割", tablelists: 房产分割 as! [tablelist])
        let 孩子归谁抚养scene = detailscene(title: "房产分割", tablelists: 房产分割 as! [tablelist])
        let 子女抚养费scene = detailscene(title: "房产分割", tablelists: 房产分割 as! [tablelist])
        let 变更抚养权scene = detailscene(title: "房产分割", tablelists: 房产分割 as! [tablelist])
        let 探视权scene = detailscene(title: "房产分割", tablelists: 房产分割 as! [tablelist])
        let 婚前债务scene = detailscene(title: "房产分割", tablelists: 房产分割 as! [tablelist])
        let 夫妻共同债务scene = detailscene(title: "房产分割", tablelists: 房产分割 as! [tablelist])

        var 离婚场景detail = [detailscene?]()
        离婚场景detail += [房产分割scene,净身出户scene,婚前财产分割scene,共同财产scene,不愿意离婚scene,夫妻感情破裂scene,离婚赔偿scene,彩礼返还scene,孩子归谁抚养scene,子女抚养费scene,变更抚养权scene,探视权scene,婚前债务scene,夫妻共同债务scene]
        
        let 离婚场景scene = scene(title: "离婚场景", detailscenes: 离婚场景detail as! [detailscene])

        scenes.append(离婚场景scene!)
        
        searchList += [房产分割1,房产分割2,房产分割3,房产分割4]
        
        
        
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
