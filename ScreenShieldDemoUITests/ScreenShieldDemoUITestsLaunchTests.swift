//
//  ScreenShieldDemoUITestsLaunchTests.swift
//  ScreenShieldDemoUITests
//
//  Created by 熊进辉 on 2025/7/4
//  Copyright © 2025/7/4 datacloak. All rights reserved.
//
    

import XCTest

final class ScreenShieldDemoUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
