//
//  ViewController.swift
//  json_fetch_2ndjan
//
//  Created by Komal Barde on 02/01/2020.
//  Copyright © 2020 Komal Barde. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    var raceArray = [RaceModel]()
    var parentArray = [ParentModel]()
    var childArray = [ChildModel]()
    var listArray = [ListModel]()
    var whetherarray = [whetherModel]()
    
    var dataArray = [dataModel]()
  
    
    var firsttIME_ARRAY = [first_min_model]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //self.fetchHardJsonData()
        //self.fetchChildParentJson()
       // self.fetchWhetherData()
        //self.fetchSolanceData()
       // self.fetchJsonData()
        self.fetchDaminiData()
       
        // Do any additional setup after loading the view.
    }

    func fetchHardJsonData(){
        var url = hardJsonUrl
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
                
            case .success(let JSON):
                //print("SUCCESS WITH JSON :\(JSON)")
                let response = JSON as! NSDictionary
                let Mrdata = response.object(forKey: "MRData") as!NSDictionary
                //print("Mrdata is :\(Mrdata)")
                
                let limit = Mrdata.object(forKey: "limit") as! String
                print("limit is :\(limit)")
                let raceData = Mrdata.object(forKey: "RaceTable") as! NSDictionary
                let season = raceData.object(forKey: "season") as! String
                print("season is :\(season)")
                
                let races = raceData.object(forKey: "Races") as! NSArray
               // print("races is :\(races)")
                for race in races{
                    let temp = race as! NSDictionary
                    let season = temp.object(forKey: "season")as! String
                    print("season is :\(season)")
                    let circuit = temp.object(forKey: "Circuit") as! NSDictionary
                    print("circuit is :\(circuit)")
                    let circuitName = circuit.object(forKey: "circuitName") as! String
                    print("circuit name is :\(circuitName)")
                    let location = circuit.object(forKey: "Location") as! NSDictionary
                    let lat = location.object(forKey: "lat") as! String
                    print("lat is :\(lat)")
                    
                    let results = temp.object(forKey: "Results") as! NSArray
                    
                    for result in results{
                        let tempres = result as! NSDictionary
                        let number = tempres.object(forKey: "number") as! String
                        print("number is :\(number)")
                        let driver = tempres.object(forKey: "Driver") as! NSDictionary
                        
                        let nationality = driver.object(forKey: "nationality") as! String
                        print("nationality is :\(nationality)")
                        
                        let raceModel = RaceModel()
                        raceModel.number = number
                        raceModel.nationality = nationality
                        self.raceArray.append(raceModel)
                    }
                    print("racearray is :\(self.raceArray.map{$0.nationality})")
                }
                
                
            case .failure(_):
                print("error in fetching data")
            
        }
    }
    
    
}
    
    
    func fetchChildParentJson(){
        var url = childParentUrl
        Alamofire.request(url, method: .get,parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
                
            case .success(let JSON):
                print("json is :\(JSON)")
                let responseNew = JSON as! NSDictionary
                let success = responseNew.object(forKey: "success") as! String
                if success == "true"{
                    let categories = responseNew.object(forKey: "categories") as! NSArray
                    for category in categories{
                        let tempCat = category as! NSDictionary
                        var parentModel = ParentModel()
                        var name = tempCat.object(forKey: "name") as! String
                        var procount = tempCat.object(forKey: "product_count")as! Int
                        parentModel.name = name
                        parentModel.product_count = procount
                        var childData = tempCat.object(forKey: "children_data") as! NSArray
                        for child in childData{
                            let tempchild = child as! NSDictionary
                            var model = ChildModel()
                            model.name = tempchild.object(forKey: "name") as! String
                            self.childArray.append(model)
                        }
                        print("child array is :\(self.childArray)")
                        parentModel.child_Data = self.childArray
                        self.parentArray.append(parentModel)
                        self.tableView.reloadData()
                    }
                }
            case .failure(_):
                print("error in fetching")
            
        }
    }
    
}
    
    
    func fetchWhetherData(){
        var url = whetherUrl
        Alamofire.request(url, method: .get,parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
               case .success(let JSON):
                print("json is :\(JSON)")
                var response = JSON as! NSDictionary
                var lists = response.object(forKey: "list") as! NSArray
                
                for list in lists{
                    let temp = list as! NSDictionary
                    var listModel = ListModel()
                    let main = temp.object(forKey: "main") as! NSDictionary
                    let temperature = main.object(forKey: "temp") as! Double
                    listModel.temp = temperature
                    let wind = temp.object(forKey: "wind") as! NSDictionary
                    let speed = wind.object(forKey: "speed") as! Double
                    listModel.speed = speed
                    let whwthwr = temp.object(forKey: "weather") as! NSArray
                    for whether in whwthwr{
                        let tempwhather = whether as! NSDictionary
                        let main = tempwhather.object(forKey: "main") as! String
                        let desr = tempwhather.object(forKey: "description") as! String
                        let wheatherModel = whetherModel()
                        wheatherModel.main = main
                        wheatherModel.description = desr
                        self.whetherarray.append(wheatherModel)
                    }
                    listModel.whether = self.whetherarray
                    self.listArray.append(listModel)
                    self.tableView.reloadData()
                }
                
                 case .failure(_):
                print("eror")
                
                
            }
            
        }
        
        
    }
    
    // check here for post method for alamofire
    func fetchSolanceData(){
       let url = SolanceUrl
               
               let para : Parameters = ["action" :"getAllFrames"]
                  Alamofire.request(url,method: .post, parameters: para, encoding:JSONEncoding.default).responseJSON
                  { response in switch response.result {
                    
                  case .success(let JSON):
                    print("response is :\(response)")
                    var response = JSON as! NSArray
                    for responses in response{
                        let temp = responses as!NSDictionary
                        let name = temp.object(forKey: "name") as! String
                        var price = temp.object(forKey: "framePrice") as! String
                        print("frame price is :\(price)")
                        print("name is \(name)")
                    }
                  case .failure(_):
                print("fail")
            }
        }
          
    }
    
   func fetchJsonData(){
    let url = "https://demonuts.com/Demonuts/JsonTest/Tennis/json_parsing.php"
     Alamofire.request(url, method: .get,parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
               switch response.result{
               case .success(let JSON):
                print("Json is :\(JSON)")
                var newResponse = JSON as! NSDictionary
                var status = newResponse.object(forKey: "status") as! String
                if status == "true"{
                    print("welcome")
                    var data = newResponse.object(forKey: "data") as! NSArray
                    for dataNew in data{
                        var model = dataModel()
                        var temp = dataNew as!NSDictionary
                        var id = temp.object(forKey: "id") as!String
                        var name = temp.object(forKey: "name") as! String
                        var country = temp.object(forKey: "country") as! String
                        var imageUrl = temp.object(forKey: "imgURL") as! String
                        // same for city
                        model.id = id
                        model.name = name
                        model.country = country
                        model.imgUrl = imageUrl
                        self.dataArray.append(model)
                        self.tableView.reloadData()
                    }
                }
                break
                case .failure(_):
                    print("fail")
        }
    }
    }
       
   // omkar code
   
   func fetchDaminiData(){
       
       var url = "http://103.251.184.43/json/generate_file.php?action=lightning"
       Alamofire.request(url, method: .get,parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                  switch response.result{
                  case .success(let JSON):
                   print("Json is :\(JSON)")
                   var newResponse = JSON as! NSDictionary
                   var lightData = newResponse.object(forKey: "lightning_data") as! NSDictionary
                   
                   var one_minData = lightData.object(forKey: "5min_record") as! NSArray
                   
                   for mins in one_minData{
                    var tempMin = mins as! NSDictionary
                    var model = first_min_model()
                    
                      model.latitude = tempMin.object(forKey: "latitude") as! String
                      model.longitude = tempMin.object(forKey: "longitude") as! String
                      model.address = tempMin.object(forKey: "address") as! String
                      model.time = tempMin.object(forKey: "time") as! String
                      self.firsttIME_ARRAY.append(model)
                   }
                   //do same for 10 mins and 15 mins
                   
                   
                   var alert = newResponse.object(forKey: "alert") as! NSDictionary
                   var alert_data = alert_Model()
                   alert_data.red = alert.object(forKey: "red")as! String
                   alert_data.yellow = alert.object(forKey: "yellow")as! String
                   alert_data.greeb = alert.object(forKey: "green")as! String
                  
                   print("alert is :\(alert_data.greeb),\(alert_data.red)")

                   break
                   case .failure(_):
                       print("fail")
           }
       }
   }
    
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        // var obj = self.parentDecodedArray[indexPath.row]//self.listArray[indexPath.row]  //self.parentArray[indexPath.row]
        //cell.textLabel?.text = obj.name//String(obj.speed)
        //cell.detailTextLabel?.text = obj.whether[indexPath.row].description
        let obj = self.dataArray[indexPath.row]
        cell.textLabel?.text = obj.name
        cell.detailTextLabel?.text = obj.country
        let url = URL(string: obj.imgUrl)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        cell.imageView?.image = UIImage(data: data!)
        return cell
    }
}


//omkar data

//5mindata
class first_min_model{
    var latitude : String = ""
    var address : String = ""
    var longitude : String = ""
    var time : String = ""
}

//10 min
class second_min_model{
    var latitude : String = ""
    var address : String = ""
    var longitude : String = ""
    var time : String = ""
}


//15 min

class third_min_model{
    var latitude : String = ""
    var address : String = ""
    var longitude : String = ""
    var time : String = ""
}

class alert_Model{
    var red : String = ""
    var yellow : String = ""
    var greeb : String = ""
}

//omkarData


class dataModel{
    var id : String = ""
    var name : String = ""
    var country : String = ""
    var city : String = ""
    var imgUrl : String = ""
}


class RaceModel {
    var number : String = ""
    var nationality : String = ""
}

class ParentModel {
    var name : String = ""
    var product_count : Int = 0
    var child_Data = [ChildModel]()
    
}

class ChildModel{
    var name : String = ""
    var position : Int = 0
}


class ListModel{
    var temp : Double = 0
    var speed : Double = 0
    var whether = [whetherModel]()
    
}

class whetherModel{
    var main : String = ""
    var description : String = ""
}

