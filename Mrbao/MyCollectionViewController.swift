//
//  MyCollectionViewController.swift
//  Mrbao
//
//  Created by boomboooom0v0 on 2017/6/19.
//  Copyright © 2017年 金鹏. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MyCollectionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var ref: DatabaseReference? = Database.database().reference(withPath: "collection") // 路径的引用
    @IBOutlet weak var collectionTxt: UITableView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        if let ref = ref {
//            let user = Auth.auth().currentUser
//            ref.child((user?.uid)!).observe(DataEventType.value, with: { (snapshot) in
//                //                print(snapshot)
//                self.collectionTxt.
//                var i = 1
//                if let dict = snapshot.value as? [String:String] {
//                    for (_,value) in dict.sorted(by: {$0.0 > $1.0}) {
//                        self.collectionTxt.text.append("\(i)."+value+"\n")
//                        i += 1
//                        print(value)
//                    }
//                    //                    print(dict)
//                }
//            })
//        }
//
//    }
    var collections = [CollectionData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionTxt.delegate = self
        collectionTxt.dataSource = self
        
        loadCollectionList()
    }
    
    private func loadCollectionList() {
        if let ref = ref {
            let user = Auth.auth().currentUser
            ref.child((user?.uid)!).observe(DataEventType.value, with: { (snapshot) in
                //                print(snapshot)
                self.collections.removeAll()
//                var i = 1
                if let dict = snapshot.value as? [String:String] {
                    for (key,_) in dict.sorted(by: {$0.1 > $1.1}) {
//                        self.collections.append(CollectionData(list: value))
                        let colloction1 = CollectionData(list: key)
//                        print(colloction1.list)
                        self.collections += [colloction1]
                        
                        // self.noteList.text.append("\(i)."+value+"\n")
//                        i += 1
//                        print(value)
                    }
                    //                    print(dict)
                }
                self.collectionTxt.reloadData()
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
        return collections.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "CollectionTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CollectionTableViewCell  else {
            fatalError("The dequeued cell is not an instance of CollectionTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let collection = collections[indexPath.row]
        
        cell.collectionList.text = collection.list
        
        return cell
    }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
