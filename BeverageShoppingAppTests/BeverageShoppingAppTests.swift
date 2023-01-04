//
//  BeverageShoppingAppTests.swift
//  BeverageShoppingAppTests
//
//  Created by Shriram Kadam on 04/01/23.
//

import XCTest
import Combine
import SwiftUI
@testable import BeverageShoppingApp

final class BeverageShoppingAppTests: XCTestCase {
    let app: XCUIApplication! = nil
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    // Mark:- Tests Welcome to Product
    func testWelcome() throws {
       app?.launch()
        let welcome = app?.staticTexts["Product List"]
        print(welcome as Any)
    }
    
    // Mark:- Tap on Product image, prduct title,favourite and card button
    func testViewClickableEvents() throws {
        let productTitle = app?.textFields["Diamond Label Shiraz"]
        productTitle?.tap()
        productTitle?.typeText("Diamond Label Shiraz")
        app?.buttons["cart.fill"].doubleTap()
        app?.buttons["checkmark"].tap()
        app?.buttons["heart.fill"].tap()
        app?.buttons["heart"].tap()
        app?.images["https://media.danmurphys.com.au/dmo/product/23124-1.png?impolicy=PROD_SM"].tap()
    }
    
    // Mark:- Tap on Product cell
    func testViewCellTap() throws {
        app?.cells["ProductListCellView"].buttons.element(boundBy: 2).tap()
        app?.textFields.element.tap()
        app?.keys["S"].tap()
        app?.keys["h"].tap()
        app?.keys["i"].tap()
        app?.keys["r"].tap()
        app?.keys["a"].tap()
        app?.keys["z"].tap()
        
        app?.images["cart.fill"].tap()
        app?.images["checkmark"].tap()
        app?.images["heart.fill"].tap()
        app?.images["heart"].tap()
        app?.images["https://media.danmurphys.com.au/dmo/product/23124-1.png?impolicy=PROD_SM"].tap()
    }
    
    // Mark:- Tests ViewModel from product list
    func testViewModel() throws {

        let viewModel = ProductViewModel()
        let testProduct = Product(title: "Diamond Label Shiraz", id: "23124", imageURL: "https://www.kasandbox.org/programming-images/avatars/starky-ultimate.png", price: [], brand: "Rosemount", ratingCount: 4.0, isAddToCartEnable: true, isInWishlist: true, totalReviewCount: 11)
        print(testProduct)
        XCTAssertTrue(viewModel.results.isEmpty, "Product array is empty")
        XCTAssertTrue(viewModel.results.count == 0, "Product array is empty")
    }

    // Mark:- Tests if the Network Manager can get data from the api

    func testNetworkManager() throws {
        let url = URL(string: "https://run.mocky.io/v3/2f06b453-8375-43cf-861a-06e95a951328")!
        let productRequest = ProductsRequest()
        var result: [Product] = []
        print(result)
        print(url)
        let productsResource = ProductsResource()
        productsResource.getAllProducts(productsRequest: productRequest) { (productApiResponse) in
            debugPrint("All Products data: \(String(describing: productApiResponse))")
            result = productApiResponse?.products ?? []
        }
    }

    // Mark:-Tests the computed properties of the data model
    func testModelComputedProperties() throws {
        let product: Product = Product(title: "Diamond Label Shiraz", id: "23124", imageURL: "https://www.kasandbox.org/programming-images/avatars/starky-ultimate.png", price: [], brand: "Rosemount", ratingCount: 4.0, isAddToCartEnable: true, isInWishlist: true, totalReviewCount: 11)

        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yyyy"
        let testDate = formatter.date(from: "12/14/2022")
        print(testDate as Any)
        XCTAssertTrue(product.imageURL !=  "https://dummyimage.com/600", "Couldn't unwrap the image url")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
