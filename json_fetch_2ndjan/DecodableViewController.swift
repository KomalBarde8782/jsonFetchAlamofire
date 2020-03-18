//
//  DecodableViewController.swift
//  json_fetch_2ndjan
//
//  Created by Komal Barde on 06/01/2020.
//  Copyright © 2020 Komal Barde. All rights reserved.
//

import UIKit
import Alamofire

class DecodableViewController: UIViewController {

    var parentDecodedArray = [Categories]()
      var childDecodedDta = [childrenData]()
    var dataBetlaArray = [DataBesel]()
    
    var fiveMinArray = [FiveMin_Record]()
    var tenminArray = [Tenmin_record]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.fetchBesalData()
        self.fetchDaminiData()
    }
    
    func fetchnewChildParentJson(){
           Alamofire.request(mockyUrl).responseJSON { (response) in

                  switch response.result {
                  case .success:
                      if((response.result) != nil) {
                          let dataJson = response.data
                          
                          do{
                          let root = try JSONDecoder().decode(Root.self, from: dataJson!)
                          let user = root.response
                           print("root is :\(root.response.name)")
                             
                          }catch {
                              print("Error: \(error)")
                          }
                          
                      }
                  case .failure(let error):
                      print(error)
                  }
              }
       }
       
       func fetchDecodedChildParentJson(){
           Alamofire.request(childParentUrl).responseJSON { (response) in

                  switch response.result {
                  case .success:
                      if((response.result) != nil) {
                          let dataJson = response.data

                          do{
                          let root = try JSONDecoder().decode(NewRootModel.self, from: dataJson!)
                           print("root is :\(root.categories)")
                           var cat = root.categories
                           for category in cat{
                               self.parentDecodedArray.append(category)
                               
                               for child in category.children_data{
                                   self.childDecodedDta.append(child)
                               }
                           }
                          
                           print("parent array count :\(self.parentDecodedArray.count)")
                           print("child decode data count is :\(self.childDecodedDta.count)")
                          }catch {
                              print("Error: \(error)")
                          }

                      }
                  case .failure(let error):
                      print(error)
                  }
              }
       }
 
    func fetchBesalData(){
        Alamofire.request(BestlaUrl).responseJSON { (response) in
            switch response.result{
            case .success(_):
                if response.result != nil{
                    let dataJson = response.data
                    do {
                        let base =  try JSONDecoder().decode(BaseData.self, from: dataJson!)
                        print("status :\(base.status)")
                        print("message is :\(base.message)")
                        let data = base.data
                        for datas in data{
                            self.dataBetlaArray.append(datas)
                        }
                        print("data array is :\(self.dataBetlaArray.map{$0.country})")
                    } catch {
                         print("Error: \(error)")
                    }
                }
                break
            case .failure(_):
                print("failure")
            
        }
        
        }

}
    
   func fetchDaminiData(){
           Alamofire.request(DAminiAppURl).responseJSON { (response) in
               switch response.result{
               case .success(_):
                   if response.result != nil{
                       let dataJson = response.data
                       do {
                           let base =  try JSONDecoder().decode(Damini_Object.self, from: dataJson!)
                        if let fiveMinArray = base.lightning_data?.min_record_5{
                            self.fiveMinArray = fiveMinArray
                            print("array is :\(self.fiveMinArray)")
                        }
                       } catch {
                            print("Error: \(error)")
                       }
                   }
                   break
               case .failure(_):
                   print("failure")
               
           }
           
           }

   }
    
    
}



struct BaseData : Decodable {
    let status : String = ""
    let message : String = ""
    let data : [DataBesel]


}
struct DataBesel:Decodable {
    var id : String = ""
    var name: String = ""
    var country:  String = ""
    var city:String = ""
    var imgURL :String = ""
}

struct Root : Decodable {
   let status: String
   let response: User
}

struct User: Decodable {
    let id: String
    let name: String
}
class NewRootModel : Decodable {
    var success : String
    var categories : [Categories]
}

class Categories:Decodable {
    var id : Int = 0
    var parent_id : Int = 0
    var name : String = ""
    var is_active : Bool = false
    var position : Int = 0
    var level : Int = 0
    var product_count : Int = 0
    var children_data : [childrenData]
    
}
class childrenData: Decodable{
    var id : Int = 0
    var parent_id : Int = 0
    var name : String = ""
    var is_active : Bool = false
    var position : Int = 0
    var level : Int = 0
    var product_count : Int = 0
}








