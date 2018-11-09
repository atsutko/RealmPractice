//
//  CustomMemoListViewController.swift
//  RealmPractice
//
//  Created by TakaoAtsushi on 2018/11/02.
//  Copyright © 2018 TakaoAtsushi. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class CustomMemoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var customMemoList: [CustomMemo] = []
    
    @IBOutlet weak var customMemoListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customMemoListTableView.dataSource = self
        customMemoListTableView.delegate = self
        
        let nib = UINib(nibName: "CustomMemoTableViewCell", bundle: Bundle.main)
        customMemoListTableView.register(nib, forCellReuseIdentifier: "customMemoCell")
        
        customMemoListTableView.rowHeight = 240.0
        
        customMemoList = CustomMemo.loadAll()
        
        customMemoListTableView.tableFooterView = UIView()
        
    }
    
    
    //textfield delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //tableview datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.customMemoList.count == nil {
            return 0
        } else {
            return self.customMemoList.count
        }    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMemoCell") as! CustomMemoTableViewCell
        let customMemo: CustomMemo = self.customMemoList[indexPath.row]
        
        cell.titleLabel.text = customMemo.memo
        cell.detailTextView.text = customMemo.detail
        cell.memoImageView.image = customMemo.image
        
        return cell
    }
    
    
    @IBAction func memoAdd() {
        self.performSegue(withIdentifier:  "toAdd", sender: nil)
    }
    
    @IBAction func delete() {
        let alertController = UIAlertController(title: "削除",message: "全てを削除します。よろしいですか？", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            CustomMemo.deleteAll()
        }
        let cancelButton = UIAlertAction(title: "CANCEL", style: .cancel) { (action) in
            
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelButton)
        present(alertController,animated: true,completion: nil)
    }
    
}
