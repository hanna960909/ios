//
//  CatTableViewController.swift
//  JHN_Project
//
//  Created by 조서현 on 2018. 12. 23..
//  Copyright © 2018년 조서현. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Cat {
    var variety: String!
    var image: String!
}

class CatTableViewController: UITableViewController {
    var ref: DatabaseReference!
    var cats: [Cat] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        
    }

    override func viewWillAppear(_ animated: Bool) {
        resolveCat()
    }

    func resolveCat() {
        self.cats.removeAll()
        
        ref.child("dogcat/cat").observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                let node = child as! DataSnapshot
                let cat = node.value as! [String: String]
                
                var newItem = Cat()
                newItem.variety = cat["variety"]
                newItem.image = cat["detail"]
                
                self.cats.append(newItem)
                print(self.cats.count)
                
            }
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath)
        let cat = cats[indexPath.row]
        cell.textLabel?.text = cat.variety
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    var selectedCell = Cat()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare")
        if let indexPath = self.tableView.indexPathForSelectedRow {
            selectedCell = cats[indexPath.row]
        }
        
        let nextview = segue.destination as! CatDetailViewController
        
        print(selectedCell.image)
        if let variety = selectedCell.variety,
            let image = selectedCell.image{
            nextview.variety = variety
            nextview.image = image
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
