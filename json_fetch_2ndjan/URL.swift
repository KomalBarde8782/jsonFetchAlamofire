//
//  URL.swift
//  json_fetch_2ndjan
//
//  Created by Komal Barde on 06/01/2020.
//  Copyright © 2020 Komal Barde. All rights reserved.
//

import Foundation
import Alamofire


var hardJsonUrl = "https://ergast.com/api/f1/2004/1/results.json"
var childParentUrl = "https://www.emaxme.com/api1/category.php?lang=s001"
var whetherUrl = "https://samples.openweathermap.org/data/2.5/forecast?id=524901&appid=b1b15e88fa797225412429c1c50c122a1"
var SolanceUrl = "https://www.arttoframe.com/cfqaapi/v4/index.php" //let para : Parameters = ["action" :"getAllFrames"]
var mockyUrl = "http://www.mocky.io/v2/5a796fb92e00002a009a5a49"
var stationurl = "https://feeds.citibikenyc.com/stations/stations.json"
let organizationurl = "https://projects.propublica.org/nonprofits/api/v2/search.json?order=revenue&sort_order=desc"
let jsonArrayUrl = "http://jsonplaceholder.typicode.com/users"
var stackUrl = "https://api.stackexchange.com/2.2/questions?order=desc&sort=votes&site=stackoverflow"
let marvelHerosUrl = "https://simplifiedcoding.net/demos/marvel/" // Array of dic
let webUrl = "https://api.github.com/users/mralexgray"
let contactUrl="https://api.androidhive.info/contacts"
let heroStatsUrl="https://api.opendota.com/api/heroStats"
var apilayer = "http://www.apilayer.net/api/live?access_key=ad847a0a855c0647590df2b818923025"
var rawApi = "https://raw.githubusercontent.com/sua8051/AlamofireMapper/master/user1.json"
let BestlaUrl = "https://demonuts.com/Demonuts/JsonTest/Tennis/json_parsing.php"
let DAminiAppURl =  "http://103.251.184.43/json/generate_file.php?action=lightning"



//post urls
var postUrl =  "http://appsplanet.co.in/dropnrun/?r=Bookings/Get"
let headers = ["Content-Type":"application/json","Api-Key":"3dbf6efb811695658bf9f55bb086dfce"] // headers for post url
let para : Parameters = ["userId":"2"] //params for post url

let postOneUrl = "https://jsonplaceholder.typicode.com/posts"
let postOneUrlheaders = ["Content-Type":"application/json"]
let postOneUrlpara : Parameters = ["title": "foo","body": "bar","userId": "1"]


