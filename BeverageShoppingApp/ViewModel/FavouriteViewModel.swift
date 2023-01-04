//
//  FavouriteViewModel.swift
//  BeverageShoppingApp
//
//  Created by Shriram Kadam on 04/01/23.
//

import Foundation
//import Combine

class FavouriteViewModel: ObservableObject {
    @Published var results: [Product] = []
    
  public func getFavouriteItems()
    {
        let productRequest = ProductsRequest()
        let productsResource = ProductsResource()
        productsResource.getAllProducts(productsRequest: productRequest) { (productApiResponse) in
            debugPrint("All Products data: \(String(describing: productApiResponse))")
            DispatchQueue.main.async { [weak self] in
                self?.results = productApiResponse?.products ?? []
            }
        }
    }
}
