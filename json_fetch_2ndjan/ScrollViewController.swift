//
//  ScrollViewController.swift
//  json_fetch_2ndjan
//
//  Created by Komal Barde on 04/02/2020.
//  Copyright © 2020 Komal Barde. All rights reserved.
//

import UIKit
import Alamofire

class ScrollViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)

      let origin = "\(37.778483),\(-122.513960)"
         let destination = "\(37.706753),\(-122.418677)"
           let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin),&destination=\(destination)&sensor=false&mode=driving&key=AIzaSyBPKfpeN4h1c49MMHDX2z4RqU-KB7po7CA")!
        print("url is :\(url)")
        Alamofire.request(url).responseJSON { response in
          
            switch response.result{
            case .success(let  JSON) :
                print("json is :\(JSON)")
                
            case .failure(_):
                print("fail")
            }
       
    }
        
    }
    

}
