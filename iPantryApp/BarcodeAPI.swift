//
//  BarcodeAPI.swift
//  iPantryApp
//
//  Created by Conner Cook on 5/12/21.
//

import Foundation

struct Response: Codable {
    let products: [ProductInfo]
}

struct ProductInfo: Codable {
    let product_name: String
}

class Product {
    var url: URL
    var barcode: String
    var API_key: String = "ulqsgcj953k2v5fepyvqx8q40e8non"
    var response = [Response]()
    
    init(barcode: String) {
        self.barcode = barcode
        self.url = URL(string: "https://api.barcodelookup.com/v2/products?barcode=\(barcode)&key=\(self.API_key)")!
    }
    func printUrl() {
        print(self.url)
    }
    
    func getData() {
        let task = URLSession.shared.dataTask(with: self.url, completionHandler: {data , response, error in
                guard let data = data, error == nil else{
                    print("Something went wrong")
                    return
                }
            do {
                let res = try JSONDecoder().decode(Response.self, from: data)
                print(res)
                self.response.append(res)
            } catch {
                print(error)
            }
        })
        task.resume()
    }

//struct Response: Codable {
//    let products: [ProductInfo]
//}
//
//struct ProductInfo: Codable {
//    let product_name: String
//}
//
//class Product {
//    var url: String
//    var barcode: String
//    var API_key: String = "pv7k9xe9xgz83gq4sw6nyddehe9zaa"
//
//    init(barcode: String) {
//        self.barcode = barcode
//        self.url = "https://api.barcodelookup.com/v2/products?barcode=\(barcode)&key=\(self.API_key)"
//    }
//
//    func getData(completion: @escaping (Response) -> Void) {
//        let task = URLSession.shared.dataTask(with: URL(string: self.url)!, completionHandler: {data , response, error in
//                guard let data = data, error == nil else{
//                    print("Something went wrong")
//                    return
//                }
//                var result : Response!
//                do{
//                    result = try JSONDecoder().decode(Response.self, from: data)
//                    completion(result)
//                }
//                catch{
//                    print("failed to convert \(error.localizedDescription)")
//                    completion(result)
//                }
//            })
//
//            task.resume()
//    }
//
//
//}
}
