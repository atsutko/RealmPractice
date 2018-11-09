//
//  CustomMemo.swift
//  RealmPractice
//
//  Created by TakaoAtsushi on 2018/10/23.
//  Copyright © 2018 TakaoAtsushi. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class CustomMemo: Object {
    
    static let realm = try! Realm()
    
    @objc dynamic private var id = 0
    @objc dynamic var memo: String = ""
    @objc dynamic var detail: String = ""
    
    @objc dynamic private var _image: UIImage? = nil
    @objc dynamic var image: UIImage? {
        
        set{
            self._image = newValue
            if let value = newValue {
                self.imageData = value.pngData() as! NSData
            }
        }
        get{
            if let image = self._image {
                return image
            }
            if let data = self.imageData {
                self._image = UIImage(data: data as Data)
                return self._image
            }
            return nil
        }
    }
    
    @objc dynamic private var imageData: NSData? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["image", "_image"]
    }
    
    static func create() -> CustomMemo {
        let customMemo = CustomMemo()
        customMemo.id = lastId()
        return customMemo
    }
    
    static func loadAll() -> [CustomMemo] {
        let memos = realm.objects(CustomMemo.self).sorted(byKeyPath: "id", ascending: false)
        var memoArray: [CustomMemo] = []
        for memo in memos {
            memoArray.append(memo)
        }
        return memoArray
    }
    
    static func deleteAll() {
        let memos = realm.objects(CustomMemo.self)
        try! realm.write {
            realm.delete(memos)
        }
    }
    
    static func lastId() -> Int {
        if let memo = realm.objects(CustomMemo.self).last {
            return memo.id + 1
        } else {
            return 1
        }
    }
    
    func save() {
        try! CustomMemo.realm.write {
            CustomMemo.realm.add(self)
        }
    }
    
    
}
