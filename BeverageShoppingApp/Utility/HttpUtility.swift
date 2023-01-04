//
//  HttpUtility.swift
//  BeverageShoppingApp
//
//  Created by Shriram Kadam on 04/01/23.
//

import Foundation

struct HttpUtility {
  public func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(_ result: T?)-> Void)
    {
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            if(error == nil && responseData != nil && responseData?.count != 0)
            {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    _=completionHandler(result)
                }
                catch let error{
                    print("error occured while decoding = \(error)")
                }
            }
        }.resume()
    }
}
