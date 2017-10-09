//
//  GestureNavigationControllerTests.swift
//  GestureNavigationControllerTests
//
//  Created by Stephen Wingchi Wong on 10/9/17.
//  Copyright © 2017 S. Wingchi Wong. All rights reserved.
//

import XCTest
@testable import GestureNavigationController

final class GestureNavigationControllerTests: XCTestCase {
    let gestureNavigationController = GestureNavigationController()
    
    func testHandleNavigationBeganAndChanged() {
        
        let testPointRight = CGPoint(x: 5.0, y: 0.0) // right
        let testPointLeft = CGPoint(x: -5.0, y: 0.0) // left
        let testPointDown = CGPoint(x: 0.0, y: 5.0) // down
        let testPointUp = CGPoint(x: 0.0, y: -5.0) // up
        gestureNavigationController.handleNavigation(for: .began, translation: testPointRight)
        XCTAssertEqual(gestureNavigationController.panDirection, .right)
        gestureNavigationController.handleNavigation(for: .began, translation: testPointLeft)
        XCTAssertEqual(gestureNavigationController.panDirection, .left)
        gestureNavigationController.handleNavigation(for: .began, translation: testPointDown)
        XCTAssertEqual(gestureNavigationController.panDirection, .down)
        gestureNavigationController.handleNavigation(for: .began, translation: testPointUp)
        XCTAssertEqual(gestureNavigationController.panDirection, .up)
        gestureNavigationController.handleNavigation(for: .changed, translation: testPointUp)
        XCTAssertEqual(gestureNavigationController.panDirection, .up)
    }
    
    func testHandleNavigationDefault() {
        let testPoint = CGPoint(x: 5.0, y: 5.0) // right
        gestureNavigationController.handleNavigation(for: .cancelled, translation: testPoint)
        XCTAssertNil(gestureNavigationController.panDirection)
        XCTAssertNil(gestureNavigationController.nextVC)
        
        gestureNavigationController.handleNavigation(for: .ended, translation: testPoint)
        XCTAssertNil(gestureNavigationController.panDirection)
        XCTAssertNil(gestureNavigationController.nextVC)
        
        gestureNavigationController.handleNavigation(for: .failed, translation: testPoint)
        XCTAssertNil(gestureNavigationController.panDirection)
        XCTAssertNil(gestureNavigationController.nextVC)
        
        gestureNavigationController.handleNavigation(for: .possible, translation: testPoint)
        XCTAssertNil(gestureNavigationController.panDirection)
        XCTAssertNil(gestureNavigationController.nextVC)
    }
}
