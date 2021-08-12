//
//  Popcorn_AppTests.swift
//  Popcorn AppTests
//
//  Created by Lucas Pereira on 10.08.21.
//

import XCTest
@testable import Popcorn_App

enum TestError: Error {
    case generic
}

func given<A>(_ description: String, block: (XCTActivity) throws -> A) rethrows -> A {
    return try XCTContext.runActivity(named: "Given " + description, block: block)
}

func when<A>(_ description: String, block: (XCTActivity) throws -> A) rethrows -> A {
    return try XCTContext.runActivity(named: "When " + description, block: block)
}

func then<A>(_ description: String, block: (XCTActivity) throws -> A) rethrows -> A {
    return try XCTContext.runActivity(named: "Then " + description, block: block)
}
