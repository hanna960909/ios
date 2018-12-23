//
//  DogDetailViewController.swift
//  JHN_Project
//
//  Created by 조서현 on 2018. 12. 23..
//  Copyright © 2018년 조서현. All rights reserved.
//

import UIKit

class DogDetailViewController: UIViewController {
    @IBOutlet weak var img: UIImageView!
    
    var variety: String!
    var image: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = try? Data(contentsOf: URL(string:image)!) {
            let dogimg = UIImage(data: data)
            img.image = dogimg
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
