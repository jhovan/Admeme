//
//  AdmemeUITests.swift
//  AdmemeUITests
//
//  Created by Jhovan Gallardo on 13/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import XCTest

class AdmemeUITests: XCTestCase {

    var url: URL?
    

    func testVerTodo() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        XCTAssert(app.navigationBars["Admeme"].buttons["Add"].exists)
        XCTAssert(app.navigationBars["Admeme"].buttons["Seleccionar"].exists)
    }
    
    func testFavoritos() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Favoritos"].tap()
        XCTAssert(app.navigationBars["Tus Favoritos"].buttons["Seleccionar"].exists)
        
    }
    
    func testCategorias() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        XCTAssert(app.tabBars.buttons["Agrupar"].exists)
    }
    
    func testSeleccionar() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.navigationBars["Admeme"].buttons["Seleccionar"].tap()
        
        let element = app.toolbars["Toolbar"].children(matching: .other).element.children(matching: .other).element
        
        XCTAssert(element.children(matching: .button).matching(identifier: "Item").element(boundBy: 1).exists)
        XCTAssert(element.children(matching: .button).matching(identifier: "Item").element(boundBy: 0).exists)
        
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
