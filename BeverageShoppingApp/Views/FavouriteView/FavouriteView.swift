//
//  FavouriteView.swift
//  BeverageShoppingApp
//
//  Created by Shriram Kadam on 04/01/23.
//


import SwiftUI

struct FavouriteView: View {
    
    @StateObject var favouriteViewModel = FavouriteViewModel()
    @Binding var items:[Product]
    @Binding var cart:[Product]
    @Binding var favorites:[Product]
    @State private var isEditing:Bool = false
    @State var isHideLoader: Bool = true
    
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(items, id: \.id) { item in
                            NavigationLink(destination: ProductDetailView(product: item, cart: self.$cart, favorites: self.$favorites)
                                .padding(.horizontal, 16)
                            ) {
                                ProductListCellView(product: item, cart: self.$cart, favorites: self.$favorites)
                                
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                    
                    ZStack {
                        if items.count == 0 {
                            VStack(alignment: .center, spacing: 4) {
                                Spacer()
                                Image(systemName: "bag.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color.gray)
                                    .frame(width: 40, height: 40, alignment: .center)
                                    .padding(.bottom, 20)
                                    .font(Font.system(size: 16, weight: .bold, design: .rounded))
                                Text("No Products To Display")
                                    .font(Font.system(size: 17, weight: .semibold, design: .rounded))
                                    .foregroundColor(Color.gray)
                                Spacer()
                            }
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                                    self.isHideLoader = false
                                }
                            }
                            
                            .padding(.bottom, 10)
                            .navigationBarTitle("Favourite list", displayMode: .inline)
                        }
                    }
                }
                .navigationBarTitle(Text("Favourite list"))
                .padding(.bottom, 50)
                .onAppear {
                    favouriteViewModel.getFavouriteItems()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        self.isHideLoader = false
                    }
                }
            }
//            .refreshable {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0){
//                    favouriteViewModel.getFavouriteItems()
//                    self.isHideLoader = false
//                }
//            }
    }
}

