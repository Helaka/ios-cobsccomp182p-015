//
//  Helaka_Cobscomp182p_015UITests.swift
//  Helaka-Cobscomp182p-015UITests
//
//  Created by Minu Jayakody on 2/10/20.
//  Copyright © 2020 Minu Jayakody. All rights reserved.
//

import XCTest

class Helaka_Cobscomp182p_015UITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testUIAuthentication(){
        
        let app = XCUIApplication()
        app.tabBars.buttons["Profile"].tap()
        
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.tap()
        
        let loginButton = app.buttons["Login"]
        loginButton.tap()
        emailTextField.tap()
        app.secureTextFields["Password"].tap()
        loginButton.tap()
        loginButton.tap()
        loginButton.tap()
        
    }
    

}
