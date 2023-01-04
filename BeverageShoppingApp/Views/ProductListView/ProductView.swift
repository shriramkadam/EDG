//
//  ProductView.swift
//  BeverageShoppingApp
//
//  Created by Shriram Kadam on 04/01/23.
//

import SwiftUI

struct ProductView: View {
    
    @StateObject var productViewModel = ProductViewModel()
    @Binding var cart:[Product]
    @Binding var favorites:[Product]
    @Binding var products:[Product]
    @State var isHideLoader: Bool = true
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
                NavigationView {
                    ScrollView {
                        
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(productViewModel.results, id: \.id) { product in
                                NavigationLink(destination:
                                                ProductDetailView(product: product, cart: self.$cart, favorites: self.$favorites)
                                    .padding(.horizontal, 16)
                                ) {
                                    ProductListCellView(product: product, cart: self.$cart, favorites: self.$favorites)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                    .navigationBarTitle(Text("Product List"))
                    .padding(.bottom, 50)
                    .onAppear {
                        productViewModel.getAllShoppingItems()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                            self.isHideLoader = false
                        }
                    }
                }
    }
}


