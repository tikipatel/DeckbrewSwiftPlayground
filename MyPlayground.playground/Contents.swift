import UIKit
import Foundation
import XCPlayground

class Card: Mappable {
    var name: String?
    var id: String?
    var url: String?
    var store_url: String?
    var types: [String]?
    var colors: [String]?
    var cmc: String?
    var cost: String?
    var text: String?
    //    var formats: [String: String]?
    //    var editions: [Edition]?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        id <- map["id"]
        url <- map["url"]
        store_url <- map["store_url"]
        types <- map["types"]
        colors <- map["colors"]
        cmc <- map ["cmc"]
        cost <- map["cost"]
        text <- map["text"]
        //        formats <- map["formats"]
        //        editions <- map["eiditions"]
        
    }
    
}

class Edition: Mappable {
    var set: CardSet?
    var url: NSURL?
    var image_url: NSURL?
    var set_url: NSURL?
    var store_url: NSURL?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
}

class CardSet: Mappable {
    var set: String?
    var set_id: String?
    var rarity: String?
    var artist: String?
    var multiverse_id: String?
    var number: Int?
    var flavor: String?
    var layout: String?
    var price: Price?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
}

class Price: Mappable {
    var low: Double?
    var meidan: Double?
    var high: Double?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
}

let myURLString = "https://api.deckbrew.com/mtg/cards/typeahead?q=sele"
let myURL = NSURL(string: myURLString)!

var myCardsArray = [Card]()
let mySession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
let myDataTask = mySession.dataTaskWithURL(myURL) { (data, response, error) in
    guard error == nil else {
        print("There was error with the task")
        return
    }
    do {
        let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
        print(jsonData)
        for someCard in jsonData as! NSArray {
            let card = Mapper<Card>().map(someCard)
            myCardsArray.append(card!)
        }
        print(myCardsArray)
    } catch {
        print("There was an error")
    }
}

myDataTask.resume()

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
