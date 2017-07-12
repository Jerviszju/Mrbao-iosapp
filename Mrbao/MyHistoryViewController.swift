//
//  MyHistoryViewController.swift
//  Mrbao
//
//  Created by boomboooom0v0 on 2017/6/20.
//  Copyright © 2017年 金鹏. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MyHistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var HistoryList: UITableView!
    var refWordsHistory: DatabaseReference? = Database.database().reference(withPath: "wordsHistory") // 路径的引用
    var refCaseHistory: DatabaseReference? = Database.database().reference(withPath: "caseHistory") // 路径的引用
    
    var history = [HistoryData]()
    @IBOutlet weak var segmentOutlet: UISegmentedControl!

    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        if(segmentOutlet.selectedSegmentIndex == 0){
            loadWordsList()
            print("loadWordsList")
        }
        
        if(segmentOutlet.selectedSegmentIndex == 1){
            loadCaseList()
            print("loadCaseList")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HistoryList.delegate = self
        HistoryList.dataSource = self
        
//        loadHistoryList()
        loadWordsList()
        print("loadWordsList")
    }
    
    private func loadWordsList() {
        if let refWordsHistory = refWordsHistory {
            let user = Auth.auth().currentUser
            refWordsHistory.child((user?.uid)!).observe(DataEventType.value, with: { (snapshot) in
                self.history.removeAll()
                if let dict = snapshot.value as? [String:String] {
                    for (key,_) in dict.sorted(by: {$0.1 > $1.1}) {
                        let history1 = HistoryData(list: key)
                        self.history += [history1]

                    }
                }
                self.HistoryList.reloadData()
            })
        }
    }
    
    private func loadCaseList() {
        if let refCaseHistory = refCaseHistory {
            let user = Auth.auth().currentUser
            refCaseHistory.child((user?.uid)!).observe(DataEventType.value, with: { (snapshot) in
                //                print(snapshot)
                self.history.removeAll()
                //                var i = 1
                if let dict = snapshot.value as? [String:String] {
                    for (key,_) in dict.sorted(by: {$0.1 > $1.1}) {
                        //                        self.collections.append(CollectionData(list: value))
                        let history1 = HistoryData(list: key)
                        //                        print(colloction1.list)
                        self.history += [history1]
                        
                        // self.noteList.text.append("\(i)."+value+"\n")
                        //                        i += 1
                        //                        print(value)
                    }
                    //                    print(dict)
                }
                self.HistoryList.reloadData()
            })
        }
        //collectionTxt.reloadData()
        
        //let collection1 = CollectionData(list: "Caprese Salad")
        //collections += [collection1]
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "HistoryTableViewCell"
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HistoryTableViewCell
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HistoryTableViewCell  else {
            fatalError("The dequeued cell is not an instance of CollectionTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let historyx = history[indexPath.row]
        
        cell.HistoryList.text = historyx.list
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
