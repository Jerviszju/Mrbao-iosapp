//
//  CaseTableViewController.swift
//  Mrbao
//
//  Created by Albert Ray on 2017/5/17.
//  Copyright © 2017年 金鹏. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class CaseTableViewController: UITableViewController {
    // MARK: 属性
    
    var cases = [Case]()

    // MARK: 生命周期

    // 载入时
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleCase()
    }
    
    var ref: DatabaseReference? = Database.database().reference(withPath: "readCount") // 路径的引用
    
    private func loadSampleCase(){
        let icon1 = UIImage(named: "icon06")
        let title1 = "医患沟通纠纷案例分析"
        let img1 = UIImage(named: "case01")
        let content1 = "患者，男性，68岁，汉族，丧偶独居，退休工人，家庭经济状况一般。患者双眼均患有老年性白内障，左眼视力0.2，右眼视力0.3，经常规检查后收住入院，欲行白内障摘除术。在术前各项检查和手术中，各位医生与患者均未再次确认手术眼别，而将右眼进行了白内障摘除手术，并植入了人工晶体，手术顺利，术后视力有所提高。但术后患者却提出原本希望治疗的是左眼，而手术眼术后视力与术前比较无明显提高，因此，患者及其家属提出异议。\n 解析： \n 医者应当时刻牢记我们面对的不仅是患者的疾病，更是活生生的病人，在医患关系中，医方更多地处于主动地位，更有义务针对不同年龄、不同性格的患者给予关心和疏导。特别是在接受手术或特殊的检查之前，主刀或主管医生有必要与患者进行必要的交流，向患者介绍相关的医学常识、注意事项，关心患者的意愿和情绪，解除患者内心的恐惧、疑虑，这样不仅能建立良好的医患关系，更重要的是让患者配合医方接受必要的检查和治疗，并能避免不必要的医疗纠纷。"
        var readCount1: Int = 0
        
        let icon2 = UIImage(named: "icon14")
        let title2 = "离婚房产权分配"
        let img2 = UIImage(named: "case02")
        let content2 = "离婚房产权分配的内容"
        var readCount2: Int = 0
        
        if let ref = ref {
            ref.observe(DataEventType.value, with: { (snapshot) in
                if let dict = snapshot.value as? [String:Int] {
                    for (key,value) in dict {
                        if key.isEqual(title1){
                            readCount1 = value
                            let case1 = Case(icon: icon1, title: title1, content: content1,img: img1, readCount: readCount1)
                            self.cases.append(case1!)
                        }
                        if key.isEqual(title2){
                            readCount2 = value
                            let case2 = Case(icon: icon2, title: title2, content: content2, img: img2, readCount: readCount2)
                            self.cases.append(case2!)
                        }
                        self.tableView.reloadData()
                    }
                }
            })
        }
    }

    // MARK: 管理TableView
    
    // TableView中的Section数量
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Section中的Row数量
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cases.count
    }

    // Row中的Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CaseTableViewCell", for: indexPath) as! CaseTableViewCell
        
        let myCase = cases[indexPath.row]
        cell.icon.image = myCase.icon
        cell.title.text = myCase.title
        cell.img.image = myCase.img
//        cell.readCount.setTitle(String(myCase.readCount), for: UIControlState.normal)
        cell.readCount.text = String(describing: myCase.readCount)
        return cell
    }
    
    @IBAction func unwindToCaseList(sender: UIStoryboardSegue) {
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    var refCaseHistory: DatabaseReference? = Database.database().reference(withPath: "caseHistory") // 路径的引用
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        if segue.identifier ?? "" == "showcase"{
            guard let selectedCell = sender as? CaseTableViewCell else{
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let caseDetailViewController = segue.destination as? CaseDetailViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedCell) else{
                fatalError("The selected cell is not being displayed by the table")
            }
            caseDetailViewController.mycase = cases[indexPath.row]
            cases[indexPath.row].readCount += 1
            if let ref = ref {
                let count = cases[indexPath.row].readCount
                ref.child(cases[indexPath.row].title).setValue(count)
            }
            if let refCaseHistory = refCaseHistory {
                let user = Auth.auth().currentUser
                let title = cases[indexPath.row].title
                refCaseHistory.child((user?.uid)!).child(title).setValue("\(Int(Date().timeIntervalSince1970))")
            }

//            cases[indexPath.row].readCount += 1
            
//            let selectedDetail = mydetailscene?.tablelists[indexPath.row]
//            tableDetailViewController.myTableList = selectedDetail
        }
    }

}
