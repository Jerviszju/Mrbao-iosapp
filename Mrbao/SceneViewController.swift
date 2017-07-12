//
//  SceneViewController.swift
//  Mrbao
//
//  Created by jinpeng on 2017/6/14.
//  Copyright © 2017年 金鹏. All rights reserved.
//

import UIKit
import os.log
import FirebaseAuth
import FirebaseDatabase

class SceneViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    @IBOutlet var button7: UIButton!
    @IBOutlet var button8: UIButton!
    @IBOutlet var button9: UIButton!
    @IBOutlet var button10: UIButton!
    @IBOutlet var button11: UIButton!
    @IBOutlet var button12: UIButton!
    @IBOutlet var button13: UIButton!
    @IBOutlet var button14: UIButton!
    @IBOutlet var titlebutton1: UIButton!

    @IBOutlet var titlebutton2: UIButton!
    
    @IBOutlet var titlebutton3: UIButton!
    
    @IBOutlet var titlebutton4: UIButton!
    
    var myscene :scene? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToSceneViewList(sender: UIStoryboardSegue) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
//        var ref: DatabaseReference? = Database.database().reference(withPath: "wordsHistory") // 路径的引用
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier ?? "" == "OpenDetailButton1"{
            guard let SceneDetailViewController = segue.destination as? SceneDetailViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            SceneDetailViewController.mydetailscene = myscene?.detailscenes[0]
//            if let ref = ref, let title = button1.titleLabel?.text {
//                let user = Auth.auth().currentUser
//                ref.child((user?.uid)!).child(title).setValue("\(Int(Date().timeIntervalSince1970))")
//            }
        }
        if segue.identifier ?? "" == "OpenDetailButton2"{
            guard let SceneDetailViewController = segue.destination as? SceneDetailViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            SceneDetailViewController.mydetailscene = myscene?.detailscenes[0]
        }
        if segue.identifier ?? "" == "OpenDetailButton3"{
            guard let SceneDetailViewController = segue.destination as? SceneDetailViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            SceneDetailViewController.mydetailscene = myscene?.detailscenes[0]
        }
        if segue.identifier ?? "" == "OpenDetailButton4"{
            guard let SceneDetailViewController = segue.destination as? SceneDetailViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            SceneDetailViewController.mydetailscene = myscene?.detailscenes[0]
        }
        if segue.identifier ?? "" == "OpenDetailButton5"{
            guard let SceneDetailViewController = segue.destination as? SceneDetailViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            SceneDetailViewController.mydetailscene = myscene?.detailscenes[0]
        }
        if segue.identifier ?? "" == "OpenDetailButton6"{
            guard let SceneDetailViewController = segue.destination as? SceneDetailViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            SceneDetailViewController.mydetailscene = myscene?.detailscenes[0]
        }
        if segue.identifier ?? "" == "OpenDetailButton7"{
            guard let SceneDetailViewController = segue.destination as? SceneDetailViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            SceneDetailViewController.mydetailscene = myscene?.detailscenes[0]
        }
        if segue.identifier ?? "" == "OpenDetailButton8"{
            guard let SceneDetailViewController = segue.destination as? SceneDetailViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            SceneDetailViewController.mydetailscene = myscene?.detailscenes[0]
        }
        if segue.identifier ?? "" == "OpenDetailButton9"{
            guard let SceneDetailViewController = segue.destination as? SceneDetailViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            SceneDetailViewController.mydetailscene = myscene?.detailscenes[0]
        }
        if segue.identifier ?? "" == "OpenDetailButton10"{
            guard let SceneDetailViewController = segue.destination as? SceneDetailViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            SceneDetailViewController.mydetailscene = myscene?.detailscenes[0]
        }
        if segue.identifier ?? "" == "OpenDetailButton11"{
            guard let SceneDetailViewController = segue.destination as? SceneDetailViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            SceneDetailViewController.mydetailscene = myscene?.detailscenes[10]
        }
        if segue.identifier ?? "" == "OpenDetailButton12"{
            guard let SceneDetailViewController = segue.destination as? SceneDetailViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            SceneDetailViewController.mydetailscene = myscene?.detailscenes[11]
        }
        if segue.identifier ?? "" == "OpenDetailButton13"{
            guard let SceneDetailViewController = segue.destination as? SceneDetailViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            SceneDetailViewController.mydetailscene = myscene?.detailscenes[12]
        }
        if segue.identifier ?? "" == "OpenDetailButton14"{
            guard let SceneDetailViewController = segue.destination as? SceneDetailViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            SceneDetailViewController.mydetailscene = myscene?.detailscenes[13]
        }

}
    private func LoadData(){
        button1.titleLabel?.text = myscene?.detailscenes[0].title
//        button2.titleLabel?.text = myscene?.detailscenes[1].title
//        button3.titleLabel?.text = myscene?.detailscenes[2].title
//        button4.titleLabel?.text = myscene?.detailscenes[3].title
//        button5.titleLabel?.text = myscene?.detailscenes[4].title
//        button6.titleLabel?.text = myscene?.detailscenes[5].title
//        button7.titleLabel?.text = myscene?.detailscenes[6].title
//        button8.titleLabel?.text = myscene?.detailscenes[7].title
//        button9.titleLabel?.text = myscene?.detailscenes[8].title
//        button10.titleLabel?.text = myscene?.detailscenes[9].title
//        button11.titleLabel?.text = myscene?.detailscenes[10].title
//        button12.titleLabel?.text = myscene?.detailscenes[11].title
//        button13.titleLabel?.text = myscene?.detailscenes[12].title
//        button14.titleLabel?.text = myscene?.detailscenes[13].title
        
    }
}
