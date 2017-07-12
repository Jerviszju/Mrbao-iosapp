//
//  fcfgTableViewController.swift
//  Mrbao
//
//  Created by jinpeng on 2017/6/12.
//  Copyright © 2017年 金鹏. All rights reserved.
//

import UIKit
import os.log
import FirebaseDatabase
import FirebaseAuth

class SceneDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    

    @IBOutlet var leftBarButton: UIBarButtonItem!
    
    var mydetailscene :detailscene? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        leftBarButton.title=" < " + (mydetailscene?.title)!

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (mydetailscene?.tablelists.count)!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sceneDetailTableViewCell", for: indexPath) as? SceneDetailTableViewCell
            else{
            fatalError("The dequeued cell is not an instance of SceneDetailTableViewCell.")
        }
        
        // Configure the cell...
        let mydetailscenecell = mydetailscene?.tablelists[indexPath.row]
        cell.title.text = mydetailscenecell?.title
        cell.content.text = mydetailscenecell?.content
        cell.content.textContainer.maximumNumberOfLines = 4
        cell.content.textContainer.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    @IBAction func unwindToSceneDetailList(sender: UIStoryboardSegue) {
        
    }
    
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    var ref: DatabaseReference? = Database.database().reference(withPath: "wordsHistory") // 路径的引用
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        if segue.identifier ?? "" == "OpenSceneDetail"{
            guard let selectedCell = sender as? SceneDetailTableViewCell else{
                fatalError("Unexpected sender: \(sender)")
            }
            guard let tableDetailViewController = segue.destination as? TableDetailViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedCell) else{
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedDetail = mydetailscene?.tablelists[indexPath.row]
            tableDetailViewController.myTableList = selectedDetail
            if let ref = ref, let title = mydetailscene?.tablelists[indexPath.row].title {
                let user = Auth.auth().currentUser
                ref.child((user?.uid)!).child(title).setValue("\(Int(Date().timeIntervalSince1970))")
            }
        }
    }
}
