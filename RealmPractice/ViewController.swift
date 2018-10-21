//
//  ViewController.swift
//  RealmPractice
//
//  Created by TakaoAtsushi on 2018/10/21.
//  Copyright © 2018 TakaoAtsushi. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var memoTextField: UITextField!
    @IBOutlet weak var memoTableView: UITableView!
    
    var memoList: Results<SingleMemo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoTableView.dataSource = self
        memoTableView.delegate = self
        
        memoTextField.delegate = self
        
        let realm = try! Realm()
        self.memoList = realm.objects(SingleMemo.self)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //textfield delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //tableview delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.memoList.count == nil {
            return 0
        } else {
            return self.memoList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let singleMemo: SingleMemo = self.memoList[indexPath.row]
        cell.textLabel?.text = singleMemo.memo
        
        return cell
    }

    @IBAction func save(_ sender: Any) {
        
        let alertController = UIAlertController(title: "保存",message: self.memoTextField.text! + "を保存しますか？", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            let singleMemo: SingleMemo = SingleMemo()
            singleMemo.memo = self.memoTextField.text!
            
            let realm = try! Realm()
            try! realm.write {
                realm.add(singleMemo)
            }
            
        }
        let cancelButton = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelButton)
        
        present(alertController,animated: true,completion: nil)
    }
    
    @IBAction func read(_ sender: Any) {
        let realm = try! Realm()
        self.memoList = realm.objects(SingleMemo.self)
        memoTableView.reloadData()
    }
    
}

