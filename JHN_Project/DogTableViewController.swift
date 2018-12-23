//
//  ViewController.swift
//  JHN_Project
//
//  Created by 조서현 on 2018. 12. 23..
//  Copyright © 2018년 조서현. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Dog {
    var variety: String!
    var image: String!
}

class DogTableViewController: UITableViewController {
    var ref: DatabaseReference!
    var dogs: [Dog] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    override func viewWillAppear(_ animated: Bool) {
        resolveDog()
    }

    
    func resolveDog() {
        self.dogs.removeAll()
        
        ref.child("dogcat/dog").observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                let node = child as! DataSnapshot
                let dog = node.value as! [String: String]
                
                var newItem = Dog()
                newItem.variety = dog["variety"]
                newItem.image = dog["detail"]
                
                self.dogs.append(newItem)
                print(self.dogs.count)
                
            }
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell", for: indexPath)
        let dog = dogs[indexPath.row]
        cell.textLabel?.text = dog.variety
        return cell
        }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogs.count
    }

     var selectedCell = Dog()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare")
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    selectedCell = dogs[indexPath.row]
                }
        
                let nextview = segue.destination as! DogDetailViewController
        
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


