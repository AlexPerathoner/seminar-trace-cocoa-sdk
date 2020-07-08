//
//  TraceTests.swift
//  Trace
//
//  Created by Shams Ahmed on 21/05/2019.
//  Copyright © 2020 Bitrise. All rights reserved.
//

import Foundation
import UIKit
import XCTest
@testable import Trace

final class TraceTests: XCTestCase {
    
    // MARK: - Setup
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    // MARK: - Tests
    
    func testCreateSDK() {
        let trace = Trace.shared
        let configuration = Trace.configuration
        
        XCTAssertNotNil(trace)
        XCTAssertNotNil(configuration)
    }
    
    func testCreateSDK_customConfiguration() {
        let configuration = Configuration.default
        configuration.logs = false
        
        let trace = Trace.shared
        Trace.configuration = configuration
        
        XCTAssertNotNil(trace)
        XCTAssertNotNil(configuration)
        XCTAssertEqual(Trace.configuration, configuration)
    }
    
    func testCreateSDK_reset() {
        Trace.reset()
        
        XCTAssertNotEqual(Trace.currentSession, 0.0)
    }
    
    func testCreateSDK_foreground() {
        Trace.shared.didComeBackToForeground()
        
        XCTAssertNotEqual(Trace.currentSession, 0.0)
    }
    
    func testUIViewController_customName() {
        let viewController = UIViewController()
        viewController.title = "Test"

        XCTAssertNotNil(viewController.trace)
        XCTAssertFalse(viewController.trace.isComplete)
        XCTAssertNotNil(viewController.trace.root)
        XCTAssertEqual(viewController.trace.root.name.value as! String, "Test (UIViewController)")
        XCTAssertEqual(viewController.trace.spans.count, 1)
    }
    
    func testUIViewController_noCustomName() {
        let viewController = UIViewController()

        XCTAssertNotNil(viewController.trace)
        XCTAssertFalse(viewController.trace.isComplete)
        XCTAssertNotNil(viewController.trace.root)
        XCTAssertEqual(viewController.trace.root.name.value as! String, "UIViewController")
        XCTAssertEqual(viewController.trace.spans.count, 1)
    }
    
    func testUIViewController_customClass() {
        class CustomViewController: UIViewController { }
        
        let viewController = CustomViewController()
        
        XCTAssertNotNil(viewController.trace)
        XCTAssertFalse(viewController.trace.isComplete)
        XCTAssertNotNil(viewController.trace.root)
        XCTAssertEqual(viewController.trace.root.name.value as! String, "CustomViewController")
        XCTAssertEqual(viewController.trace.spans.count, 1)
    }
    
    func testUIViewController_customClassAndName() {
        class CustomViewController: UIViewController { }
        
        let viewController = CustomViewController()
        viewController.title = "Custom"
        
        XCTAssertNotNil(viewController.trace)
        XCTAssertFalse(viewController.trace.isComplete)
        XCTAssertNotNil(viewController.trace.root)
        XCTAssertEqual(viewController.trace.root.name.value as! String, "Custom (CustomViewController)")
        XCTAssertEqual(viewController.trace.spans.count, 1)
    }
}
